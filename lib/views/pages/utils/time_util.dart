import 'package:flutter_geen/views/pages/utils/date_util.dart';

class TimeUtil {



  static String chatTimeFormat(int timestamp){
    var showTime ;
    int zeroTmp = DateTime.now().millisecondsSinceEpoch;
    var today = DateTime.now();
    var times =today.year.toString()+"-" +(today.month.toString().length ==2?today.month.toString():"0"+today.month.toString() )+"-"+(today.day.toString().length==2?today.day.toString():"0"+today.day.toString()) +" 00:00:00";
    var dd =DateTime.parse(times).millisecondsSinceEpoch;
    zeroTmp=dd;
    int nows=zeroTmp - (zeroTmp + 8 * 3600 *1000) % (86400*1000);
    //获取当前的时间,yyyy-MM-dd HH:mm
    String nowTime = DateUtil.getDateStrByMs(new DateTime.now().millisecondsSinceEpoch, format: DateFormat.ZH_MONTH_DAY_HOUR_MINUTE);
    //当前消息的时间,yyyy-MM-dd HH:mm
    String indexTime = DateUtil.getDateStrByMs(timestamp*1000, format: DateFormat.ZH_YEAR_MONTH_DAY_HOUR_MINUTE);
    String nowTime1 = DateUtil.getDateStrByMs(new DateTime.now().millisecondsSinceEpoch, format: DateFormat.ZH_NORMAL);
    //当前消息的时间,yyyy-MM-dd HH:mm
    String indexTime1 = DateUtil.getDateStrByMs(timestamp*1000, format: DateFormat.ZH_NORMAL);
    if (DateUtil.formatDateTime1(indexTime1, DateFormat.YEAR) != DateUtil.formatDateTime1(nowTime1, DateFormat.YEAR)) {
      //对比年份,不同年份，直接显示yyyy-MM-dd HH:mm
      showTime = indexTime1;
    } else if (DateUtil.formatDateTime1(indexTime1, DateFormat.ZH_YEAR_MONTH) != DateUtil.formatDateTime1(nowTime1, DateFormat.ZH_YEAR_MONTH)) {
      //年份相同，对比年月,不同月或不同日，直接显示MM-dd HH:mm
      if ((timestamp*1000)> nows ){
        showTime=""+DateUtil.formatDateTime1(indexTime, DateFormat.ZH_HOUR_MINUTE).substring( "MM月dd日 ".length,);
      } else if ((timestamp*1000> nows-1*24*3600*1000) && (timestamp*1000<nows)){
        showTime="昨天 "+DateUtil.formatDateTime1(indexTime, DateFormat.ZH_HOUR_MINUTE).substring( "MM月dd日 ".length,);
      }else if ((timestamp*1000> nows-2*24*3600*1000) && (timestamp*1000<1*24*3600*1000)){
        showTime="前天 "+DateUtil.formatDateTime1(indexTime, DateFormat.ZH_HOUR_MINUTE).substring( "MM月dd日 ".length,);
      } else if ((timestamp*1000) > nows-7*24*3600*1000 && (timestamp*1000) < nows-2*24*3600*1000){
        showTime=DateUtil.getZHWeekDay(DateTime.fromMillisecondsSinceEpoch(timestamp*1000, isUtc: false))+" "+DateUtil.formatDateTime1(indexTime, DateFormat.ZH_HOUR_MINUTE).substring( "MM月dd日 ".length,);
      } else{
        showTime = DateUtil.formatDateTime1(indexTime, DateFormat.ZH_MONTH_DAY_HOUR_MINUTE);
      }

    }  else {
      //否则HH:mm
      showTime = DateUtil.formatDateTime1(indexTime, DateFormat.ZH_HOUR_MINUTE);
    }

    return showTime;
  }

}