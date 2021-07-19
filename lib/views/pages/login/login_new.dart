import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_geen/app/router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svgaplayer_flutter/player.dart';

class LoginNewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child:Scaffold(
          extendBodyBehindAppBar: true,

          body: CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: <Widget>[
              SliverPersistentHeader(
                pinned: true,
                delegate: SliverCustomHeaderDelegate(
                    title: '（现为新加功能测试页面）',
                    collapsedHeight: 40.h,
                    expandedHeight: 430.h,
                    paddingTop: 0,
                    coverImgUrl: 'http://r.photo.store.qq.com/psb?/V14dALyK4PrHuj/iEyZ0zEnZQmbqfs.BUMe9Visc92Tqohh0OKKP0JOtVU!/r/dMMAAAAAAAAA'
                ),
              ),
              SliverToBoxAdapter(
                child: FilmContent(),
              )
            ],
          ),
        ));
  }
}

/// [SliverPersistentHeaderDelegate]在原有Widget的基础上封装了滚动坐标，在build方法中的shrinkOffset参数
/// 这里利用继承原生组件实现了随滚动改变header透明度的效果
class SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double collapsedHeight;
  final double expandedHeight;
  final double paddingTop;
  final String coverImgUrl;
  final String title;
  String statusBarMode = 'dark';

  SliverCustomHeaderDelegate({
    this.collapsedHeight,
    this.expandedHeight,
    this.paddingTop,
    this.coverImgUrl,
    this.title,
  });

  @override
  double get minExtent => this.collapsedHeight + this.paddingTop;

  @override
  double get maxExtent => this.expandedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  void updateStatusBarBrightness(shrinkOffset) {
    // if(shrinkOffset <= 50 && this.statusBarMode == 'dark') {
    //   this.statusBarMode = 'light';
    //   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarBrightness: Brightness.light,
    //     statusBarIconBrightness: Brightness.light,
    //   ));
    // } else if(shrinkOffset > 50 && this.statusBarMode == 'light') {
    //   this.statusBarMode = 'dark';
    //   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarBrightness: Brightness.dark,
    //     statusBarIconBrightness: Brightness.dark,
    //   ));
    // }
  }

  Color makeStickyHeaderBgColor(shrinkOffset) {
    final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255).clamp(0, 255).toInt();
    return Color.fromARGB(alpha, 255, 255, 255);
  }

  Color makeStickyHeaderTextColor(shrinkOffset, isIcon) {
    if(shrinkOffset <= 50) {
      return isIcon ? Colors.white : Colors.transparent;
    } else {
      final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255).clamp(0, 255).toInt();
      return Color.fromARGB(alpha, 0, 0, 0);
    }
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    this.updateStatusBarBrightness(shrinkOffset);
    return Container(
      height: this.maxExtent,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.pinkAccent,
                    Colors.lightBlue,
                  ],
                ),
              )),
          // Column(
          //   verticalDirection: VerticalDirection.up,
          //   crossAxisAlignment: CrossAxisAlignment.end,
          //   children: [
          //
          //     SVGASimpleImage(
          //         assetsName: "assets/svga/waves.svga"),
          //
          //   ],
          // ),
          // Container(child: Image.network(this.coverImgUrl, fit: BoxFit.cover)),

          //   Positioned(
          //   //left: 50.w,
          //   //right: 20.w,
          //    // top: 323.h,
          //     bottom: 0.h,
          //   child: Container(
          //
          //   width: ScreenUtil().screenWidth,
          //   margin:  EdgeInsets.only(top: 0.h),
          //   child: SVGASimpleImage(
          //       assetsName: "assets/svga/waves.svga"),
          // )),

          Positioned(
            left: 50.w,
            right: 20.w,
            top: 40.h,
            child: Container(
              color: this.makeStickyHeaderBgColor(shrinkOffset),
              child: SafeArea(
                bottom: false,
                child: Container(
                  height: this.collapsedHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      Text(
                        "手机号注册登录",
                        style: TextStyle(
                          fontSize: 38.sp,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: this.makeStickyHeaderTextColor(shrinkOffset, true),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin:  EdgeInsets.only(top: 177.h),
            child: Column(
              children: [
                Container(
                    height: 90.h,
                    child: Image.asset("assets/images/login_girl0.png")),
                Container(
                  margin:  EdgeInsets.only(top: 17.h),
                  child: Text(
                    "为您匹配到121位附近的异性,注册登录后可见！",
                    style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
class FilmContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FilmState();
  }
}
class FilmState extends State<FilmContent> {
  bool check =true;
  final TextEditingController _telController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin:  EdgeInsets.only(left: 30.w,right: 30.w,top: 20.h),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: 100.h,
                  maxWidth: ScreenUtil().screenWidth
              ),
              child: new TextField(
                controller: _telController,
                decoration: InputDecoration(
                  contentPadding:  EdgeInsets.symmetric(vertical: 4.w,horizontal: 30.h),
                  hintText: '请在此输入手机号码',
                  hintStyle:  TextStyle(
                    fontSize: 36.sp,
                    fontWeight: FontWeight.w900,
                    color: Colors.black26,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.w),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Colors.black12,
                ),

              ),

            ),

          ),
          Container(
            margin: EdgeInsets.only(top: 40.h, left: 30.w, right: 30.w,bottom: 30.h),
            height: 80.h,
            width: MediaQuery.of(context).size.width,
            child:
            RaisedButton(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40.w))),
              color: Colors.redAccent,
              onPressed: (){
                if (_telController.text.isEmpty){
                  return;
                }
                Navigator.of(context).pushReplacementNamed(UnitRouter.send_code,arguments: _telController.text);
              },
              child: Text("登   录",
                  style: TextStyle(color: Colors.white, fontSize: 30.sp)),
            ),
          ),


          Row(

            children: [
              Container(
                margin: EdgeInsets.only( left: 70.w,),
                child: Checkbox(
                    value: check,
                    tristate: false,
                    activeColor: Colors.red,
                    checkColor: Colors.white,
                    splashRadius: 20.h,
                    onChanged: (bool value) {
                      setState(() {
                        check=!check;
                      });
                    }),
              ),
              Container(

                child: Text(
                  "登陆后代表你同意用户协议和隐私政策",
                  style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w900,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}