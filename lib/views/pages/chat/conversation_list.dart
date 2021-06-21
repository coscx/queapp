import 'package:flt_im_plugin/flt_im_plugin.dart';
import 'package:flt_im_plugin/message.dart';
import 'package:flt_im_plugin/value_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:badges/badges.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geen/app/router.dart';
import 'package:flutter_geen/blocs/bloc_exp.dart';
import 'package:flutter_geen/blocs/chat/chat_bloc.dart';
import 'package:flutter_geen/blocs/chat/chat_state.dart';
import 'package:flutter_geen/blocs/peer/peer_bloc.dart';
import 'package:flutter_geen/blocs/peer/peer_event.dart';
import 'package:flutter_geen/blocs/peer/peer_state.dart';
import 'package:flutter_geen/views/pages/chat/view/util/date.dart';
import 'package:flutter_geen/views/pages/chat/widget/more_widgets.dart';
import 'package:flutter_geen/views/pages/home/home_page.dart';
import 'package:flutter_geen/views/pages/chat/utils/DyBehaviorNull.dart';
import 'package:flutter_geen/views/pages/chat/utils/dialog_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flt_im_plugin/conversion.dart';
import 'package:flutter_geen/storage/dao/local_storage.dart';
//会控菜单项
enum ConferenceItem { AddMember, LockConference, ModifyLayout, TurnoffAll }
/*
 * 聊天了列表界面，目前是只加载最新的20条，有下拉刷新。
 */
class ImConversationListPage extends StatelessWidget{

  final String memberId;
  ImConversationListPage({Key key, this.memberId}) : super(key: key);
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  var _popString = ['清空记录','删除好友','加入黑名单'];
  int _offset = 0;
  int _limit = 10; //一次加载10条数据,不建议加载太多。

  //只有下拉刷新，上拉加载leancloud有些问题
  void _onRefresh() async {
    _offset = 0;

  }

  Widget imRefreshHeader() {
    return ClassicHeader(
      refreshingText: "加载中...",
      idleText: "加载最新会话",
      completeText: '加载完成',
      releaseText: '松开刷新数据',
      failedIcon: null,
      failedText: '刷新失败，请重试。',
    );
  }


  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
        appBarTheme: AppBarTheme.of(context).copyWith(
      brightness: Brightness.light,
    ),
    ),
    child:Scaffold(
      appBar: AppBar(
        titleSpacing:60.w,
        leadingWidth: 0,
        title:  Text('消息',style: TextStyle(color: Colors.black, fontSize: 50.sp,fontWeight: FontWeight.bold)),
        //leading:const Text('Demo',style: TextStyle(color: Colors.black, fontSize: 15)),
        backgroundColor: Colors.white,
        elevation: 0, //去掉Appbar底部阴影
        actions:<Widget> [

          Container(
           margin: EdgeInsets.fromLTRB(0.w,10.h,0.w,0.h),
           height: 20.h,
            width: 20.w,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.add_circle_outline,
                size: 48.sp,
                color: Colors.black,
              ),
              onPressed: (){
                Navigator.pushNamed(context, UnitRouter.user);
              },
            ),
          ),
        SizedBox(
          width: 80.w,
        )
        ],
      ),
      body:Column(
        children: <Widget>[

          Container(
               height: 195.h,
               width: ScreenUtil().screenWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.w),
                color: Colors.white,
                boxShadow: [BoxShadow(color: Color(0x08000000), offset: Offset(0.5, 0.5),  blurRadius: 1.5.w, spreadRadius: 1.5.w),  BoxShadow(color: Colors.white)],
              ),
              margin: EdgeInsets.fromLTRB(20.w,10.h,20.w,0.h),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
//                交叉轴的布局方式，对于column来说就是水平方向的布局方式
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //就是字child的垂直布局方向，向上还是向下
                    verticalDirection: VerticalDirection.down,
                    children: <Widget>[
                      SizedBox(
                        width: ScreenUtil().setWidth(5),
                      ),
                      Container(
                        padding:  EdgeInsets.only(
                            top: 35.h,
                            bottom: 15.h,

                        ),
                        child:  Column(children: <Widget>[
                          Container(
                            height: ScreenUtil().setHeight(90),
                            width: ScreenUtil().setWidth(90),
                            alignment: FractionalOffset.topLeft,
                            child: Image.asset("assets/packages/images/ic_chat_match.webp"),
                          ),
                          Text(
                            "心动速配",
                            style: new TextStyle(color: Colors.black54, fontSize: 26.sp),
                          ),

                        ]),
                      ),


                      Container(
                        padding:  EdgeInsets.only(
                            top: 35.h,
                            bottom: 15.h,

                        ),
                        child:  Column(children: <Widget>[
                          Container(
                            height: ScreenUtil().setHeight(90),
                            width: ScreenUtil().setWidth(90),
                            alignment: FractionalOffset.topLeft,
                            child: Image.asset("assets/packages/images/ic_moment_notice.webp"),
                          ),
                          Text(
                            "互动消息",
                            style: new TextStyle(color: Colors.black54, fontSize: 26.sp),
                          ),

                        ]),
                      ),

                      Container(
                        padding:  EdgeInsets.only(
                            top: 35.h,
                            bottom: 15.h,

                        ),
                        child:  Column(children: <Widget>[
                          Container(
                            height: ScreenUtil().setHeight(90),
                            width: ScreenUtil().setWidth(90),
                            alignment: FractionalOffset.topLeft,
                            child: Image.asset("assets/packages/images/ic_visitor.webp"),
                          ),
                          Text(
                            "访客记录",
                            style: new TextStyle(color: Colors.black54, fontSize: 26.sp),
                          ),

                        ]),
                      ),

                      Container(
                        padding:  EdgeInsets.only(
                            top: 35.h,
                            bottom: 15.h,

                        ),
                        child:  Column(children: <Widget>[
                          Container(
                            height: ScreenUtil().setHeight(90),
                            width: ScreenUtil().setWidth(90),
                            alignment: FractionalOffset.topLeft,
                            child: Image.asset("assets/packages/images/ic_playing.webp"),
                          ),
                          Text(
                            "好友在玩",
                            style: new TextStyle(color: Colors.black54, fontSize: 26.sp),
                          ),

                        ]),

                      ),


                      SizedBox(
                        width: ScreenUtil().setWidth(5),
                      ),
                    ],
                  ))),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child:  SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              header: imRefreshHeader(),
              controller: _refreshController,
              onRefresh: _onRefresh,
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
                color: Colors.white,
                child: BlocListener<ChatBloc, ChatState>(
                  listener: (ctx, state) {
                    if (state is ChatMessageSuccess) {

                    }

                  },child:BlocBuilder<ChatBloc, ChatState>(builder: _buildContent)),
              )


            ),
          ),
        ],
      ),

    ));
  }
  List<PopupMenuItem<String>> buildItems() {
    final map = {
      "待审": Icons.zoom_in,
      "已审": Icons.check,
      "隐藏": Icons.app_blocking,
    };
    return map.keys
        .toList()
        .map((e) => PopupMenuItem<String>(
        value: e,
        child: Wrap(
          spacing: 10,
          children: <Widget>[
            Icon(
              map[e],
              color: Colors.blue,
            ),
            Text(e),
          ],
        )))
        .toList();
  }
  Widget _buildListItem(Conversion conversation) {
    return Container(
      color:Colors.white,
      padding:  EdgeInsets.only(top: 15.h,left: 20.w),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              conversation.newMsgCount == 0
                  ? Container(
                margin: EdgeInsets.only(left: 20.w, top: 7.h),
                padding: EdgeInsets.all(10.w),
                height: 92.h,
                width: 92.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(46.w),
                  // image url 去要到自己的服务器上去请求回来再赋值，这里使用一张默认值即可
                  image: DecorationImage(
                      image: conversation.type== ConversionType.CONVERSATION_PEER? Image.asset("assets/packages/images/chat_hi.png").image:Image.asset("assets/packages/images/chat_notice.png").image
                  ),
                ),
              )
                  : Badge(
                badgeContent: Text(
                  '${conversation.newMsgCount}',
                  style: TextStyle(color: Colors.white, fontSize: 26.sp),
                ),
                child: Container(
                  margin: EdgeInsets.only(left: 20.w, top: 7.h),
                  padding: EdgeInsets.all(10.w),
                  height: 92.h,
                  width: 92.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(46.w),
                    // image url 去要到自己的服务器上去请求回来再赋值，这里使用一张默认值即可
                    image: DecorationImage(
                        image: conversation.type == ConversionType.CONVERSATION_PEER? Image.asset("assets/packages/images/chat_hi.png").image:Image.asset("assets/packages/images/chat_notice.png").image
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 16.w, top: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      constraints: BoxConstraints(maxWidth: 260.w),
                      margin: EdgeInsets.only(top: 2.w,left: 10.w),
                      child: Text(
                        conversation.type == ConversionType.CONVERSATION_PEER ?conversation.cid :conversation.cid+"群",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black, fontSize: 30.sp),
                      ),
                    ),
                    conversation.type == ConversionType.CONVERSATION_PEER ?Container(
                      constraints: BoxConstraints(maxWidth: 0.6.sw),
                      margin: EdgeInsets.only(top: 8.w),
                      child: Text((conversation.message.type == MessageType.MESSAGE_REVOKE ? (conversation.message.sender == memberId ?"你撤回了一条消息" : conversation.message.sender +"撤回了一条消息") : (conversation.detail.contains('assets/images/face') || conversation.detail.contains('assets/images/figure'))?'[表情消息]':conversation.detail),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(color: Colors.grey, fontSize: 30.sp)),
                    ):Container(
                      constraints: BoxConstraints(maxWidth: 0.6.sw),
                      margin: EdgeInsets.only(top: 8.w),
                      child: Text((conversation.message.type == MessageType.MESSAGE_REVOKE ? (conversation.message.sender == memberId ?"你撤回了一条消息" : conversation.message.sender +"撤回了一条消息") :(conversation.message.sender + ":"+((conversation.detail.contains('assets/images/face') || conversation.detail.contains('assets/images/figure'))?'[表情消息]':conversation.detail))),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(color: Colors.grey, fontSize: 30.sp)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(right: 14.w, bottom: 18.h,top: 14.h),
            child: Text(tranImTime(tranFormatTime(conversation.message.timestamp)),
                style: TextStyle(color: Colors.grey, fontSize: 30.sp)),
          )
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, ChatState state) {
    if (state is ChatMessageSuccess) {
      return ScrollConfiguration(
        behavior: DyBehaviorNull(),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: state.message.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                  onTap: ()  async{


                      FltImPlugin im = FltImPlugin();
                      List<Conversion>  message;
                        if(state.message[index].type == ConversionType.CONVERSATION_GROUP){
                          im.clearGroupReadCount(cid:state.message[index].cid);
                            message=state.message.map((e) {
                            if(e.type == ConversionType.CONVERSATION_GROUP){
                              e.newMsgCount =0;
                              return e;
                            }else{
                              return e;
                            }
                          }).toList();
                          //var count = 0;
                          //if (state.message[index].newMsgCount > 0){
                            //BlocProvider.of<GlobalBloc>(context).add(EventSetBar3(count));
                            BlocProvider.of<ChatBloc>(context).add(EventFreshMessage());
                          //}

                        }
                        if(state.message[index].type == ConversionType.CONVERSATION_PEER){
                          im.clearReadCount(cid:state.message[index].cid);
                          message=state.message.map((e) {
                            if(e.type == ConversionType.CONVERSATION_PEER){
                              e.newMsgCount =0;
                              return e;
                            }else{
                              return e;
                            }
                          }).toList();
                          //var count = 0;
                          BlocProvider.of<ChatBloc>(context).add(EventFreshMessage());
                        }
                        var count =0;
                        message.map((e) {
                          count+= e.newMsgCount;
                        }).toList();
                       if(count ==0){
                         BlocProvider.of<GlobalBloc>(context).add(EventSetBar3(0));
                       }
                      var memberId = await LocalStorage.get("memberId");
                      if(memberId != "" && memberId != null){
                        memberId=memberId.toString();
                      }

                      final Conversion model = Conversion.fromMap({"memId":memberId,"cid":state.message[index].cid,"name":state.message[index].name});
                      if(state.message[index].type == ConversionType.CONVERSATION_GROUP){
                        BlocProvider.of<GroupBloc>(context).add(EventGroupFirstLoadMessage(memberId,state.message[index].cid));
                        Navigator.pushNamed(context, UnitRouter.to_group_chat, arguments: model);
                      }
                      if(state.message[index].type == ConversionType.CONVERSATION_PEER){
                        BlocProvider.of<PeerBloc>(context).add(EventFirstLoadMessage(memberId,state.message[index].cid));
                        Navigator.pushNamed(context, UnitRouter.to_chats, arguments: model);
                      }






                  },
                  onLongPress: (){
                    MoreWidgets.buildConversionMessagePop(context, _popString,
                        onItemClick: (res) {
                          switch (res) {
                            case 'one':
                              DialogUtil.showBaseDialog(context, '即将删除该对话的全部聊天记录',
                                  right: '删除', left: '再想想', rightClick: (res) {
                                    FltImPlugin im = FltImPlugin();
                                    im.deleteConversation(cid:state.message[index].cid);
                                    BlocProvider.of<ChatBloc>(context).add(EventFreshMessage());
                                    return null;
                                  });
                              break;

                          }
                          return null;
                        });
                  },
                  child: _buildListItem(state.message[index]));
            }),
      );

    }

    return
       Container();
  }
}
