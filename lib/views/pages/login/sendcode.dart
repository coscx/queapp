import 'package:flui/flui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_geen/app/router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svgaplayer_flutter/player.dart';

class SendCodePage extends StatelessWidget {
  final String tel ;
  SendCodePage({this.tel});
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
                    expandedHeight: 270.h,
                    paddingTop: MediaQuery.of(context).padding.top,
                    coverImgUrl: 'http://r.photo.store.qq.com/psb?/V14dALyK4PrHuj/iEyZ0zEnZQmbqfs.BUMe9Visc92Tqohh0OKKP0JOtVU!/r/dMMAAAAAAAAA',
                    tel: tel

                ),
              ),
              SliverToBoxAdapter(
                child: FilmContent(tel: tel,),
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
  final String tel;
  String statusBarMode = 'dark';

  SliverCustomHeaderDelegate({
    this.collapsedHeight,
    this.expandedHeight,
    this.paddingTop,
    this.coverImgUrl,
    this.title,
    this.tel
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
    if(shrinkOffset <= 50 && this.statusBarMode == 'dark') {
      this.statusBarMode = 'light';
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ));
    } else if(shrinkOffset > 50 && this.statusBarMode == 'light') {
      this.statusBarMode = 'dark';
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ));
    }
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

          // Container(child: Image.network(this.coverImgUrl, fit: BoxFit.cover)),


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
                        "输入验证码",
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
          Positioned(
            left: 50.w,
            right: 20.w,
            top: 80.h,
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
                        "已发送至"+tel,
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),

          // Container(
          //   margin:  EdgeInsets.only(top: 157.h),
          //   child: SVGASimpleImage(
          //       assetsName: "assets/svga/waves.svga"),
          // ),
        ],
      ),
    );
  }
}
class FilmContent extends StatefulWidget {
  final String tel ;
  FilmContent({this.tel});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FilmState();
  }
}
class FilmState extends State<FilmContent> {
  bool check =true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin:  EdgeInsets.only(left: 100.w,right: 80.w,top: 60.h),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: 100.h,
                  maxWidth: ScreenUtil().screenWidth
              ),
              child:    FLPinCodeTextField(
                //controller: _pinController,
                obscure: false,
                boxWidth: 100.w,
                boxHeight: 100.h,
                pinLength: 4,
                minSpace: 40.w,
                autofocus: false,
                textStyle: TextStyle(fontSize: 42.sp, fontWeight: FontWeight.w900,color: Colors.black),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.w, 15.h, 17.w, 22.h),
                  border: OutlineInputBorder(),
                  //hintStyle: TextStyle(fontSize: 42.sp, fontWeight: FontWeight.w900,color: Colors.black),
                  //focusColor: Colors.redAccent,
                  //fillColor: Colors.grey,
                  //filled: true
                ),
                onChanged: (text) {
                  print('change -- $text');
                },
                onSubmitted: (text) {
                  print('submit -- $text');
                },
                onEditingComplete: () {
                  print('editing complete');

                  Navigator.of(context).pushReplacementNamed(UnitRouter.nav);
                },
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
              onPressed: (){},
              child: Text("重新发送验证码",
                  style: TextStyle(color: Colors.white, fontSize: 30.sp)),
            ),
          ),



        ],
      ),
    );
  }
}