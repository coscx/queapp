

import 'Pager.dart';
import 'ZpubBasConstant.dart';


/*
 * 类描述：分页工具类
 * 作者：郑朝军 on 2019/5/7
 * 邮箱：1250393285@qq.com
 * 公司：武汉智博创享科技有限公司
 * 修改人：郑朝军 on 2019/5/7
 * 修改备注：
 */
class PagerUtil
{
  /*
   * 创建Pager
   */
  static void createPager(Pager pager, int pageNo, int pageSize, int totalCount, int totalPage)
  {
    pager.setPageNo(pageNo);
    pager.setPageSize(pageSize);
    pager.setTotalCount(totalCount);
    pager.setTotalPage(totalPage);
  }

  /*
   * 创建Pager
   * page从1开始
   */
  static void createPage(Pager pager, int page, int totalCount, {int pageSizeValue})
  {
    int pageNo = page;
    int pageSize = pageSizeValue ?? ZpubBasConstant.PAGER_SIZE;
    int totalPage = (totalCount / (pageSizeValue ?? ZpubBasConstant.PAGER_SIZE)).toInt();
    totalPage = (totalPage == 0
        ? 1
        : (totalCount % pageSize == 0 ? totalPage : totalPage + 1));
    createPager(pager, pageNo, pageSize, totalCount, totalPage);
  }


  /*
   * 创建Pager
   */
  static Pager createPagerRetrun(int pageNo, int pageSize, int totalCount, int totalPage)
  {
    Pager pager = new Pager();
    pager.setPageNo(pageNo);
    pager.setPageSize(pageSize);
    pager.setTotalCount(totalCount);
    pager.setTotalPage(totalPage);
    return pager;
  }

  /*
   * 创建Pager
   * page从1开始
   */
  static Pager createPageRetrun(Pager pager, int page, int totalCount)
  {
    int pageNo = page;
    int pageSize = ZpubBasConstant.PAGER_SIZE;
    int totalPage = (totalCount / ZpubBasConstant.PAGER_SIZE) as int;
    totalPage = (totalPage == 0
        ? 1
        : (totalCount % pageSize == 0 ? totalPage : totalPage + 1));
    return createPagerRetrun(pageNo, pageSize, totalCount, totalPage);
  }
}
