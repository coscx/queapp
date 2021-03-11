import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter_geen/views/pages/utils/DyBehaviorNull.dart';
import 'package:flutter_geen/views/pages/utils/common_util.dart';
import 'package:flutter_geen/views/pages/utils/time_util.dart';
import 'package:flutter_geen/views/pages/utils/dialog_util.dart';
import 'package:flutter_geen/views/pages/utils/file_util.dart';
import 'package:flutter_geen/views/pages/utils/functions.dart';
import 'package:flutter_geen/views/pages/utils/image_util.dart';
import 'package:flutter_geen/views/pages/utils/object_util.dart';
import 'package:flutter_geen/views/pages/chat/view/emoji/emoji_picker.dart';
import 'package:flutter_geen/views/pages/chat/view/voice/group_chat_item.dart';
import 'package:flutter_geen/views/pages/chat/widget/Swipers.dart';
import 'package:flutter_geen/views/pages/chat/widget/more_widgets.dart';
import 'package:flutter_geen/views/pages/chat/widget/popupwindow_widget.dart';
import 'package:flutter_geen/views/pages/resource/colors.dart';
import 'package:flutter_geen/blocs/group/group_bloc.dart';
import 'package:flutter_geen/blocs/group/group_event.dart';
import 'package:flutter_geen/blocs/group/group_state.dart';
import 'package:flt_im_plugin/conversion.dart';
import 'package:flt_im_plugin/flt_im_plugin.dart';
import 'package:flt_im_plugin/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frefresh/frefresh.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/*
*  发送聊天信息
*/
class GroupChatPage extends StatefulWidget {

  final Conversion model;
  GroupChatPage({this.model});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GroupChatState();
  }
}

class GroupChatState extends State<GroupChatPage> {
  bool _isBlackName = false;
  var _popString = List<String>();
  bool _isShowSend = false; //是否显示发送按钮
  bool _isShowVoice = false; //是否显示语音输入栏
  bool _isShowFace = false; //是否显示表情栏
  bool _isShowTools = false; //是否显示工具栏
  var voiceText = '按住 说话';
  var voiceBackground = ObjectUtil.getThemeLightColor();
  Color _headsetColor = ColorT.gray_99;
  Color _highlightColor = ColorT.gray_99;
  List<Widget> _guideFaceList = new List();
  List<Widget> _guideFigureList = new List();
  List<Widget> _guideToolsList = new List();
  bool _isFaceFirstList = true;
  bool _alive = false;
  String _audioIconPath = '';
  String _voiceFilePath = '';
  String tfSender="0" ;
  FltImPlugin im = FltImPlugin();
  FRefreshController controller3;
  bool _isLoading = false;
  Permission _permission;
  Timer _timer;
  int voiceCount = 0;
  StreamSubscription _recorderSubscription;
  StreamSubscription _playerSubscription;
  // StreamSubscription _dbPeakSubscription;
  FlutterSoundRecorder flutterSound;
  TextEditingController _controller = new TextEditingController();
  ScrollController _scrollController = new ScrollController();
  FocusNode _textFieldNode = FocusNode();
  FlutterSoundRecorder recorderModule = FlutterSoundRecorder();
  FlutterSoundPlayer playerModule = FlutterSoundPlayer();
  double progress = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _alive = true;
    tfSender =widget.model.memId;
    controller3 = FRefreshController();
    _textFieldNode.addListener(_focusNodeListener); // 初始化一个listener
    _getLocalMessage();
    _initData();
    _checkBlackList();
    _getPermission();
    _scrollController.addListener(() {
      if (!mounted) {
        return;
      }
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent+100.h) {

        if (_isLoading) {
          return;
        }

        if (mounted) {
          setState(() {
            _isLoading = true;
          });
        }



        BlocProvider.of<GroupBloc>(context).add(EventGroupLoadMoreMessage());
        Future.delayed(Duration(milliseconds: 150), () {
          _onRefresh();
          if (mounted) {
            setState(() {
              _isLoading = false;
            });
          }
        });
      }
    });
    init();
  }
  Future<void> _initializeExample(bool withUI) async {

    await playerModule.closeAudioSession();

    await playerModule.openAudioSession(
        focus: AudioFocus.requestFocusTransient,
        category: SessionCategory.playAndRecord,
        mode: SessionMode.modeDefault,
        device: AudioDevice.speaker);

    await playerModule.setSubscriptionDuration(Duration(milliseconds: 30));
    await recorderModule.setSubscriptionDuration(Duration(milliseconds: 30));
  }

  Future<void> init() async {
    recorderModule.openAudioSession(
        focus: AudioFocus.requestFocusTransient,
        category: SessionCategory.playAndRecord,
        mode: SessionMode.modeDefault,
        device: AudioDevice.speaker);
    await _initializeExample(false);

    if (Platform.isAndroid) {
      // copyAssets();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _alive = false;
    super.dispose();
    _textFieldNode.removeListener(_focusNodeListener); // 页面消失时必须取消这个listener！！
    _cancelRecorderSubscriptions();
    _cancelPlayerSubscriptions();
    _releaseFlauto();
  }
  /// 取消录音监听
  /// 结束录音
  _stopRecorder() async {
    try {
      await recorderModule.stopRecorder();
      print('stopRecorder');
      _cancelRecorderSubscriptions();
    } catch (err) {
      print('stopRecorder error: $err');
    }

  }

  /// 取消录音监听
  void _cancelRecorderSubscriptions() {
    if (_recorderSubscription != null) {
      _recorderSubscription.cancel();
      _recorderSubscription = null;
    }
  }

  /// 取消播放监听
  void _cancelPlayerSubscriptions() {
    if (_playerSubscription != null) {
      _playerSubscription.cancel();
      _playerSubscription = null;
    }
  }

  /// 释放录音和播放
  Future<void> _releaseFlauto() async {
    try {
      await playerModule.closeAudioSession();
      await recorderModule.closeAudioSession();
    } catch (e) {
      print('Released unsuccessful');
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget widgets = MaterialApp(
        theme: ThemeData(
          appBarTheme: AppBarTheme.of(context).copyWith(
            brightness: Brightness.light,
          ),
        ),
        home: Scaffold(
          appBar: _appBar(),
          body: BlocListener<GroupBloc, GroupState>(
              listener: (ctx, state) {
                if (state is GroupMessageSuccess) {
                  //_scrollToBottom();
                  if(mounted)
                  _scrollController.position.jumpTo(0);
                }
              },
              child:BlocBuilder<GroupBloc, GroupState>(builder: (ctx, state) {
                return _body(ctx, state);
              })),
        ));
    return widgets;
  }
  Future<Null> _focusNodeListener() async {
    if (_textFieldNode.hasFocus) {
      Future.delayed(Duration(milliseconds: 5), () {
        setState(() {
          _isShowTools = false;
          _isShowFace = false;
          _isShowVoice = false;
          try {
            if(mounted)
              _scrollController.position.jumpTo(0);
          } catch (e) {}
        });
      });
    }
  }
  _getPermission() {
    requestPermiss(_permission);
  }
  void requestPermiss(Permission permission) async {
    //多个权限申请
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
      Permission.location,
      Permission.speech,

    ].request();
    print(statuses);
  }
  _getLocalMessage() async {

  }

  _initData() {
    _popString.add('清空记录');
    _popString.add('删除好友');
    _popString.add('加入黑名单');
    // KeyboardVisibilityNotification().addNewListener(
    //   onChange: (bool visible) {
    //     if (visible) {
    //       _isShowTools = false;
    //       _isShowFace = false;
    //       _isShowVoice = false;
    //       try {
    //         _scrollController.position.jumpTo(0);
    //       } catch (e) {}
    //     }
    //   },
    // );
    // _scrollController.addListener(() {
    //   if (_scrollController.position.pixels ==
    //       _scrollController.position.maxScrollExtent) {
    //     _onRefresh();
    //   }
    // });
  }

  _checkBlackList() {

  }

  _initFaceList() {
    if (_guideFaceList.length > 0) {
      _guideFaceList.clear();
    }
    if (_guideFigureList.length > 0) {
      _guideFigureList.clear();
    }
    //添加表情图
    List<String> _faceList = new List();
    String faceDeletePath =
    FileUtil.getImagePath('face_delete', dir: 'face', format: 'png');
    String facePath;
    for (int i = 0; i < 100; i++) {
      if (i < 90) {
        facePath =
            FileUtil.getImagePath(i.toString(), dir: 'face', format: 'gif');
      } else {
        facePath =
            FileUtil.getImagePath(i.toString(), dir: 'face', format: 'png');
      }
      _faceList.add(facePath);
      if (i == 19 || i == 39 || i == 59 || i == 79 || i == 99) {
        _faceList.add(faceDeletePath);
        _guideFaceList.add(_gridView(7, _faceList));
        _faceList.clear();
      }
    }
    //添加斗图
    List<String> _figureList = new List();
    for (int i = 0; i < 96; i++) {
      if (i == 70 || i == 74) {
        String facePath =
        FileUtil.getImagePath(i.toString(), dir: 'figure', format: 'png');
        _figureList.add(facePath);
      } else {
        String facePath =
        FileUtil.getImagePath(i.toString(), dir: 'figure', format: 'gif');
        _figureList.add(facePath);
      }
      if (i == 9 ||
          i == 19 ||
          i == 29 ||
          i == 39 ||
          i == 49 ||
          i == 59 ||
          i == 69 ||
          i == 79 ||
          i == 89 ||
          i == 95) {
        _guideFigureList.add(_gridView(5, _figureList));
        _figureList.clear();
      }
    }
  }

  _appBar() {
    return MoreWidgets.buildAppBar(
      context, widget.model.name,
      centerTitle: true,
      elevation: 0.0,
      leading: IconButton(
          icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          }),
      actions: <Widget>[
        InkWell(
            child: Container(
                padding: EdgeInsets.only(right: 15.w, left: 15.w),
                child: Icon(
                  Icons.more_horiz,
                  size: 60.sp,
                  color: Colors.black,
                )),
            onTap: () {
              MoreWidgets.buildDefaultMessagePop(context, _popString,
                  onItemClick: (res) {
                switch (res) {
                  case 'one':
                    DialogUtil.showBaseDialog(context, '即将删除该对话的全部聊天记录',
                        right: '删除', left: '再想想', rightClick: (res) {
                      _deleteAll();
                    });
                    break;
                  case 'two':
                    DialogUtil.showBaseDialog(context, '确定删除好友吗？',
                        right: '删除', left: '再想想', rightClick: (res) {

                    });
                    break;
                  case 'three':
                    if (_isBlackName) {
                      DialogUtil.showBaseDialog(context, '确定把好友移出黑名单吗？',
                          right: '移出', left: '再想想', rightClick: (res) {

                      });
                    } else {
                      DialogUtil.showBaseDialog(context, '确定把好友加入黑名单吗？',
                          right: '赶紧', left: '再想想', rightClick: (res) {
                        DialogUtil.showBaseDialog(
                            context, '即将将好友加入黑名单，是否需要支持发消息给TA？',
                            right: '需要',
                            left: '不需要',
                            title: '', rightClick: (res) {

                        }, leftClick: (res) {

                        });
                      });
                    }
                    break;
                }
              });
            })
      ],
    );
  }

  Future _deleteAll() async {


  }

  _body(BuildContext context, GroupState groupState) {
    return Column(
        children: <Widget>[
      Flexible(
          child: InkWell(
        child: _messageListView(context, groupState),
        onTap: () {
          _hideKeyBoard();
          if(_isShowVoice == true ||_isShowFace == true||_isShowTools == true){
            setState(() {
              _isShowVoice = false;
              _isShowFace = false;
              _isShowTools = false;
            });
          }

        },
      )),
      Divider(height: 1.h),
      Container(
        decoration: new BoxDecoration(
          color: Theme.of(context).cardColor,
        ),
        child: Container(
          height: 88.h,
          child: Row(
            children: <Widget>[
              IconButton(
                  icon: _isShowVoice
                      ? Icon(Icons.keyboard)
                      : Icon(Icons.play_circle_outline),
                  iconSize: 55.sp,
                  onPressed: () {
                    setState(() {
                      _hideKeyBoard();
                      if (_isShowVoice) {
                        _isShowVoice = false;
                      } else {
                        _isShowVoice = true;
                        _isShowFace = false;
                        _isShowTools = false;
                      }
                    });
                  }),
              new Flexible(

                  child: _enterWidget()
              ),
              IconButton(
                  icon: _isShowFace
                      ? Icon(Icons.keyboard)
                      : Icon(Icons.sentiment_very_satisfied),
                  iconSize: 55.sp,
                  onPressed: () {
                    _hideKeyBoard();
                    setState(() {
                      if (_isShowFace) {
                        _isShowFace = false;
                      } else {
                        _isShowFace = true;
                        _isShowVoice = false;
                        _isShowTools = false;
                      }
                    });
                  }),
              _isShowSend
                  ? InkWell(
                      onTap: () {
                        if (_controller.text.isEmpty) {
                          return;
                        }
                        _buildTextMessage(_controller.text);
                      },
                      child: new Container(
                        alignment: Alignment.center,
                        width: 90.w,
                        height: 32.h,
                        margin: EdgeInsets.only(right: 8.w),
                        child: new Text(
                          '发送',
                          style: new TextStyle(
                              fontSize: 28.sp, color: Colors.red),
                        ),
                        decoration: new BoxDecoration(
                          color: ObjectUtil.getThemeSwatchColor(),
                          borderRadius: BorderRadius.all(Radius.circular(8.w)),
                        ),
                      ),
                    )
                  : IconButton(
                      icon: Icon(Icons.add_circle_outline),
                      iconSize: 55.sp,
                      onPressed: () {
                        _hideKeyBoard();
                        setState(() {
                          if (_isShowTools) {
                            _isShowTools = false;
                          } else {
                            _isShowTools = true;
                            _isShowFace = false;
                            _isShowVoice = false;
                          }
                        });
                      }),
            ],
          ),
        ),
      ),
      (_isShowTools || _isShowFace || _isShowVoice)
          ? Container(
              height: 418.h,
              child: _bottomWidget(),
            )
          : SizedBox(
              height: 0,
            )
    ]);
  }

  _hideKeyBoard() {
    _textFieldNode.unfocus();
  }

  _bottomWidget() {
    Widget widget;
    if (_isShowTools) {
      widget = _toolsWidget();
    } else if (_isShowFace) {
      widget = _faceWidget();
    } else if (_isShowVoice) {
      widget = _voiceWidget();
    }
    return widget;
  }

  _voiceWidget() {
    return Stack(
      children: <Widget>[
        Align(
            alignment: Alignment.centerLeft,
            child: Container(
                padding: EdgeInsets.all(20.w),
                child: Icon(
                  Icons.headset,
                  color: _headsetColor,
                  size: 80.sp,
                ))),
        Align(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        padding: EdgeInsets.only(top: 10.h),
                        child: _audioIconPath == ''
                            ? SizedBox(
                          width: 60.w,
                          height: 60.h,
                        )
                            : Image.asset(
                          FileUtil.getImagePath(_audioIconPath,
                              dir: 'icon', format: 'png'),
                          width: 60.w,
                          height: 60.h,
                          color: ObjectUtil.getThemeSwatchColor(),
                        )),

                    Text(voiceCount.toString() +"S")
                  ],
                ),
                Container(
                    padding: EdgeInsets.all(10.w),
                    child: GestureDetector(
                      onScaleStart: (res) async {
                        if(_timer != null){
                          _timer.cancel();
                          _timer =Timer.periodic(
                              Duration(milliseconds: 1000), (t){
                            //print(voiceCount);
                            setState(() {
                              voiceCount= voiceCount+1;
                            });
                          }
                          );
                        }else{
                          _timer =Timer.periodic(
                              Duration(milliseconds: 1000), (t){
                            //print(voiceCount);
                            setState(() {
                              voiceCount= voiceCount+1;
                            });
                          }
                          );
                        }

                        if(recorderModule.isRecording ){
                          await _stopRecorder();
                        }
                        _startRecord();
                      },
                      onScaleEnd: (res) async {
                        if (_headsetColor == ObjectUtil.getThemeLightColor()) {
                          DialogUtil.buildToast('试听功能暂未实现');
                          if (recorderModule.isRecording) {
                            _stopRecorder();
                          }
                        } else if (_highlightColor ==
                            ObjectUtil.getThemeLightColor()) {
                          File file = File(_voiceFilePath);
                          file.delete();
                          if (recorderModule.isRecording) {
                            _stopRecorder();
                          }
                        } else {
                          if (recorderModule.isRecording) {
                            _stopRecorder();
                            var  length = await CommonUtil.getDuration(_voiceFilePath);
                            File file = File(_voiceFilePath);
                            if (length*1000 < 1000) {
                              //小于1s不发送
                              file.delete();
                              DialogUtil.buildToast('你说话时间太短啦~');
                            } else {
                              //发送语音
                              _buildVoiceMessage(file, length.floor());
                            }
                            voiceCount= 0;
                            _timer.cancel();
                          }
                        }
                        setState(() {
                          _audioIconPath = '';
                          voiceText = '按住 说话';
                          voiceBackground = ObjectUtil.getThemeLightColor();
                          _headsetColor = ColorT.gray_99;
                          _highlightColor = ColorT.gray_99;
                        });
                      },
                      onScaleUpdate: (res) {
                        if (res.focalPoint.dy > 550.h &&
                            res.focalPoint.dy < 620.h) {
                          if (res.focalPoint.dx > 10.w &&
                              res.focalPoint.dx < 80.w) {
                            setState(() {
                              voiceText = '松开 试听';
                              _headsetColor = ObjectUtil.getThemeLightColor();
                            });
                          } else if (res.focalPoint.dx > 330.w &&
                              res.focalPoint.dx < 400.w) {
                            setState(() {
                              voiceText = '松开 删除';
                              _highlightColor = ObjectUtil.getThemeLightColor();
                            });
                          } else {
                            setState(() {
                              voiceText = '松开 结束';
                              _headsetColor = ColorT.gray_99;
                              _highlightColor = ColorT.gray_99;
                            });
                          }
                        } else {
                          setState(() {
                            voiceText = '松开 结束';
                            _headsetColor = ColorT.gray_99;
                            _highlightColor = ColorT.gray_99;
                          });
                        }
                      },
                      child: new CircleAvatar(
                        child: new Text(
                          voiceText,
                          style: new TextStyle(
                              fontSize: 30.sp, color: ColorT.gray_33),
                        ),
                        radius: 120.w,
                        backgroundColor: voiceBackground,
                      ),
                    ))
              ],
            )),
        Align(
            alignment: Alignment.centerRight,
            child: Container(
                padding: EdgeInsets.all(20.w),
                child: Icon(
                  Icons.highlight_off,
                  color: _highlightColor,
                  size: 80.sp,
                ))),
      ],
    );
  }

  _startRecord() async {

    Vibration.vibrate(duration: 50);
    setState(() {
      voiceText = '松开 结束';
      voiceBackground = ColorT.divider;
      _stopRecorder();
    });
    try{
      requestPermiss(_permission);
      print('===>  获取了权限');
      Directory tempDir = await getTemporaryDirectory();
      var time = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      _voiceFilePath =
      '${tempDir.path}/s-$time${ext[Codec.aacADTS.index]}';
      print('===>  准备开始录音');
      await recorderModule.startRecorder(
        toFile: _voiceFilePath,
        codec: Codec.aacADTS,
        bitRate: 8000,
        sampleRate: 8000,
      );

      /// 监听录音
      _recorderSubscription = recorderModule.onProgress.listen((e) {
        if (e != null && e.duration != null) {
          var volume=e.decibels;
          setState(() {
            if (volume <= 0) {
              _audioIconPath = '';
            } else if (volume > 0 && volume < 30) {
              _audioIconPath = 'audio_player_1';
            } else if (volume < 50) {
              _audioIconPath = 'audio_player_2';
            } else if (volume < 100) {
              _audioIconPath = 'audio_player_3';
            }
          });
        }
      });

    } catch (err) {
      setState(() {
        _stopRecorder();
        _cancelRecorderSubscriptions();
      });
    }
  }
  /// 开始播放
  Future<void> _startPlayer(String _path ) async {
    try {
      var p=await _fileExists(_path);
      if (p !="") {
        await playerModule.startPlayer(
            fromURI: p,
            codec: Codec.aacADTS,
            whenFinished: () {
              print('==> 结束播放');
              _stopPlayer();
              setState(() {});
            });
      } else {
        throw RecordingPermissionException("未找到文件路径");
      }

      _cancelPlayerSubscriptions();
      _playerSubscription = playerModule.onProgress.listen((e) {
        if (e != null) {
          //print("${e.duration} -- ${e.position} -- ${e.duration.inMilliseconds} -- ${e.position.inMilliseconds}");
          // setState(() {
          //   progress = e.position.inMilliseconds / e.duration.inMilliseconds;
          // });

        }
      });

      print('===> 开始播放');
    } catch (err) {
      print('==> 错误: $err');
    }
    setState(() {

    });
  }

  /// 结束播放
  Future<void> _stopPlayer() async {
    try {
      await playerModule.stopPlayer();
      print('===> 结束播放');
      _cancelPlayerSubscriptions();
    } catch (err) {
      print('==> 错误: $err');
    }

  }

  /// 暂停/继续播放
  void _pauseResumePlayer() {
    if (playerModule.isPlaying) {
      playerModule.pausePlayer();

      print('===> 暂停播放');
    } else {
      playerModule.resumePlayer();

      print('===> 继续播放');
    }
    setState(() {});
  }

  /// 判断文件是否存在
  Future<String> _fileExists(String paths) async {

    if (paths.startsWith("http://localhost")) {

      //File f =   await _getLocalFile(path.basename(paths));
      return _voiceFilePath;

    } else if(paths.startsWith("http")){
      return paths;
    }

    return paths;
  }

  _faceWidget() {
    _initFaceList();
    return Column(
      children: <Widget>[
        Flexible(
            child: Stack(
          children: <Widget>[
            Offstage(
              offstage: _isFaceFirstList,
              child: Swiper(
                  autoStart: false,
                  circular: false,
                  indicator: CircleSwiperIndicator(
                      radius: 3.0,
                      padding: EdgeInsets.only(top: 10.w),
                      itemColor: ColorT.gray_99,
                      itemActiveColor: ObjectUtil.getThemeSwatchColor()),
                  children: _guideFigureList),
            ),
            Offstage(
              offstage: !_isFaceFirstList,
              child: EmojiPicker(
                rows: 3,
                columns: 7,
                //recommendKeywords: ["racing", "horse"],
                numRecommended: 10,
                onEmojiSelected: (emoji, category) {
                  _controller.text = _controller.text + emoji.emoji;
                  _controller.selection =
                      TextSelection.fromPosition(
                          TextPosition(offset: _controller.text.length));

                  if (_isShowSend == false){

                    setState(() {
                      if (_controller.text.isNotEmpty) {
                        _isShowSend = true;
                      } else {
                        _isShowSend = false;
                      }
                    });

                  }
                },
              ),
            )

          ],
        )),
        SizedBox(
          height: 4.h,
        ),
        new Divider(height: 2.h),
        Container(
          height: 48.h,
          child: Row(
            children: <Widget>[
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      padding: EdgeInsets.only(left: 20.w),
                      child: InkWell(
                        child: Icon(
                          Icons.sentiment_very_satisfied,
                          color: _isFaceFirstList
                              ? ObjectUtil.getThemeSwatchColor()
                              : _headsetColor,
                          size: 48.sp,
                        ),
                        onTap: () {
                          setState(() {
                            _isFaceFirstList = true;
                          });
                        },
                      ))),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      padding: EdgeInsets.only(left: 20.w),
                      child: InkWell(
                        child: Icon(
                          Icons.favorite_border,
                          color: _isFaceFirstList
                              ? _headsetColor
                              : ObjectUtil.getThemeSwatchColor(),
                          size: 48.sp,
                        ),
                        onTap: () {
                          setState(() {
                            _isFaceFirstList = false;
                          });
                        },
                      ))),
            ],
          ),
        )
      ],
    );
  }

  _toolsWidget() {
    if (_guideToolsList.length > 0) {
      _guideToolsList.clear();
    }
    List<Widget> _widgets = new List();
    _widgets.add(MoreWidgets.buildIcon(Icons.insert_photo, '相册', o: (res) {
      ImageUtil.getGalleryImage().then((imageFile) {
        //相册取图片
        _willBuildImageMessage(imageFile);
      });
    }));
    _widgets.add(MoreWidgets.buildIcon(Icons.camera_alt, '拍摄', o: (res) {
      PopupWindowUtil.showCameraChosen(context, onCallBack: (type, file) {
        if (type == 1) {
          //相机取图片
          _willBuildImageMessage(file);
        } else if (type == 2) {
          //相机拍视频
          _buildVideoMessage(file);
        }
      });
    }));
    _widgets.add(MoreWidgets.buildIcon(Icons.videocam, '视频通话'));
    _widgets.add(MoreWidgets.buildIcon(Icons.location_on, '位置'));
    _widgets.add(MoreWidgets.buildIcon(Icons.view_agenda, '红包'));
    _widgets.add(MoreWidgets.buildIcon(Icons.swap_horiz, '转账'));
    _widgets.add(MoreWidgets.buildIcon(Icons.mic, '语音输入'));
    _widgets.add(MoreWidgets.buildIcon(Icons.favorite, '我的收藏'));
    _guideToolsList.add(GridView.count(
        crossAxisCount: 4, padding: EdgeInsets.all(5.0), children: _widgets));
    List<Widget> _widgets1 = new List();
    _widgets1.add(MoreWidgets.buildIcon(Icons.person, '名片'));
    _widgets1.add(MoreWidgets.buildIcon(Icons.folder, '文件'));
    _guideToolsList.add(GridView.count(
        crossAxisCount: 4, padding: EdgeInsets.all(0.0), children: _widgets1));
    return Swiper(
        autoStart: false,
        circular: false,
        indicator: CircleSwiperIndicator(
            radius: 3.0,
            padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
            itemColor: ColorT.gray_99,
            itemActiveColor: ObjectUtil.getThemeSwatchColor()),
        children: _guideToolsList);
  }

  _gridView(int crossAxisCount, List<String> list) {
    return GridView.count(
        crossAxisCount: crossAxisCount,
        padding: EdgeInsets.all(0.0),
        children: list.map((String name) {
          return new IconButton(
              onPressed: () {
                if (name.contains('face_delete')) {
                  DialogUtil.buildToast('暂时不会把自定义表情显示在TextField，谁会的教我~');
                } else {
                  //表情因为取的是assets里的图，所以当初文本发送
                  _buildTextMessage(name);
                }
              },
              icon: Image.asset(name,
                  width: crossAxisCount == 5 ? 60.w : 32.w,
                  height: crossAxisCount == 5 ? 60.h : 32.h));
        }).toList());
  }

  /*输入框*/
  _enterWidget() {
    return new Material(
      borderRadius: BorderRadius.circular(12.w),
      shadowColor: ObjectUtil.getThemeLightColor(),
      color: ColorT.gray_f0,
      elevation: 0,
      child: Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6.w)),
          constraints: BoxConstraints(minHeight: 60.h, maxHeight: 250.h),
          child:new TextField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
          focusNode: _textFieldNode,
          textInputAction: TextInputAction.send,
          controller: _controller,
          inputFormatters: [
            LengthLimitingTextInputFormatter(150), //长度限制11
          ], //只能输入整数
          style: TextStyle(color: Colors.black, fontSize: 32.sp),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10.w),
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.transparent,
          ),
          onChanged: (str) {
            setState(() {
              if (str.isNotEmpty) {
                _isShowSend = true;
              } else {
                _isShowSend = false;
              }
            });
          },
          onEditingComplete: () {
            if (_controller.text.isEmpty) {
              return;
            }
            _buildTextMessage(_controller.text);
          }
          )
      ),
    );
  }

  _messageListView(BuildContext context, GroupState groupState) {
    if (groupState is GroupMessageSuccess) {

      return Container(
          color: ColorT.gray_f0,
          child: Column(
            //如果只有一条数据，listView的高度由内容决定了，所以要加列，让listView看起来是满屏的
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 0,bottom: 0),
                    child: Text('',
                      style:
                      TextStyle(
                        fontSize: 24.sp,
                        color: Theme.of(context).disabledColor,
                      ),
                    ),
                  )
                ],
              ),
              Flexible(
                //外层是Column，所以在Column和ListView之间需要有个灵活变动的控件
                  child: _buildContent(context, groupState))
            ],
          ));
    }
    if (groupState is LoadMoreGroupMessageSuccess) {
      bool isLastPage=groupState.noMore;
      return Container(
          color: ColorT.gray_f0,
          child: Column(
            //如果只有一条数据，listView的高度由内容决定了，所以要加列，让listView看起来是满屏的
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                    child: _isLoading
                        ? CupertinoActivityIndicator()
                        : Container(),
                  )
                ],
              ),

              Flexible(
                //外层是Column，所以在Column和ListView之间需要有个灵活变动的控件
                  child: _buildContent(context, groupState))
            ],
          ));
    }
    return Container();

  }
  Widget _buildContent(BuildContext context, GroupState state) {
    if (state is GroupMessageSuccess) {
      return ScrollConfiguration(
          behavior: DyBehaviorNull(),
          child:ListView.builder(
              padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 0,bottom: 0),
          itemBuilder: (BuildContext context, int index) {
            if (index == state.messageList.length  -1) {
              return Column(
                children: <Widget>[
                  Visibility(
                    visible: !_isLoading,
                    child:  _loadMoreWidget(state.messageList.length % 20 ==0),
                  ),

                    _messageListViewItem(state.messageList,index,tfSender),

                ],
              );
            } else {
              return Column(
                children: <Widget>[
                  _messageListViewItem(state.messageList,index,tfSender),
                ],
              );
            }


          },
          //倒置过来的ListView，这样数据多的时候也会显示“底部”（其实是顶部），
          //因为正常的listView数据多的时候，没有办法显示在顶部最后一条
          reverse: true,
          //如果只有一条数据，因为倒置了，数据会显示在最下面，上面有一块空白，
          //所以应该让listView高度由内容决定
          shrinkWrap: true,
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          itemCount: state.messageList.length));
    }
    if (state is LoadMoreGroupMessageSuccess) {
      return ScrollConfiguration(
          behavior: DyBehaviorNull(),
          child: ListView.builder(
              padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 0),
              itemBuilder: (BuildContext context, int index) {
                if (index == state.messageList.length - 1) {
                  return Column(
                    children: <Widget>[
                      Visibility(
                        visible: !_isLoading,
                        child:  _loadMoreWidget(state.messageList.length % 20 ==0),
                      ),
                      _messageListViewItem(state.messageList,index,tfSender),

                    ],
                  );
                } else {
                  return Column(
                    children: <Widget>[
                      _messageListViewItem(state.messageList,index,tfSender),
                    ],
                  );
                }


              },
          //倒置过来的ListView，这样数据多的时候也会显示“底部”（其实是顶部），
          //因为正常的listView数据多的时候，没有办法显示在顶部最后一条
          reverse: true,
          //如果只有一条数据，因为倒置了，数据会显示在最下面，上面有一块空白，
          //所以应该让listView高度由内容决定
          shrinkWrap: true,
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          itemCount: state.messageList.length));
    }
    return Container();
  }
  Future<Null> _onRefresh() async {


  }
//加载中的圈圈
  Widget _loadMoreWidget(bool haveMore) {
    if (haveMore) {
      return Container();
      //还有更多数据可以加载
      // return Center(
      //   child: Padding(
      //     padding: EdgeInsets.all(10),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: <Widget>[
      //         Text("加载中......"),
      //         CircularProgressIndicator(
      //           strokeWidth: 1,
      //         )
      //       ],
      //     ),
      //   ),
      // );
    } else {
      //当没有更多数据可以加载的时候，
      return Center(
        child:   Text(
          "没有更多数据了",
          style: new TextStyle(color: Colors.black54, fontSize: 26.sp),
        ),
      );
    }
  }
  Widget _messageListViewItem(List<Message>messageList, int index,String tfSender) {
    //list最后一条消息（时间上是最老的），是没有下一条了
    Message _nextEntity = (index == messageList.length - 1) ? null : messageList[index + 1];
    Message _entity = messageList[index];
    return buildChatListItem(_nextEntity, _entity,tfSender,
        onResend: (reSendEntity) {
          _onResend(reSendEntity);
        },
        onItemClick: (onClickEntity) async {
          Message entity = onClickEntity;
          if (entity.type == MessageType.MESSAGE_AUDIO){
            //点击了语音
            if (_entity.playing == 1) {
              //正在播放，就停止播放
              await _stopPlayer();
              setState(() {
                _entity.playing = 0;
              });
            } else {
              setState(()  {
                for (Message other in messageList) {
                  other.playing = 0;
                  //停止其他正在播放的
                }
              });
              _entity.playing = 1;
              await _startPlayer(_entity.content['url']);
              Future.delayed(Duration(milliseconds: _entity.content['duration']*1000), () async {
                if (_alive) {
                  setState(()  {
                    _entity.playing = 0;
                  });
                  await  _stopPlayer();
                }
              });
            }
          }
        });
  }
  Widget buildChatListItem(Message nextEntity, Message entity,String tfSender,
      {OnItemClick onResend, OnItemClick onItemClick}) {
    bool _isShowTime = true;
    var showTime; //最终显示的时间
    if (null == nextEntity) {
      //_isShowTime = true;
    } else {
      //如果当前消息的时间和上条消息的时间相差，大于3分钟，则要显示当前消息的时间，否则不显示
      if ((entity.timestamp*1000 - nextEntity.timestamp*1000).abs() > 3 * 60 * 1000) {
        _isShowTime = true;
      } else {
        _isShowTime = false;
      }
    }
    showTime=TimeUtil.chatTimeFormat(entity.timestamp);

    return Container(
      child: Column(
        children: <Widget>[
          _isShowTime
              ? Center(
              heightFactor: 2,
              child: Text(
                showTime,
                style: TextStyle(color: ColorT.transparent_80),
              ))
              : SizedBox(height: 0),
          GroupChatItemWidget(entity: entity, onResend: onResend, onItemClick:onItemClick,tfSender: tfSender)
        ],
      ),
    );
  }

  Widget buildVideoWidget(MessageEntity entity) {
  }
  /*删除好友*/
  _deleteContact(String username) {
  }

  /*加入黑名单*/
  _addToBlackList(String isNeed, String username) {
  }

  /*移出黑名单*/
  _removeUserFromBlackList(String username) {
  }
  Future<File> _getLocalFile(String filename) async {
    String dir = (await getTemporaryDirectory()).path;
    File f = new File('$dir/$filename');
    return f;
  }
  //重发
  _onResend(Message entity) {
  }

  _buildTextMessage(String content) {
    BlocProvider.of<GroupBloc>(context).add(EventGroupSendNewMessage(tfSender,widget.model.cid,content));
      _controller.clear();
      _isShowSend = false;
  }
  sendTextMessage(String text) async {
    if (text == null || text.length == 0) {
      return;
    }
  }
  _willBuildImageMessage(File imageFile) {
    if (imageFile == null || imageFile.path.isEmpty) {
      return;
    }
    _buildImageMessage(imageFile, false);return;
  }

  _buildImageMessage(File file, bool sendOriginalImage)  {
   file.readAsBytes().then((content) =>
       BlocProvider.of<GroupBloc>(context).add(EventGroupSendNewImageMessage(tfSender,widget.model.cid,content))
      );
       _isShowTools = false;
      _controller.clear();
  }

  _buildVoiceMessage(File file, int length) {
    BlocProvider.of<GroupBloc>(context).add(EventGroupSendNewVoiceMessage(tfSender,widget.model.cid,file.path,length.floor()));
    _controller.clear();
  }

  _buildVideoMessage(Map file) {
    setState(() {
      _controller.clear();
    });

  }

  void updateData(Message entity) {
    // TODO: implement updateData
  }
}


















