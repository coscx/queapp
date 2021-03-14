/*
 * 功能：Log统一管理类
 * 需要传入的键：
 * 传入的值类型：
 * 传入的值含义：
 * 是否必传 ：
 * 作者：郑朝军 on 2019/4/7 23:23
 * 邮箱：1250393285@qq.com
 * 公司：武汉智博创享科技有限公司
 */
class HttpLog
{
  /*
   * 默认的输出标签
   */
  static final String TAG = "输出";

  static bool isDebug = false;

  static void v(String tag, Object msg)
  {
    if (isDebug)
    {
      recordLogVerbose(tag, msg);
    }
  }

  static void d(String tag, Object msg)
  {
    if (isDebug)
    {
      recordLogDebug(tag, msg);
    }
  }

  static void i(String tag, Object msg)
  {
    if (isDebug)
    {
      recordLogInfo(tag, msg);
    }
  }

  static void w(String tag, Object msg)
  {
    if (isDebug)
    {
      recordLogWarn(tag, msg);
    }
  }

  static void e(String tag, Object msg)
  {
    if (isDebug)
    {
      recordLogError(tag, msg);
    }
  }

  static void ln()
  {
    if (isDebug)
    {
      print("");
    }
  }

  static void recordLogVerbose(String tag, Object msg)
  {
    if (msg == null)
    {
      msg = "null";
    }
    String result = msg.toString().replaceAll("<br/>", "\n") + "\n";
    print('${tag}:  ${result}');
  }

  static void recordLogDebug(String tag, Object msg)
  {
    if (msg == null)
    {
      msg = "null";
    }
    String result = msg.toString().replaceAll("<br/>", "\n") + "\n";
    print('${tag}:  ${result}');
  }

  static void recordLogInfo(String tag, Object msg)
  {
    if (msg == null)
    {
      msg = "null";
    }
    String result = msg.toString().replaceAll("<br/>", "\n") + "\n";
    print('${tag}:  ${result}');
  }

  static void recordLogWarn(String tag, Object msg)
  {
    if (msg == null)
    {
      msg = "null";
    }
    String result = msg.toString().replaceAll("<br/>", "\n") + "\n";
    print('${tag}:  ${result}');
  }

  static void recordLogError(String tag, Object msg)
  {
    if (msg == null)
    {
      msg = "null";
    }
    String result = msg.toString().replaceAll("<br/>", "\n") + "\n";
    print('${tag}:  ${result}');
  }
}
