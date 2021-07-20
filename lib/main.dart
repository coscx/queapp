import 'dart:io';
//import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_geen/views/app/bloc_wrapper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'views/app/flutter_geen.dart';
import 'package:device_info/device_info.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GestureBinding.instance.resamplingEnabled = true;
  bool isIpad =false;
  if (Platform.isAndroid == false) {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    IosDeviceInfo info = await deviceInfo.iosInfo;
    print('======a=======a=======a=======a========a=======${info.model}');
    print('======a=======a=======a=======a========a=======${info.utsname.machine.toLowerCase()}');
    print('======a=======a=======a=======a========a=======${info.systemName}');
    isIpad = info.utsname.machine.toLowerCase().contains("ipad");
    isIpad = info.model=="iPad";
  }
  SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor:Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);


  runApp(MediaQueryFromWindow(
    child: ScreenApp(isPad: isIpad,),
  ));
  // await enableFluttifyLog(false);
  // await AmapService.instance.init(
  //     iosKey: "c4be7cd9605ca4f1b20ec76030cd1f75",
  //     androidKey: "e912257673899746091f6ba47674dc37"
  // );

  Future<bool> checkIpadFunc() async {
    bool isIpad =false;

    return isIpad;
  }
}
class MediaQueryFromWindow extends StatefulWidget {
  const MediaQueryFromWindow({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _MediaQueryFromWindowsState createState() => _MediaQueryFromWindowsState();
}

class _MediaQueryFromWindowsState extends State<MediaQueryFromWindow> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  // ACCESSIBILITY

  @override
  void didChangeAccessibilityFeatures() {
    setState(() {
      // The properties of window have changed. We use them in our build
      // function, so we need setState(), but we don't cache anything locally.
    });
  }

  // METRICS

  @override
  void didChangeMetrics() {
    setState(() {
      // The properties of window have changed. We use them in our build
      // function, so we need setState(), but we don't cache anything locally.
    });
  }

  @override
  void didChangeTextScaleFactor() {
    setState(() {
      // The textScaleFactor property of window has changed. We reference
      // window in our build function, so we need to call setState(), but
      // we don't need to cache anything locally.
    });
  }

  // RENDERING
  @override
  void didChangePlatformBrightness() {
    setState(() {
      // The platformBrightness property of window has changed. We reference
      // window in our build function, so we need to call setState(), but
      // we don't need to cache anything locally.
    });
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData.fromWindow(WidgetsBinding.instance.window),
      child: widget.child,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

class ScreenApp extends StatefulWidget {
  final bool  isPad;

  const ScreenApp({
    Key key,
    @required this.isPad

  }) : super(key: key);

  @override
  _ScreenAppState createState() => _ScreenAppState();
}

class _ScreenAppState extends State<ScreenApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    // 注册
    ScreenUtil.init(
      BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: MediaQuery.of(context).size.height),
          designSize: widget.isPad?Size(1536,2048):Size(750, 1334),
    );
    return BlocWrapper(child: FlutterGeen(isPad: widget.isPad,));
  }
}
