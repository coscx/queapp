/*
 * 功能：文本工具类
 * 需要传入的键：
 * 传入的值类型：
 * 传入的值含义：
 * 是否必传 ：
 * 作者：郑朝军 on 2019/4/7 23:23
 * 邮箱：1250393285@qq.com
 * 公司：武汉智博创享科技有限公司
 */
class CxTextUtil
{
  /*
   * 是否为空字符串<br/>
   */
  static bool isEmpty(String text)
  {
    if (text == null || text.isEmpty)
    {
      return true;
    }
    return false;
  }


  /*
   * 是否为空数组<br/>
   */
  static bool isEmptyList(List list)
  {
    return list == null || list.isEmpty;
  }

  /*
   * 是否为空Map<br/>
   */
  static bool isEmptyMap(Map map)
  {
    return map == null || map.isEmpty;
  }

  /*
   * 是否为空Object<br/>
   */
  static bool isEmptyObject(Object object)
  {
    if (object == null) return true;
    if (object is String && object.isEmpty)
    {
      return true;
    }
    else if (object is List && object.isEmpty)
    {
      return true;
    }
    else if (object is Map && object.isEmpty)
    {
      return true;
    }
    return false;
  }
}
