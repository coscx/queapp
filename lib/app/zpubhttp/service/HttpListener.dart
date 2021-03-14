/*
 * 功能：数据响应事件
 * 需要传入的键：
 * 传入的值类型：
 * 传入的值含义：
 * 是否必传 ：
 * 作者：郑朝军 on 2019/4/7 23:23
 * 邮箱：1250393285@qq.com
 * 公司：武汉智博创享科技有限公司
 */
abstract class HttpListener
{
  void onDbSucceed(String method, Object values);

  void onDbFaild(String method, Object values);

  void onNetWorkSucceed(String method, Object values);

  void onNetWorkFaild(String method, Object values);

  void onOtherSucceed(String method, Object values);

  void onOtherFaild(String method, Object values);

  void onException(String method, Object e);

  void onCancel(String method);
}
