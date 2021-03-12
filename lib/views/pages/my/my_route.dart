import 'package:flutter/material.dart';
import 'package:flutter_geen/app/router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class MyRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyPage();
  }
}

class _MyPage extends State<MyRoute> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    print("MyRoute initState");
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
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
      title:  Text('个人中心',style: TextStyle(color: Colors.black, fontSize: 50.sp,fontWeight: FontWeight.bold)),
      //leading:const Text('Demo',style: TextStyle(color: Colors.black, fontSize: 15)),
      backgroundColor: Colors.white,
      elevation: 0, //去掉Appbar底部阴影
      actions:<Widget> [


        SizedBox(
          width: 80.w,
        )
      ],
    ),
    body:ListView(
      children: <Widget>[
        _getHeaderCell(),
        Padding(padding: EdgeInsets.only(top: 24.h)),
        _getItemCell('我的相册'),
        _getItemCell('个人基本资料'),
        _getItemCell('择偶标准'),
        _getItemCell('内心独白'),
        Padding(padding: EdgeInsets.only(top: 24.h)),
        _getItemCell('退出账号'),
        _getItemCell('客服'),
      ],
    )));
  }

  Widget _getHeaderCell() {
    return Stack(
      children: <Widget>[
        Image.asset(
          'assets/images/set_image_bg.png',
          height: 320.h,
          width: ScreenUtil().screenWidth,
          fit: BoxFit.cover,
        ),
        Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 16.h)),
              CircleAvatar(
                backgroundImage: new NetworkImage(
                    'https://queqiaoerp.oss-cn-shanghai.aliyuncs.com/customers/images/2020/07/1594898594_JA79FDbma4.jpg'),
                radius: 100.w,
              ),
              Padding(padding: EdgeInsets.only(top: 16.h)),
              Text('上传头像'),
              Padding(padding: EdgeInsets.only(top: 16.h)),
              Text(
                '将作为个人封面图，展示到首页',
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _getItemCell(String text) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border:
            Border(bottom: BorderSide(width: 0.5, color: Color(0xFFd9d9d9))),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Text(
              text,
              style: TextStyle(fontSize: 38.sp, color: Colors.black),
            )),
            Image.asset(
              'assets/images/icon_choose.png',
              width: 20.w,
              height: 30.h,
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
