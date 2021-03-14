/*
 * 功能：Http键值常量
 * 需要传入的键：
 * 传入的值类型：
 * 传入的值含义：
 * 是否必传 ：
 * 作者：郑朝军 on 2019/4/7 23:23
 * 邮箱：1250393285@qq.com
 * 公司：武汉智博创享科技有限公司
 */
class HttpKeyValueConstant
{
  /*
   * 网络参数key
   */
  static const String API_METHOD = "method";
  static const String PARAM_TICK = "timestamp";
  static const String PARAM_NONCE = "nonce";
  static const String PARAM_PARTNER = "partner";
  static const String PARAM_SIGN = "signature";
  static const String PARAM_TOKEN = "session_token";
  static const String PARAM_USER_ID = "userid";
  static const String PARAM_APP_KEY = "appkey";
  static const String PARAM_PAGER_NO = "pageno";
  static const String PARAM_PAGER_SIZE = "pagesize";
  static const String PARAM_PAGER_INIT = "init";
  static const String PARAM_COUNT = "_count";
  static const String PARAM_CODE = "_code";
  static const String PARAM_SESSIONID = "sessionid";

  /*
   * 网络参数value
   */

  /*
   * 分页数量<br/>
   */
  static const int VALUE_MIN_SIZE = 5;

  /*
   * 分页数量<br/>
   */
  static const int VALUE_PAGER_SIZE = 15;

  /*
   * 最大分页数量<br/>
   */
  static const int VALUE_MAX_PAGER_SIZE = 999;

  /*
   * token的值可以随时变化的值
   */
  static String VALUE_TOKEN = "";

  /*
   * 自增数
   */
  static int VALUE_COUNT = 0;
}
