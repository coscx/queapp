//part 'Pager.g.dart';
/*
 * 分页<br/>
 */
class Pager
{
  int m_iTotalCount; // 总数量

  int m_iPageSize; // 每一页数量

  int m_iPageNo; // 第几页

  int m_iTotalPage; // 总页数

  int currentPage; //pageNo

  int perPageRows; //pageSize

  int getTotalCount()
  {
    return m_iTotalCount;
  }

  void setTotalCount(int m_iTotalCount)
  {
    this.m_iTotalCount = m_iTotalCount;
  }

  int getPageSize()
  {
    return m_iPageSize;
  }

  void setPageSize(int m_iPageSize)
  {
    this.m_iPageSize = m_iPageSize;
  }

  int getPageNo()
  {
    return m_iPageNo;
  }

  void setPageNo(int m_iPageNo)
  {
    this.m_iPageNo = m_iPageNo;
  }

  int getTotalPage()
  {
    return m_iTotalPage;
  }

  void setTotalPage(int m_iTotalPage)
  {
    this.m_iTotalPage = m_iTotalPage;
  }

  int getCurrentPage()
  {
    return currentPage;
  }

  void setCurrentPage(int currentPage)
  {
    this.currentPage = currentPage;
  }

  int getPerPageRows()
  {
    return perPageRows;
  }

  void setPerPageRows(int perPageRows)
  {
    this.perPageRows = perPageRows;
  }

  Pager()
  {}

//  factory Pager.fromJson(Map<String, dynamic> json) => _$PagerFromJson(json);
//
//  Map<String, dynamic> toJson() => _$PagerToJson(this);
}
