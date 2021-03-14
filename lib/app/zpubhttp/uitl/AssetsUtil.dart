import 'package:flutter/services.dart';

import 'StringValueConstant.dart';


/*
 * 类描述：Assets工具类
 * 作者：郑朝军 on 2019/5/27
 * 邮箱：1250393285@qq.com
 * 公司：武汉智博创享科技有限公司
 * 修改人：郑朝军 on 2019/5/27
 * 修改备注：
 */
class AssetsUtil
{
  /*
   * 根据传递过来的文件进行初始化操作
   * @param tables =  ["assets/sql/zbcx.sql","assets/sql/zbcx.sql"]
   * @retrun 所有SQL的集合
   */
  Future<List<String>> createSQL(List<String> tables) async
  {
    List<String> respose = <String>[];
    for (int i = 0; i < tables.length; i++)
    {
      String result = await rootBundle.loadString(tables[i]);
      List<String> sql = result.split(StringValueConstant.STR_COMMON_LINE_FEED);
      for (int i = 0; i < sql.length; i++)
      {
        if (sql[i].contains(StringValueConstant.STR_COMMON_SEMICOLON))
        {
          respose.add(sql[i]);
        }
      }
    }
    return respose;
  }
}
