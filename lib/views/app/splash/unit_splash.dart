
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_geen/app/router.dart';
import 'package:flutter_geen/storage/dao/local_storage.dart';
import 'package:flutter_geen/views/dialogs/CustomDialog.dart';
import 'package:fluwx/fluwx.dart';
import 'unit_paint.dart';
/// 说明: app 闪屏页
import 'package:flutter_screenutil/flutter_screenutil.dart';
class UnitSplash extends StatefulWidget {
  final double size;

  UnitSplash({this.size = 200});

  @override
  _UnitSplashState createState() => _UnitSplashState();
}

class _UnitSplashState extends State<UnitSplash> with TickerProviderStateMixin {
  AnimationController _controller;
  double _factor;
  Animation _curveAnim;

  bool _animEnd = false;
  bool _getPreLoginSuccess = false;
  /// 统一 key
  final String f_result_key = "result";
  /// 错误码
  final  String  f_code_key = "code";
  /// 回调的提示信息，统一返回 flutter 为 message
  final  String  f_msg_key  = "message";
  /// 运营商信息
  final  String  f_opr_key  = "operator";


  String _platformVersion = 'Unknown';
  String _result = "token=";
  var controllerPHone = new TextEditingController();
  bool _loading = false;
  String _token;


  @override
  void initState() {
    super.initState();
    _initFluwx();
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    _factor=0;
    _controller =
        AnimationController(duration: Duration(milliseconds: 1000), vsync: this)
          ..addStatusListener(_listenStatus)..forward();

    _curveAnim = CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);

   // initPlatformState();
  }


  @override
   void dispose() {
     _controller.dispose();
     super.dispose();
  }
  _initFluwx() async {
    await registerWxApi(
        appId: "wx45bdf8edd00e99ef",
        doOnAndroid: true,
        doOnIOS: true,
        universalLink: "https://your.univerallink.com/link/");
    var result = await isWeChatInstalled;
    print("is installed $result");
  }
  void _listenStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      setState(() {
        _animEnd = true;
        Future.delayed(Duration(milliseconds: 1000)).then((e) async {
          var ss = await LocalStorage.get("token");
          var sss =ss.toString();
          if(sss == "" || ss == null || ss == "null"){


                Navigator.of(context).pushReplacementNamed(UnitRouter.login);


          } else{
            //LocalStorage.save("token", '');
            var agree = await LocalStorage.get("agree");
            var agrees =agree.toString();
            if("1" == "1"){
              Navigator.of(context).pushReplacementNamed(UnitRouter.nav);

            } else{
              //LocalStorage.save("token", '');
              showDialog(context: context, builder: (ctx) => _buildDialog());
            }

          }

        });
      });
    }
  }


  static Widget _buildDialog() => Dialog(
    backgroundColor: Colors.white,
    elevation: 5,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    child: Container(
      width: 50.w,
      child: DeleteDialog(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final double winH = MediaQuery.of(context).size.height;
    final double winW = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          _buildLogo(Colors.blue),
          Container(
            width: winW,
            height: winH,
            child: CustomPaint(
              painter: UnitPainter(repaint: _curveAnim),
            ),
          ),
          _buildText(winH, winW),
          _buildHead(),
          _buildPower(),
        ],
      ),
    );
  }

  Widget _buildText(double winH, double winW) {
    final shadowStyle = TextStyle(
      fontSize: 70.sp,
      color: Theme.of(context).primaryColor,
      fontWeight: FontWeight.bold,
      shadows: [
        const Shadow(
          color: Colors.grey,
          offset: Offset(1.0, 1.0),
          blurRadius: 1.0,
        )
      ],
    );

    return Positioned(
      top: winH / 1.4,
      child: AnimatedOpacity(
          duration: const Duration(milliseconds: 600),
          opacity: _animEnd ? 1.0 : 0.0,
          child: Text(
            '鹊桥ERP管理系统',
            style: shadowStyle,
          )),
    );
  }

  final colors = [Colors.red, Colors.yellow, Colors.blue];

  Widget _buildLogo(Color primaryColor) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0),
        end: const Offset(0, -1.5),
      ).animate(_controller),
      child: RotationTransition(
          turns: _controller,
          child: ScaleTransition(
            scale: Tween(begin: 2.0, end: 1.0).animate(_controller),
            child: FadeTransition(
                opacity: _controller,
                child: Container(
                  height: 200.h,
                  child: FlutterLogo(
                    size: 120.sp,
                  ),
                )),
          )),
    );
  }

  Widget _buildHead() => SlideTransition(
      position: Tween<Offset>(
        end: const Offset(0, 0),
        begin: const Offset(0, -5),
      ).animate(_controller),
      child: Container(
        height: 80.h,
        width: 80.w,
        child: Image.asset('assets/images/ic_launcher.png'),
      ));

  Widget _buildPower() => Positioned(
        bottom: 80.h,
        right: 60.w,
        child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: _animEnd ? 1.0 : 0.0,
            child:  Text("Power off QueQiao Group",
                style: TextStyle(
                    color: Colors.grey,
                    shadows: [
                      Shadow(
                          color: Colors.black,
                          blurRadius: 1,
                          offset: Offset(0.3, 0.3))
                    ],
                    fontSize: 32.sp))),
      );
}
