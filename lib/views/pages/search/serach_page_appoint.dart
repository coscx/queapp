import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geen/app/api/issues_api.dart';
import 'package:flutter_geen/app/router.dart';
import 'package:flutter_geen/app/res/toly_icon.dart';
import 'package:flutter_geen/blocs/bloc_exp.dart';
import 'package:flutter_geen/components/permanent/circle.dart';
import 'package:flutter_geen/storage/dao/widget_dao.dart';
import 'package:flutter_geen/model/widget_model.dart';
import 'package:flutter_geen/views/items/photo_search_widget_list_item.dart';
import 'package:flutter_geen/views/items/photo_search_widget_list_item_appoint.dart';
import 'package:flutter_geen/views/items/photo_widget_list_item.dart';
import 'package:flutter_geen/views/items/techno_widget_list_item.dart';
import 'package:flutter_geen/views/pages/home/home_page.dart';
import 'package:flutter_geen/views/pages/search/app_search_bar.dart';
import 'package:flutter_geen/views/pages/search/error_page.dart';
import 'package:flutter_geen/views/common/loading_page.dart';
import 'package:flutter_geen/views/pages/search/not_search_page.dart';
import 'package:flutter_geen/components/permanent/multi_chip_filter.dart';
import 'package:flutter_geen/views/pages/utils/DyBehaviorNull.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:refresh_loadmore/refresh_loadmore.dart';
import 'empty_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchPageAppoint extends StatefulWidget {
  @override
  _SearchPageAppointState createState() => _SearchPageAppointState();
}

class _SearchPageAppointState extends State<SearchPageAppoint> {
  var _scaffoldkey = new GlobalKey<ScaffoldState>();
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
        appBarTheme: AppBarTheme.of(context).copyWith(
      brightness: Brightness.light,
    ),
    ),
    child:Scaffold(
      key: _scaffoldkey,
      appBar:  AppBar(
        backgroundColor: Colors.white,
        elevation: 0, //去掉Appbar底部阴影
        leadingWidth: 250.w,
        leading: Container(
        padding: EdgeInsets.only(left: 30.w,top: 30.w,bottom: 0),
        child:Text("用户搜索",
                style:TextStyle(
                  fontFamily: "Quicksand",
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                  fontSize: 45.sp,
                  decoration: TextDecoration.none,
                  color: Colors.black,
                )
        )),
        actions: <Widget>[

        ],
      ),
      body:
      WillPopScope(
        onWillPop: () async {
          //返回时 情空搜索
          BlocProvider.of<SearchBloc>(context).add(EventTextChanged(args: SearchArgs()));
          BlocProvider.of<SearchBloc>(context).add(EventClearPage());
          BlocProvider.of<GlobalBloc>(context).add(EventSearchPhotoPage(0));
          return true;
        },
        child: ScrollConfiguration(
            behavior: DyBehaviorNull(),
            child:
              SmartRefresher(
                enablePullDown: false,
                enablePullUp: true,
                header: DYrefreshHeader(),
                footer: DYrefreshFooter(),
                controller: _refreshController,
                onLoading: () async {
                    List<dynamic> oldUsers = BlocProvider.of<SearchBloc>(context).state.props.elementAt(0);
                    String word =BlocProvider.of<SearchBloc>(context).state.props.elementAt(1);
                    var currentPage =BlocProvider.of<GlobalBloc>(context).state.indexSearchPage;
                    BlocProvider.of<GlobalBloc>(context).add(EventSearchPhotoPage(currentPage));
                    var result= await IssuesApi.searchPhoto(word, (++currentPage).toString());
                    if  (result['code']==200){

                    } else{

                    }
                    List<dynamic> newUsers =[];
                    oldUsers.forEach((element) {
                      newUsers.add(element);
                    });
                    newUsers.addAll(result['data']['data']);
                    BlocProvider.of<SearchBloc>(context).add(EventLoadMoreUser(newUsers));
                    _refreshController.loadComplete();

                },
                child:

              CustomScrollView(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                slivers: <Widget>[
                _buildSliverAppBar(),
                //SliverToBoxAdapter(child: _buildStarFilter()),
                BlocListener<SearchBloc, SearchState>(
                    listener: (ctx, state) {
                      if (state is CheckUserSuccesses) {
                        _scaffoldkey.currentState.showSnackBar(SnackBar(
                          content: Text('审核成功' + state.Reason),
                          backgroundColor: Colors.green,
                        ));
                      }
                      if (state is DelImgSuccesses) {
                        _scaffoldkey.currentState.showSnackBar(SnackBar(
                          content: Text('删除成功'),
                          backgroundColor: Colors.blue,
                        ));
                      }
                    },
                    child: BlocBuilder<SearchBloc, SearchState>(
                        builder: _buildBodyByState)
                )
              ],
            ))),
      ),
    ));
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      backgroundColor: Colors.white,
      pinned: true,
      leadingWidth: 50.w,
      title: Container(
        padding: EdgeInsets.only(left: 0.w,top: 0.w),
    child:AppSearchBar()),
      actions: <Widget>[
        Padding(
          padding:  EdgeInsets.only(right: 5.w,),
          child: Icon(TolyIcon.icon_sound),
        )
      ],
    );
  }

  Widget _buildStarFilter() =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding:  EdgeInsets.only(top: 10.h, left: 35.w, bottom: 5.h),
            child: Wrap(
              spacing: 5.w,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                Circle(
                  radius: 5.w,
                  color: Colors.orange,
                ),
                Text(
                  '筛选',
                  style: TextStyle(
                      color: Theme
                          .of(context)
                          .primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          MultiChipFilter<int>(
            data: [1, 2, 3, 4, 5],
            avatarBuilder: (_, index) =>
                CircleAvatar(child: _buildTxt(index)),
            labelBuilder: (_, selected) =>
                Container(
                    child:
                    Icon(
                      Icons.star,
                      color: selected ? Colors.blue : Colors.grey,
                      size: 18.sp,
                    )),
            onChange: _doSelectStart,
          ),
          Divider()
        ],
      );

  Widget _buildTxt(int index) {
    if (index == 0) {
      return Text("M");
    }
    if (index == 1) {
      return Text("P");
    }
    if (index == 2) {
      return Text("C");
    }
    if (index == 3) {
      return Text("B");
    }
    if (index == 4) {
      return Text("A");
    }
    return Text("");
  }

  Widget _buildBodyByState(BuildContext context, SearchState state) {
    if (state is SearchStateNoSearch)
      return SliverToBoxAdapter(child: NotSearchPage(),);
    if (state is SearchStateLoading)
      return SliverToBoxAdapter(child: LoadingPage());
    if (state is SearchStateError)
      return SliverToBoxAdapter(child: ErrorPage());
    if (state is SearchStateSuccess)
      return _buildSliverList(state.photos);

    if (state is CheckUserSuccesses)
      return _buildSliverList(state.photos);
    if (state is DelImgSuccesses)
      return _buildSliverList(state.photos);


    if (state is SearchStateEmpty)
      return SliverToBoxAdapter(child: EmptyPage());
    return SliverToBoxAdapter(child: NotSearchPage(),);
  }

  Widget _buildSliverList(List<dynamic> photos) {
    return   SliverList(
        delegate: SliverChildBuilderDelegate(
                (_, int index) =>
                Container(
                    child: InkWell(
                      //onTap: () => _toDetailPage(models[0],photos[index]),
                        child: PhotoSearchAppointWidgetListItem(
                          isClip: false, photo: photos[index],)
                    )),
            childCount: photos.length),


    );
}

  _doSelectStart(List<int> select) {
    List<int> temp = select.map((e)=>e+1).toList();
    if (temp.length < 5) {
      temp.addAll(List.generate(5 - temp.length, (e) => -1));
    }
    BlocProvider.of<SearchBloc>(context)
        .add(EventTextChanged(args: SearchArgs(name: '', stars: temp)));
  }

  _toDetailPage(WidgetModel model,Map<String,dynamic>  photos) {
   //Map<String,dynamic> photo;
    BlocProvider.of<DetailBloc>(context).add(FetchWidgetDetail(photos));
    Navigator.pushNamed(context, UnitRouter.widget_detail,arguments: model);
  }
}
