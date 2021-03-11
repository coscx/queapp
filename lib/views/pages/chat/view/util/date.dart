String tranFormatTime(int timestamp) {
  if (timestamp == 0 || timestamp == null) {
    return "";
  }
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp*1000);


  String formatTime =
      numberUtils(date.year) +'-'+numberUtils(date.month) +'-'+numberUtils(date.day)+' '+numberUtils(date.hour)+':'+numberUtils(date.minute)+':'+numberUtils(date.second);
  return formatTime;
}
 String numberUtils(int number) {
  if (number < 10) {
    return "0${number.toString()}";
  }
  return number.toString();
}
String tranImTime(String time) {
  if (time == "") return "";
  String duration;
  int minute = 60;
  int hour = minute * 60;
  int day = hour * 24;
  int week = day * 7;
  int month = day * 30;

  var nowTime = DateTime.now().millisecondsSinceEpoch / 1000; //到秒
  var createTime = DateTime.parse(time).millisecondsSinceEpoch / 1000; //到秒
  var leftTime = nowTime - createTime;

  if (leftTime / month > 6) {
    duration = time;
  } else if (leftTime / month >= 1) {
    duration = (leftTime / month).floor().toString() + '月前';
  } else if (leftTime / week >= 1) {
    duration = (leftTime / week).floor().toString() + '周前';
  } else if (leftTime / day >= 1) {
    duration = (leftTime / day).floor().toString() + '天前';
  } else if (leftTime / hour >= 1) {
    duration = (leftTime / hour).floor().toString() + '小时前';
  } else if (leftTime / minute >= 1) {
    duration = (leftTime / minute).floor().toString() + '分钟前';
  } else {
    duration = '刚刚';
  }
  return duration;
}
