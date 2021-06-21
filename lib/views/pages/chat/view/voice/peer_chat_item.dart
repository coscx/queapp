import 'dart:typed_data';
import 'dart:async';
import 'dart:io';
import 'package:flt_im_plugin/flt_im_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flt_im_plugin/message.dart';
import 'package:flt_im_plugin/value_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geen/components/imageview/image_preview_page.dart';
import 'package:flutter_geen/components/imageview/image_preview_view.dart';
import 'package:flutter_geen/views/pages/chat/view/util/ImMessage.dart';
import 'package:flutter_geen/views/pages/chat/utils/dialog_util.dart';
import 'package:flutter_geen/views/pages/chat/utils/file_util.dart';
import 'package:flutter_geen/views/pages/chat/utils/functions.dart';
import 'package:flutter_geen/views/pages/chat/utils/object_util.dart';

class PeerChatItemWidget extends StatefulWidget {
  final Message entity;
  final OnItemClick onResend;
  final OnItemClick onItemClick;
  final OnItemClick onItemLongClick;
  final String  tfSender;
  PeerChatItemWidget({Key key,@required this.entity,@required this.onResend, @required this.onItemClick,@required this.onItemLongClick,  @required this.tfSender}): super(key: key);
  @override
  PeerChatItemWidgetState createState() => PeerChatItemWidgetState();
}

class PeerChatItemWidgetState extends State<PeerChatItemWidget> {
  FltImPlugin im = FltImPlugin();

  @override
  Widget build(BuildContext context) {
    return _chatItemWidget(widget.entity,widget.onResend,widget.onItemClick,widget.onItemLongClick,widget.tfSender);
  }



  Widget _chatItemWidget(Message entity, OnItemClick onResend, OnItemClick onItemClick,OnItemClick onItemLongClick,String tfSender) {
    if (entity.type == MessageType.MESSAGE_REVOKE) {
      //文本
      return buildRevokeWidget(entity,tfSender);
    }
    if (entity.sender == tfSender) {
   {
      //自己的消息
      return Container(
        margin: EdgeInsets.only(left: 40.w, right: 10.w, bottom: 6.h, top: 6.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //显示是否重发1、发送2中按钮，发送成功0或者null不显示
            (entity.flags == 0 || entity.flags == 8)
                ? IconButton(
                icon: Icon(Icons.error, color: Colors.red, size: 18.sp),
                onPressed: () {
                  if (null != onResend) {
                    onResend(entity);
                  }
                })
                : ((entity.flags == 1)
                ? Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 20.h, right: 20.w),
              width: 32.w,
              height: 32.h,
              child: SizedBox(
                  width: 12.w,
                  height: 12.h,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(
                        ObjectUtil.getThemeSwatchColor()),
                    strokeWidth: 2,
                  )),
            )
                : SizedBox(
              width: 0,
              height: 0,
            )),
            Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 0.w, right: 0.w, bottom: 0.h, top: 12.h),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[

                      SizedBox(height: 1.h),
                      GestureDetector(
                        child: _contentWidget(entity,tfSender),
                        onTap: () {
                          if (null != onItemClick) {
                            onItemClick(entity);
                          }
                        },
                        onLongPress: () {
                          if (null != onItemClick) {
                            onItemLongClick(entity);
                          }

                        },
                      ),

                    ],
                  ),
                )),
            SizedBox(width: 10),
            _headPortrait('', 0),
          ],
        ),
      );
    }



    } else {
      //其他人的消息
      return Container(
        margin: EdgeInsets.only(left: 10.w, right: 40.w, bottom: 6.h, top: 6.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _headPortrait('', 1),
            Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 0.w, right: 0.w, bottom: 0.h, top: 12.h),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        child: _contentWidget(entity,tfSender),
                        onTap: () {
                          if (null != onItemClick) {
                            onItemClick(entity);
                          }
                        },
                        // onLongPress: () {
                        //   if (null != onItemClick) {
                        //     onItemLongClick(entity);
                        //   }
                        //
                        // },
                      ),
                    ],
                  ),
                )),
          ],
        ),
      );
    }
  }


  /*
  *  头像
  */
  Widget _headPortrait(String url, int owner) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(6.w),
        child: url.isEmpty
            ? Image.asset(
            (owner == 1
                ? FileUtil.getImagePath('img_headportrait',
                dir: 'icon', format: 'png')
                : FileUtil.getImagePath('logo',
                dir: 'splash', format: 'png')),
            width: 88.w,
            height: 88.h)
            : (ObjectUtil.isNetUri(url)
            ? Image.network(
          url,
          width: 88.w,
          height: 88.h,
          fit: BoxFit.fill,
        )
            : Image.asset(url, width: 88, height: 88)));
  }

  /*
  *  内容
  */
  Widget _contentWidget(Message entity,String tfSender) {
    Widget widget;
    if (entity.type == MessageType.MESSAGE_TEXT) {
      //文本
      if ((entity.content['text'] != null && entity.content['text'].contains('assets/images/face') )||
          (entity.content['text'] != null && entity.content['text'].contains('assets/images/figure'))) {
        widget = buildImageWidget(entity,tfSender);
      } else {
        if(entity.content['text'] == null)
        entity.content['text'] ="err";
        widget = buildTextWidget(entity,tfSender);
      }

    } else if (entity.type == MessageType.MESSAGE_IMAGE) {
      //文本
      widget = buildImageWidget(entity,tfSender);
    }else if (entity.type == MessageType.MESSAGE_AUDIO) {
      //文本
      widget = buildVoiceWidget(entity,tfSender);
    }else if (entity.type == MessageType.MESSAGE_REVOKE) {
      //文本
      widget = buildRevokeWidget(entity,tfSender);
    } else {
      widget = ClipRRect(
        borderRadius: BorderRadius.circular(12.w),
        child: Container(
          padding: EdgeInsets.all(15.h),
          color: ObjectUtil.getThemeLightColor(),
          child: Text(
            '未知消息类型',
            style: TextStyle(fontSize: 30.sp, color: Colors.black),
          ),
        ),
      );
    }
    return widget;
  }
  Widget buildRevokeWidget(Message entity,String  tfSender) {
    var type = entity.content['notificationType'];
    //var raw = json.decode(entity.content['raw']);
    String content ="";

   content = entity.sender == tfSender ?"你撤回了一条消息" : entity.sender + "撤回了一条消息";

    return ClipRRect(
      borderRadius: BorderRadius.circular(16.w),
      child: Container(
        padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 16.h, bottom: 16.h),
        color:  Colors.transparent,
        child: Text(
          content,
          style: TextStyle(fontSize: 28.sp, color: Colors.black45),
        ),
      ),
    );
  }
  Widget buildTextWidget(Message entity,String  tfSender) {

    return ClipRRect(
      borderRadius: BorderRadius.circular(16.w),
      child: Container(
        padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 16.h, bottom: 16.h),
        color: entity.sender == tfSender
            ?Color.fromARGB(255, 158, 234, 106)
            : Colors.white,
        child: Text(
          entity.content['text'],
          style: TextStyle(fontSize: 32.sp, color: Colors.black),
        ),
      ),
    );
  }
  Widget buildGroupNotifitionWidget(Message entity,String  tfSender) {
    var type = entity.content['notificationType'];
    //var raw = json.decode(entity.content['raw']);
    String content ="";
    if(type==7){
      if(entity.content['mute']==1){
        content =entity.content['member'].toString()+ "被管理员禁言";
      }else{
        content =entity.content['member'].toString()+ "被管理员解除禁言";
      }


    }


    return ClipRRect(
      borderRadius: BorderRadius.circular(16.w),
      child: Container(
        padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 16.h, bottom: 16.h),
        color:  Colors.transparent,
        child: Text(
          content,
          style: TextStyle(fontSize: 28.sp, color: Colors.black45),
        ),
      ),
    );
  }
  Widget buildImageWidget(Message message,String  tfSender) {
    int isFace =0;
    //图像
    double width = ValueUtil.toDouble(message.content['width']);
    double height = ValueUtil.toDouble(message.content['height']);
    String imageURL = ValueUtil.toStr(message.content['imageURL']);
    if (imageURL == null || imageURL.length == 0) {
      imageURL = ValueUtil.toStr(message.content['url']);
    }
    double size = 240.w;
    Widget image;
    if (message.type== MessageType.MESSAGE_TEXT&&
        message.content['text'].contains('assets/images/face')) {
      //assets/images/face中的表情
      size = 50.w;
      image = Image.asset(message.content['text'], width: size, height: size);
      isFace=1;
    } else if (message.type== MessageType.MESSAGE_TEXT &&
        message.content['text'].contains('assets/images/figure')) {
      //assets/images/figure中的表情
      size = 120.w;
      image = Image.asset(message.content['text'], width: size, height: size);
      isFace=1;
    }
    return _buildWrapper(
      isSelf: message.sender== tfSender,
      message: message,
      child: isFace==1?

      ClipRRect(
        borderRadius: BorderRadius.circular(8.w),
        child: Container(
          padding: EdgeInsets.all((message.content['text'].isNotEmpty &&
              message.content['text'].contains('assets/images/face'))
              ? 10.w
              : 0),
          color: message.sender == tfSender
              ? Colors.white
              : Color.fromARGB(255, 158, 234, 106),
          child: image,
        ),
      ):

      Container(
          decoration: new BoxDecoration(
            //背景Colors.transparent 透明
            color: Colors.transparent,
            //设置四周圆角 角度
            borderRadius: BorderRadius.all(Radius.circular(4.w)),
            //设置四周边框

          ),

          width: 190.w,
          height: 220.h,
          child: //Image.network(imageURL)
          GestureDetector(
            child:
            //FutureBuilder(
            //   future: getLocalCacheImage(url: imageURL),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState != ConnectionState.done) {
            //       return Container();
            //     }
            //     if (snapshot.hasData) {
            //       return Image.memory(snapshot.data);
            //     } else {
            //       if (imageURL.startsWith("http://localhost")) {
            //         return Container();
            //       } else if (imageURL.startsWith('file:/')) {
            //         return Image.file(File(imageURL));
            //       }
            //       return Image.network(imageURL);
            //     }
            //   },
            // ),
            buildLocalImageWidget(imageURL),
            // Image.network(imageURL),
            onTap: () {

              ImagePreview.preview(
                context,
                images: List.generate(1, (index) {
                  return ImageOptions(
                    url: imageURL,
                    tag: imageURL,
                  );
                }),
                // bottomBarBuilder: (context, int index) {
                //   if (index % 4 == 1) {
                //     return SizedBox.shrink();
                //   }
                //   return Container(
                //     height: index.isEven ? null : MediaQuery.of(context).size.height / 2,
                //     padding: EdgeInsets.symmetric(
                //       horizontal: 16,
                //       vertical: 10,
                //     ),
                //     child: SafeArea(
                //       top: false,
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text(
                //             '测试标题',
                //             style: TextStyle(
                //               color: CupertinoDynamicColor.resolve(
                //                 CupertinoColors.label,
                //                 context,
                //               ),
                //             ),
                //           ),
                //           Text(
                //             '测试内容',
                //             style: TextStyle(
                //               fontSize: 15,
                //               color: CupertinoDynamicColor.resolve(
                //                 CupertinoColors.secondaryLabel,
                //                 context,
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   );
                // },
              );

            },
            onLongPress: () {
              DialogUtil.buildToast('长按了消息');
            },
          )

      ),
    );
  }

  Widget buildLocalImageWidget(String imageURL) {
    if (imageURL.startsWith("http://localhost")) {
      return FutureBuilder(
        future: getLocalCacheImage(url: imageURL),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Container();
          }
          if (snapshot.hasData) {
            return Image.memory(snapshot.data);
          } else {
            if (imageURL.startsWith("http://localhost")) {
              return Container();
            } else if (imageURL.startsWith('file:/')) {
              return Image.file(File(imageURL));
            }
            return Image.network(imageURL);
          }
        },
      );
    } else if (imageURL.startsWith('file:/')) {
      return Image.file(File(imageURL.substring(6)));
    }
    return CachedNetworkImage(
      imageUrl: imageURL,
      // placeholder: (context, url) => new CircularProgressIndicator(),
      errorWidget: (context, url, error) => new Icon(Icons.error),
    );

    Image.network(imageURL);

  }

  Future<Uint8List> getLocalCacheImage({String url}) async {

    Map result = await im.getLocalCacheImage(url: url);
    NativeResponse response = NativeResponse.fromMap(result);
    return response.data;
  }
  Future<Uint8List> getLocalMediaURL({String url}) async {

    Map result = await im.getLocalMediaURL(url: url);
    NativeResponse response = NativeResponse.fromMap(result);
    return response.data;
  }



  // Future<File> _getLocalFile(String filename) async {
  //   String dir = (await getExternalStorageDirectory()).path;
  //   File f = new File('$dir/$filename');
  //   return f;
  // }
  _buildWrapper({bool isSelf, Message message, Widget child}) {
    return Container(
      margin: EdgeInsets.all(1.w),
      child: Row(
        mainAxisAlignment: isSelf ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [

          Container(
            child: child,
          ),

        ],
      ),
    );
  }
  Widget buildVoiceWidget(Message entity,String  tfSender) {
    double width;
    if (entity.content['duration'] < 5) {
      width = 160.w;
    } else if (entity.content['duration'] < 10) {
      width = 240.w;
    } else if (entity.content['duration'] < 20) {
      width = 280.w;
    } else {
      width = 300.w;
    }
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
              width: width,
              color: entity.sender == tfSender
                  ? Colors.white
                  : Color.fromARGB(255, 158, 234, 106),
              child: Row(
                mainAxisAlignment: entity.sender == tfSender
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.end,
                children: <Widget>[
                  entity.sender == tfSender
                      ? Text('')
                      : Text((entity.content['duration']).toString() + 's',
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                  SizedBox(
                    width: 5,
                  ),
                  entity.playing == 1
                      ? Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 1, right: 1),
                    width: 18.0,
                    height: 18.0,
                    child: SizedBox(
                        width: 14.0,
                        height: 14.0,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.black),
                          strokeWidth: 2,
                        )),
                  )
                      : Image.asset(
                    FileUtil.getImagePath('audio_player_3',
                        dir: 'icon', format: 'png'),
                    width: 18,
                    height: 18,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  entity.sender == tfSender
                      ? Text((entity.content['duration']).toString() + 's',
                      style: TextStyle(fontSize: 18, color: Colors.black))
                      : Text(''),
                ],
              )),
        ),
        Container(
          padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 60.h, bottom: 10.h),
          width: width,
          child: LinearProgressIndicator(
            value: 0.3,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            backgroundColor: Colors.transparent,
          ),
        ),


      ],
    );
  }

  freshChatAck({int status}) {
    setState(() {
      widget.entity.flags =2;
    });
  }

}
