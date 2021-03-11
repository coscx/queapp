library refresh_loadmore;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geen/views/pages/home/home_page.dart';
import 'package:flutter_geen/views/pages/utils/DyBehaviorNull.dart';

class CustomerRefreshLoadmore extends StatefulWidget {
  /// callback function on pull down to refresh | 下拉刷新时的回调函数
  final Future<void> Function() onRefresh;

  /// callback function on pull up to load more data | 上拉以加载更多数据的回调函数
  final Future<void> Function() onLoadmore;

  /// Whether it is the last page, if it is true, you can not load more | 是否为最后一页，如果为true，则无法加载更多
  final bool isLastPage;

  /// child widget | 子组件
  final Widget child;

  /// Prompt text when there is no more data at the bottom | 底部没有更多数据时的提示文字
  final String noMoreText;

  /// [noMoreText] text style | [noMoreText]的文字样式
  final TextStyle noMoreTextStyle;

  const CustomerRefreshLoadmore({
    Key key,
    @required this.child,
    @required this.isLastPage,
    this.noMoreText,
    this.noMoreTextStyle,
    this.onRefresh,
    this.onLoadmore,
  }) : super(key: key);
  @override
  _RefreshCustomerLoadmoreState createState() => _RefreshCustomerLoadmoreState();
}

class _RefreshCustomerLoadmoreState extends State<CustomerRefreshLoadmore> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  ScrollController _scrollControllers;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollControllers = ScrollController();
    _scrollControllers.addListener(() async {
      if (_scrollControllers.position.pixels >=
          _scrollControllers.position.maxScrollExtent) {
        if (_isLoading) {
          return;
        }

        if (mounted) {
          setState(() {
            _isLoading = true;
          });
        }

        if (widget.onLoadmore != null) {
          await widget.onLoadmore();
        }

        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollControllers.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget mainWiget =

    ScrollConfiguration(
        behavior: DyBehaviorNull(),
        child:
        ListView(
      padding: EdgeInsets.only(left: 0,right: 0,top: 0,bottom: 0),
      /// Solve the problem that there are too few items to pull down and refresh | 解决item太少，无法下拉刷新的问题
      reverse: true,
      shrinkWrap: true,
      physics: AlwaysScrollableScrollPhysics(),
      controller: _scrollControllers,
      children: <Widget>[
        widget.child,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 0),
              child: _isLoading
                  ? CupertinoActivityIndicator()
                  : Text(
                widget.isLastPage
                    ? widget.noMoreText ?? 'No more data'
                    : '',
                style: widget.noMoreTextStyle ??
                    TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).disabledColor,
                    ),
              ),
            )
          ],
        )
      ],
    ));

    if (widget.onRefresh == null) {
      return Scrollbar(child: mainWiget);
    }

    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: () async {
        if (_isLoading) return;
        await widget.onRefresh();
      },
      child: mainWiget,
    );
  }
}
