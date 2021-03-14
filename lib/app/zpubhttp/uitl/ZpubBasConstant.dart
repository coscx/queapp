/*
 * 功能：zpub_base级别的应用常量
 * 需要传入的键：
 * 传入的值类型：
 * 传入的值含义：
 * 是否必传 ：
 * 作者：郑朝军 on 2019/4/7 23:23
 * 邮箱：1250393285@qq.com
 * 公司：武汉智博创享科技有限公司
 */
class ZpubBasConstant
{
  /*
   * 分页数量<br/>
   */
  static const int PAGER_MIN_SIZE = 5;

  /*
   * 分页数量<br/>
   */
  static const int PAGER_SIZE = 15;

  /*
   * 最大分页数量<br/>
   */
  static const int MAX_PAGER_SIZE = 999;

  /*
   * 空数据标记位<br/>
   */
  static const String NULL = "null";

  /*
   * 分页初始值<br/>
   */
  static const int PAGER_INIT_INDEX = 1;

  /*
   * sdcard路径标记<br/>
   * 用于区分网络路径与设备路径<br/>
   */
  static const String SDCARD_FLAG = "storage";

  /*
   * 网络图片http<br/>
   * 用于区分网络路径与设备路径<br/>
   */
  static const String NETWORK_HTTP = "http://";

  /*
   * 网络图片https<br/>
   * 用于区分网络路径与设备路径<br/>
   */
  static const String NETWORK_HTTPS = "https://";

  /*
   * 本地图片路径标记<br/>
   */
  static const String SOFTWARE_ASSETS = "assets";
}
