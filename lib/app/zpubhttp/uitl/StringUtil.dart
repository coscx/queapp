

/*
 * 功能：字符串工具类
 * 需要传入的键：
 * 传入的值类型：
 * 传入的值含义：
 * 是否必传 ：
 * 作者：郑朝军 on 2019/4/7 23:23
 * 邮箱：1250393285@qq.com
 * 公司：武汉智博创享科技有限公司
 */
import 'DigitValueConstant.dart';
import 'StringValueConstant.dart';

class StringUtil
{
  /*
   * 去除以下字符<br>
   * \n 回车(\u000a)<br>
   * \t 水平制表符(\u0009)<br>
   * \s 空格(\u0008)<br>
   * \r 换行(\u000d)<br>
   */
  static String replaceBlank(String str)
  {
    String dest = "";
    if (str != null)
    {
//      Pattern p = Pattern.compile("\\s*|\t|\r|\n");
//      Matcher m = p.matcher(str);
//      dest = m.replaceAll("");
    }
    return dest;
  }

  /*
   * 去除以下字符,及头尾去空<br>
   * \t 水平制表符(\u0009)<br>
   */
  static String trim(String str)
  {
    String dest = "";
    if (str != null)
    {
//      dest = str.replaceAll("(^[ |　]*|[ |　]*$)", "").trim();
    }
    return dest;
  }

  /*
   * 去除以下字符<br>
   * ["<br/>
   * "]<br/>
   */
  static String replaceArray(String str)
  {
    String dest = "";
    if (str != null)
    {
//      dest = str.replace("[\"", "").replace("\"]", "");
    }
    return dest;
  }

  /*
   * 转换网页换行符<br>
   */
  static String replaceEnter(String str)
  {
    String dest = "";
    if (str != null)
    {
      dest = str.replaceAll("<br/>", "\n");
    }
    return dest;
  }

  /*
   * 提取传递过来的字符串中的值<br>
   * @param str = #{total}
   * return total
   */
  static String extractValue(String str)
  {
    return str.substring(str.indexOf(StringValueConstant.STR_BRACKETS_LEFT) + 1,
        str.lastIndexOf(StringValueConstant.STR_BRACKETS_RIGHT));
  }

  /*
   * 校验传递过来的字符串中是否包含 #{ <br>
   * @param str = #{total}
   * return true 包含 #{
   */
  static bool checkValue(String str)
  {
    return str.indexOf(StringValueConstant.STR_Y_BRACKETS) == DigitValueConstant.APP_DIGIT_VALUE_0;
  }
}
