import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_geen/app/router.dart';
import 'package:flutter_geen/blocs/bloc_exp.dart';
import 'package:flutter_geen/views/app/splash/unit_splash.dart';
import 'package:flutter_screenutil/screenutil_init.dart';


/// 说明: 主程序

class FlutterGeen extends StatelessWidget {

  final bool isPad;

  FlutterGeen({this.isPad});
  final EasyLoadingBuilder=EasyLoading.init();
  final botToastBuilder = BotToastInit();  //1.调用BotToastInit
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<GlobalBloc, GlobalState>(builder: (_, state) {
      return ScreenUtilInit(
          designSize: isPad?Size(1536,2048):Size(750, 1334),
      allowFontScaling: true,
      child:MaterialApp(
//            debugShowMaterialGrid: true,
            showPerformanceOverlay: state.showPerformanceOverlay,
//            showSemanticsDebugger: true,
//            checkerboardOffscreenLayers:true,
//            checkerboardRasterCacheImages:true,
            title: '鹊桥',
            debugShowCheckedModeBanner: false,
            onGenerateRoute: UnitRouter.generateRoute,
            theme: ThemeData(
              primarySwatch: state.themeColor,
              fontFamily: state.fontFamily,
            ),
            home: UnitSplash(),
            builder: (context, child) {
              child = EasyLoadingBuilder(context,child);  //do something
              child = botToastBuilder(context,child);
              return child;
            },
            navigatorObservers: [BotToastNavigatorObserver()], //2.注册路由观察者
      ));
    });
  }

}
