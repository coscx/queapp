/*
 * 功能：APP_KEY,APP_ID等均在此定义
 * 需要传入的键：
 * 传入的值类型：
 * 传入的值含义：
 * 是否必传 ：
 * 作者：郑朝军 on 2019/4/7 23:23
 * 邮箱：1250393285@qq.com
 * 公司：武汉智博创享科技有限公司
 */
class WhatConstant
{
  /*
   * 网络数据成功状态<br/>
   */
  static const int WHAT_NET_DATA_SUCCESS = 0x100;

  /*
   * 网络数据失败状态<br/>
   */
  static const int WHAT_NET_DATA_FAIL = 0x101;

  /*
   * 数据库数据成功状态<br/>
   */
  static const int WHAT_DB_DATA_SUCCESS = 0x200;

  /*
   * 数据库数据失败状态<br/>
   */
  static const int WHAT_DB_DATA_FAIL = 0x201;

  /*
   * 耗时数据成功状态<br/>
   */
  static const int WHAT_OTHER_DATA_SUCCESS = 0x300;

  /*
   * 耗时数据失败状态<br/>
   */
  static const int WHAT_OTHER_DATA_FAIL = 0x301;

  /*
   * 数据例外状态<br/>
   */
  static const int WHAT_EXCEPITON = 0x400;

  /*
   * 数据取消状态<br/>
   */
  static const int WHAT_CANCEL = 0x500;
}
