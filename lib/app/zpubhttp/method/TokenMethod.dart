import 'package:flutter_geen/app/zpubhttp/constant/HttpKeyValueConstant.dart';
import 'package:flutter_geen/app/zpubhttp/uitl/CxTextUtil.dart';
import 'package:flutter_geen/views/pages/utils/sp_util.dart';


/*
 * 类描述：Token相关方法封装
 * 作者：郑朝军 on 2019/9/11
 * 邮箱：1250393285@qq.com
 * 公司：武汉智博创享科技有限公司
 * 修改人：郑朝军 on 2019/9/11
 * 修改备注：
 */
class TokenMethod
{
  /*
   * 缓存token到属性文件中并更新BaseConstant中的内存token<br/>
   */
  static void setToken(String token)
  {
    HttpKeyValueConstant.VALUE_TOKEN = token;
    // SPUtil.put(SPUtil.MEMBER_TOKEN, token);
  }

  /*
   * 从属性文件中获取token<br/>
   */
  static String getTokenFromProperty()
  {
    // Object token = SPUtil.get(SPUtil.MEMBER_TOKEN, "");
    // if (token == null || CxTextUtil.isEmpty(token.toString()))
    // {
    //   return null;
    // }
    // else
    // {
    //   return token.toString();
    // }
  }
}
