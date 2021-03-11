import 'package:flutter_sound/public/util/flutter_sound_helper.dart';

class CommonUtil{

     /// 获取录音文件秒数
  static  Future<double> getDuration( String _path) async {
    Duration d = await flutterSoundHelper.duration(_path);
    if (d ==null) return 0;
    var _duration = d != null ? d.inMilliseconds / 1000.0: 0.00;
    print("_duration == $_duration");
    var minutes = d.inMinutes;
    var seconds = d.inSeconds % 60;
    var millSecond = d.inMilliseconds % 1000 ~/ 10;
    var _recorderTxt = "";
    if (minutes > 9) {
      _recorderTxt = _recorderTxt + "$minutes";
    } else {
      _recorderTxt = _recorderTxt + "0$minutes";
    }
    if (seconds > 9) {
      _recorderTxt = _recorderTxt + ":$seconds";
    } else {
      _recorderTxt = _recorderTxt + ":0$seconds";
    }
    if (millSecond > 9) {
      _recorderTxt = _recorderTxt + ":$millSecond";
    } else {
      _recorderTxt = _recorderTxt + ":0$millSecond";
    }
    print(_recorderTxt);
    return  d.inMilliseconds / 01000;
  }

}