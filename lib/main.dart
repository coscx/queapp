import 'dart:io';
// import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geen/views/app/bloc_wrapper.dart';
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
  runApp(BlocWrapper(child: FlutterGeen(isPad: isIpad,)));
  // await enableFluttifyLog(false);
  // await AmapService.instance.init(
  //     iosKey: "75f93121afcd226f0e822a19cf40e0ca",
  //     androidKey: "a130ae881342a409182da1c28197bf8e"
  // );

  Future<bool> checkIpadFunc() async {
    bool isIpad =false;

    return isIpad;
  }
}
