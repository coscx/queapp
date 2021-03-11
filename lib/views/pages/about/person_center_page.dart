import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geen/app/router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_geen/views/dialogs/user_detail.dart';
import 'package:flutter_geen/app/api/issues_api.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:flutter_geen/app/utils/Toast.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_geen/storage/dao/local_storage.dart';
import 'package:flutter_geen/views/dialogs/delete_category_dialog.dart';
class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> with AutomaticKeepAliveClientMixin<MinePage> {
  final double _appBarHeight = 180.0;
  String name ="MSTAR";
  String bind="微信绑定";
  final String _userHead =
      'https://img.bosszhipin.com/beijin/mcs/useravatar/20171211/4d147d8bb3e2a3478e20b50ad614f4d02062e3aec7ce2519b427d24a3f300d68_s.jpg';

  @override
  bool get wantKeepAlive => true;
  @override
   initState()  {
    super.initState();
    fluwx.weChatResponseEventHandler.distinct((a, b) => a == b).listen((res) async {
      if (res is fluwx.WeChatAuthResponse) {
        if(res.state =="wechat_sdk_demo_bind") {
          var result = await IssuesApi.bindAppWeChat(res.code);
          if (result['code'] == 200) {
            _showToast(context, "绑定成功", false);
          } else {
            _showToast(context, "绑定成功", false);
          }
        }
      }
    });
    Future.delayed(Duration(milliseconds: 1)).then((e) async {
      var ss =  await LocalStorage.get("name");
      var openidF=  await LocalStorage.get("openid");
      var sss =ss.toString();
      var openids =openidF.toString();
      if(sss == "" || ss == null || ss == "null"){
      }else{
       setState(() {
         name=ss;
       });
      }
      if(openids == "" || openids == null || openids == "null"){
      }else{
        setState(() {
          bind="已绑定微信";
        });
      }


    });

  }

  _bindWx(BuildContext context,String img) {
    showDialog(
        context: context,
        builder: (ctx) => Dialog(
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.w))),
          child: Container(
            width: 50.w,
            child: DeleteCategoryDialog(
              title: '此账号已绑定微信',
              content: '是否确定重新绑定?',
              onSubmit: () {
                fluwx
                    .sendWeChatAuth(
                    scope: "snsapi_userinfo", state: "wechat_sdk_demo_bind")
                    .then((data) {});
                Navigator.of(context).pop();
              },
            ),
          ),
        ));
  }
  _showToast(BuildContext ctx, String msg, bool collected) {
    // Toasts.toast(
    //   ctx,
    //   msg,
    //   duration: Duration(milliseconds:  5000 ),
    //   action: collected
    //       ? SnackBarAction(
    //       textColor: Colors.white,
    //       label: '收藏夹管理',
    //       onPressed: () => Scaffold.of(ctx).openEndDrawer())
    //       : null,
    // );
    BotToast.showNotification(

      leading: (cancel) => Container(
          child: IconButton(
            icon: Icon(Icons.error, color: Colors.redAccent),
            onPressed: cancel,
          )),
      title: (text)=>Container(
        child: Text(msg,style: new TextStyle(
            color: Colors.black, fontSize: 40.sp)),
      ),
      duration: const Duration(seconds: 5),

      trailing: (cancel) => Container(
        child: IconButton(
          icon: Icon(Icons.cancel),
          onPressed: cancel,
        ),
      ),
      onTap: () {
        BotToast.showText(text: 'Tap toast');
      },); //弹出简单通知Toast
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
      backgroundColor:  Colors.white,
        body:  CustomScrollView(
        physics:const BouncingScrollPhysics() ,
        slivers: <Widget>[
          new SliverAppBar(
            backgroundColor: Colors.white,
            expandedHeight: _appBarHeight,
            flexibleSpace: new FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: new Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  const DecoratedBox(
                    decoration: const BoxDecoration(
                      gradient: const LinearGradient(
                        begin: const Alignment(0.0, -1.0),
                        end: const Alignment(0.0, -0.4),
                        colors: const <Color>[
                          const Color(0x00000000),
                          const Color(0x00000000)
                        ],
                      ),
                    ),
                  ),

                  Container(
                    height: ScreenUtil().setHeight(120),
                    width: ScreenUtil().setWidth(120),
                    alignment: FractionalOffset.topLeft,
                    child: Image.asset("assets/packages/images/friend_card_bg.png"),
                  ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: ScreenUtil().setWidth(50),
                      ),
                      Expanded(
                        flex: 1,
                        child: new Padding(
                          padding:  EdgeInsets.only(
                            top: 40.h,
                            right: 30.w,
                          ),
                          child: Container(
                            width: 100.h,
                            height: 100.h,
                            margin: EdgeInsets.fromLTRB(10.w, 5.h, 5.w, 0.h),
                            child:Lottie.asset('assets/packages/lottie_flutter/great.json'),
                          ),
                        ),
                      ),
                       Expanded(
                        flex: 3,
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Padding(
                              padding:  EdgeInsets.only(
                                top: 40.h,
                                left: 3.w,
                                bottom: 5.h,
                              ),
                              child: new Text(
                                name,
                                style: new TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                            ),

                              Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  "assets/packages/images/bb_id.svg",
                                  //color: Colors.black87,
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(
                                    left: 3.w,
                                  ),
                                  child: new Text(
                                    '121.423.199',
                                    style: new TextStyle(
                                        color: Colors.grey, fontSize: 25.sp),
                                  ),
                                ),
                                ]),



                          ],
                        ),
                      ),
                      Padding(
                          padding:  EdgeInsets.only(
                            left: 0.0,
                            right: 20.w,
                            top: 40.h
                          ),
                          child:new Icon(
                            Icons.chevron_right,
                            color: Colors.grey,
                          )
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          new SliverList(
            delegate: new SliverChildListDelegate(
              <Widget>[
                new Container(
                  color: Colors.white,
                  child:  Padding(
                    padding:  EdgeInsets.only(
                      top: 0.h,
                      bottom: 10.h,
                      left: 20.w,
                      right: 20.w
                    ),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        new ContactItem(
                          count: '696',
                          title: '我的审批',
                        ),
                        new ContactItem(
                          count: '0',
                          title: '已提交',
                        ),
                        new ContactItem(
                          count: '71',
                          title: '用户管理',
                        ),
                        new ContactItem(
                          count: '53',
                          title: '权限管理',
                        ),
                      ],
                    ),
                  ),
                ),



                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.w),
                        color: Colors.white,
                        boxShadow: [BoxShadow(color: Color(0x19000000), offset: Offset(0.5, 0.5),  blurRadius: 1.5, spreadRadius: 1.5),  BoxShadow(color: Colors.white)],
                    ),
                    margin: EdgeInsets.fromLTRB(30.w,20.h,30.w,0),
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
                              width: ScreenUtil().setWidth(10.w),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.pushNamed(context, UnitRouter.create_user_page);
                              },
                                child: Container(
                              padding:  EdgeInsets.only(
                                  top: 15.h,
                                  bottom: 15.h,

                              ),
                              child:  Column(children: <Widget>[
                                Container(
                                  height: 100.h,
                                  width: 100.w,
                                  alignment: FractionalOffset.topLeft,
                                  child: Image.asset("assets/packages/images/tab_match.webp"),
                                ),
                                Text(
                                  "我的审批",
                                  style: new TextStyle(color: Colors.black54, fontSize: 24.sp),
                                ),

                              ]),
                            )),


                        GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, UnitRouter.select_page);
                          },
                          child:Container(
                              padding:  EdgeInsets.only(
                                  top: 10.h,
                                  bottom: 10.h,

                              ),
                              child:  Column(children: <Widget>[
                                Container(
                                  height: 100.h,
                                  width: 100.w,
                                  alignment: FractionalOffset.topLeft,
                                  child: Image.asset("assets/packages/images/tab_match.webp"),
                                ),
                                Text(
                                  "已提交",
                                  style: new TextStyle(color: Colors.black54, fontSize: 24.sp),
                                ),

                              ]),
                            )),

                    GestureDetector(
                      onTap: (){
                        //Navigator.pushNamed(context, UnitRouter.select_page);
                        _userDetail(context);


                      },
                      child:Container(
                              padding:  EdgeInsets.only(
                                  top: 10.h,
                                  bottom: 10.h,

                              ),
                              child:  Column(children: <Widget>[
                                Container(
                                  height: 100.h,
                                  width: 100.w,
                                  alignment: FractionalOffset.topLeft,
                                  child: Image.asset("assets/packages/images/tab_match.webp"),
                                ),
                                Text(
                                  "用户管理",
                                  style: new TextStyle(color: Colors.black54, fontSize: 24.sp),
                                ),

                              ]),
                            )),

                            Container(
                              padding:  EdgeInsets.only(
                                  top: 10.h,
                                  bottom: 10.h,

                              ),
                              child:  Column(children: <Widget>[
                                Container(
                                  height: 100.h,
                                  width: 100.w,
                                  alignment: FractionalOffset.topLeft,
                                  child: Image.asset("assets/packages/images/tab_match.webp"),
                                ),
                                Text(
                                  "权限管理",
                                  style: new TextStyle(color: Colors.black54, fontSize: 24.sp),
                                ),

                              ]),
                            ),

                            SizedBox(
                              width: ScreenUtil().setWidth(10.w),
                            ),

                          ],
                        ))),


                 Container(
                  color: Colors.white,
                  margin:  EdgeInsets.only(top: 40.h),
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () async {

                          var ss =  await LocalStorage.get("openid");
                          var sss =ss.toString();
                          if(sss == "" || ss == null || ss == "null"){
                            fluwx
                                .sendWeChatAuth(
                                scope: "snsapi_userinfo", state: "wechat_sdk_demo_bind")
                                .then((data) {});
                          }else{
                            _bindWx(context,"");
                          }


                        },
                         child: MenuItem(
                          icon: "assets/packages/images/login_wechat.svg",
                          title: bind,
                          ),
                       ),
                      // new MenuItem(
                      //   icon: "assets/packages/images/ic_profile_mentor_ship.svg",
                      //   title: '师徒关系',
                      // ),
                      //
                      // new MenuItem(
                      //   icon: "assets/packages/images/ic_my_bag.svg",
                      //   title: '我的背包',
                      // ),
                      // new MenuItem(
                      //   icon: "assets/packages/images/ic_activity.svg",
                      //   title: '订单',
                      // ),
                      // new MenuItem(
                      //   icon: "assets/packages/images/ic_app_review.svg",
                      //   title: '去好评',
                      // ),
                      // new MenuItem(
                      //   icon: "assets/packages/images/ic_contribute.svg",
                      //   title: '贡献题目',
                      // ),
                      // new MenuItem(
                      //   icon: "assets/packages/images/ic_invite.svg",
                      //   title: '邀请有礼',
                      // ),
                      // new MenuItem(
                      //   icon: "assets/packages/images/ic_activity.svg",
                      //   title: '活动',
                      // ),
                      // new MenuItem(
                      //   icon: "assets/packages/images/ic_settings.svg",
                      //   title: '账号设置',
                      // ),
                      // new MenuItem(
                      //   icon: "assets/packages/images/ic_service.svg",
                      //   title: '在线客服',
                      // ),
                      // new MenuItem(
                      //   icon: "assets/packages/images/ic_help.svg",
                      //   title: '帮助',
                      // ),
                      // new MenuItem(
                      //   icon: "assets/packages/images/ic_contact.svg",
                      //   title: '联系我们',
                      // ),

                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    )
    );
  }

  _userDetail(BuildContext context) async {
    BotToast.showLoading();

    var result= await IssuesApi.getUserDetail('a87ca69e-7092-493e-9f13-2955aeaf2d0f');
    if  (result['code']==200){
      showDialog(
          context: context,
          builder: (ctx) => UserDetailDialog(result['data'])

      );
    } else{

    }
    BotToast.closeAllLoading();
  }
}

class ContactItem extends StatelessWidget {
  ContactItem({Key key, this.count, this.title, this.onPressed})
      : super(key: key);

  final String count;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: onPressed,
      child:  Column(
        children: [
           Padding(
            padding:  EdgeInsets.only(
              bottom: 4.h,
            ),
            child: new Text(count, style: new TextStyle(fontSize: 36.sp)),
          ),
          new Text(title,
              style: new TextStyle(color: Colors.black54, fontSize: 22.sp)),
        ],
      ),
    );
  }
}
class MenuItem extends StatelessWidget {
  MenuItem({Key key, this.icon, this.title, this.onPressed}) : super(key: key);

  final String icon;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: onPressed,
      child: new Column(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              top: 12.0,
              right: 20.0,
              bottom: 10.0,
            ),
            child: new Row(
              children: [
                new Padding(
                  padding: const EdgeInsets.only(
                    right: 12.0,
                  ),
                  child: new SvgPicture.asset(
                    icon,
                   // color: Colors.black54,
                  ),
                ),
                new Expanded(
                  child: new Text(
                    title,
                    style: new TextStyle(color: Colors.black87, fontSize: 16.0),
                  ),
                ),
                new Icon(
                  Icons.chevron_right,
                  color: Colors.black12,
                )
              ],
            ),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0,top: 13),
            child: new Container(),
          )
        ],
      ),
    );
  }
}