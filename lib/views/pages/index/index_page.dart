import 'package:flutter/material.dart';
import 'package:flutter_geen/views/pages/data/big.dart';
import 'package:flutter_geen/views/pages/home/home_page.dart';
import 'package:flutter_geen/views/pages/utils/DyBehaviorNull.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';


class IndexPages extends StatefulWidget {
  @override
  _IndexPagesState createState() => _IndexPagesState();
}

class _IndexPagesState extends State<IndexPages> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
        appBarTheme: AppBarTheme.of(context).copyWith(
      brightness: Brightness.light,
    ),
    ),
    child:Scaffold(
      // 设置没有高度的 appbar，目的是为了设置状态栏的颜色
      appBar: PreferredSize(
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        preferredSize: Size.zero,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            Padding(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Positioned(
                        left: 2.w,
                        child: Container(

                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: ScreenUtil().setWidth(0),right: ScreenUtil().setWidth(380) ),
                        child: TabBar(
                          labelColor:Colors.black ,
                          labelStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold,color: Colors.black,backgroundColor: Colors.white),
                          unselectedLabelStyle: TextStyle(fontSize: 16,color: Colors.black12),
                          indicator: UnderlineTabIndicator(),
                          indicatorColor: Colors.orange, // 下面那条横线的颜色
                          indicatorSize: TabBarIndicatorSize.label, // 指示器是类型， label是这样的，tab是沾满整个tab的空间的
                          isScrollable: true, // 是否可以滑动
                          indicatorWeight: 3.0, // 指示器的高度/厚度
                          controller: _tabController,
                          tabs: [
                            Tab(
                              text: '大数据',
                            ),
                            // Tab(
                            //   text: '我的',
                            // ),
                            // Tab(
                            //   text: '动态',
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(width: 50),
                      // Positioned(
                      //   right: 50.w,
                      //   child: IconButton(
                      //     icon: Icon(
                      //       Icons.search,
                      //       color: Colors.black87,
                      //     ),
                      //     onPressed: () {
                      //
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ScrollConfiguration(
                      behavior: DyBehaviorNull(),
                      child: TabBarView(
                      controller: _tabController,
                      children: [
                        FocusPage(),
                        // FocusPage(),
                        // FocusPage()
                      ],
                    )),
                  ),
                ],
              ),
              padding: EdgeInsets.only(
                  bottom:
                      ScreenUtil().setWidth(0) ),
            ),

          ],
        ),
      ),
    ));
  }
}
