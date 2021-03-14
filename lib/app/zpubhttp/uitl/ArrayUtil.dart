
/*
 * 类描述：数组处理工具类
 * 作者：郑朝军 on 2019/7/19
 * 邮箱：1250393285@qq.com
 * 公司：武汉智博创享科技有限公司
 * 修改人：郑朝军 on 2019/7/19
 * 修改备注：
 */
import 'CxTextUtil.dart';
import 'StringValueConstant.dart';

class ArrayUtil
{
  /*
   * String数组转int数组
   *
   * @param strings
   * @return [255,255,255,255]
   */
  static List<int> stringToIntArray(String string)
  {
    List<int> result = <int>[];
    if (CxTextUtil.isEmpty(string))
    {
      return result;
    }
    List<String> list = string.split(StringValueConstant.STR_COMMON_COMMA);
    list.forEach((value)
    {
      result.add(int.parse(value));
    });
    return result;
  }


  /*
   * String数组转int数组
   *
   * @param map 举例：[{ret: 0, filename: 0/2/0/289.file},{ret: 0, filename: 0/2/0/200.file}]
   * @param key 举例：filename
   * @return 0/2/0/289.file,0/2/0/200.file
   */
  static String mapKeyToString(List<Map<String, dynamic>> map, String key)
  {
    String result = "";
    map.forEach((value)
    {
      result = result + (value[key].toString()) + StringValueConstant.STR_COMMON_COMMA;
    });
    if (!CxTextUtil.isEmpty(result))
    {
      result = result.substring(0, result.length - 1);
    }
    return result;
  }


  /*
   * 过滤重复的值
   * @param result  [{"type":1,"objectid":"MyTask"},{"type":1,"objectid":"UserTask"},{"type":1,"objectid":"UserTask"}]
   * @param key = objectid
   * @return [{"type":1,"objectid":"MyTask"},{"type":1,"objectid":"UserTask"}]
   */
  static void filterMapKey(List<dynamic> result, String key)
  {
    List<dynamic> list = new List();
    result.sort((dynamic a, dynamic b)
    {
      if (a[key] == b[key])
      {
        list.add(a);
      }
      return 1;
    });
    list.forEach((value)
    {
      result.remove(value);
    });
  }
}
