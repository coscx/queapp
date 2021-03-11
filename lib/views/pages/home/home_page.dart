import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geen/app/api/issues_api.dart';
import 'package:flutter_geen/app/router.dart';
import 'package:flutter_geen/blocs/bloc_exp.dart';
import 'package:flutter_geen/blocs/home/home_bloc.dart';
import 'package:flutter_geen/components/permanent/overlay_tool_wrapper.dart';
import 'package:flutter_geen/views/dialogs/delete_category_dialog.dart';
import 'package:flutter_geen/views/dialogs/user_detail.dart';
import 'package:flutter_geen/views/items/SearchParamModel.dart';
import 'package:flutter_geen/views/items/drop_menu_header.dart';
import 'package:flutter_geen/views/items/drop_menu_leftWidget.dart';
import 'package:flutter_geen/views/items/drop_menu_rightWidget.dart';
import 'package:flutter_geen/model/widget_model.dart';
import 'package:flutter_geen/views/common/empty_page.dart';
import 'package:flutter_geen/views/items/home_item_support.dart';
import 'package:flutter_geen/views/pages/home/toly_app_bar.dart';
import 'package:flutter_geen/views/pages/utils/DyBehaviorNull.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'background.dart';
import 'package:flutter_qr_reader/flutter_qr_reader.dart';
import 'package:flutter_ad_plugin/flutter_ad_plugin.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  QrReaderViewController _controller;
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  bool _showPop = false;
  bool _showFilter = false;
  bool _showSort = false;
  bool _showRight =  false;
  bool _showAge =  false;
  int _showAgeMin =  16;
  int _showAgeMax =  70;
  bool _visible =  false;
  int _visibleCount = 0;
  bool _showChip = false;
  int _selectedIndex=999;
  String serveType ="2";
  String totalCount ="";
  String title="客户管理";
  static List<SortModel> _leftWidgets = [
    SortModel(name: "服务中", isSelected: true, code: "2"),
    SortModel(name: "跟进中", isSelected: false, code: "1"),
    SortModel(name: "已签约", isSelected: false, code: "3"),
    SortModel(name: "即将过期", isSelected: false, code: "4"),
  ];
  SortModel _leftSelectedModel = _leftWidgets[0];
  List<String> _dropDownHeaderItemStrings = [_leftWidgets[1].name, '筛选'];
  SearchParamList searchParamList= SearchParamList(list: []);
  void _showPopView(int select) {
    setState(() {
      if (_selectedIndex >0)
      _selectedIndex=select;
      _showPop = (_showFilter || _showSort);
    });
  }
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((callback) {
      OverlayToolWrapper.of(context).showFloating();
    });
    Future.delayed(Duration(milliseconds: 2500)).then((e) async {
      //_onRefresh();
    });
  }
  @override
  void dispose() {
    _refreshController?.dispose();
    super.dispose();
  }


  // 下拉刷新
  void _onRefresh() async {
    BlocProvider.of<GlobalBloc>(context).add(EventResetIndexPhotoPage());
    //BlocProvider.of<GlobalBloc>(context).add((EventSetIndexNum()));
    var sex =BlocProvider.of<GlobalBloc>(context).state.sex;
    var mode =BlocProvider.of<GlobalBloc>(context).state.currentPhotoMode;
    BlocProvider.of<HomeBloc>(context).add(EventFresh(sex,mode,searchParamList,_showAge,_showAgeMax,_showAgeMin,serveType));
    _refreshController.refreshCompleted();
  }

  // 上拉加载
  void _onLoading() async {

    List<dynamic> oldUsers = BlocProvider.of<HomeBloc>(context).state.props.elementAt(0);
    var currentPage =BlocProvider.of<GlobalBloc>(context).state.indexPhotoPage;
    var sex =BlocProvider.of<GlobalBloc>(context).state.sex;
    var mode =BlocProvider.of<GlobalBloc>(context).state.currentPhotoMode;
    BlocProvider.of<GlobalBloc>(context).add(EventIndexPhotoPage(currentPage));
    var result= await IssuesApi.searchErpUser('', (++currentPage).toString(),sex.toString(),mode.toString(),searchParamList,_showAge,_showAgeMax,_showAgeMin,serveType);
    if  (result['code']==200){

    } else{

    }
    List<dynamic> newUsers =[];
    oldUsers.forEach((element) {
      newUsers.add(element);
    });
    newUsers.addAll(result['data']['data']);
    BlocProvider.of<HomeBloc>(context).add(EventLoadMore(newUsers));
    _refreshController.loadComplete();
  }
  Future _scan() async {
    await Permission.camera.request();

    Navigator.pushNamed(context, UnitRouter.qr_view).then((barcode) async {
      //String barcode = "";//await scanner.scan();
      if (barcode == null) {
        print('nothing return.');
      } else {
        //this._outputController.text = barcode;
        print(barcode);
        BotToast.showLoading();
        //BlocProvider.of<GlobalBloc>(context).add(EventSetCreditId(barcode));
        var result= await IssuesApi.getUserDetail('a87ca69e-7092-493e-9f13-2955aeaf2d0f');
        if  (result['code']==200){
          _userDetail(context,result['data']);
        } else{
          _createUser(context,null);
        }

        BotToast.closeAllLoading();

      }

    }
    );

  }
  _userDetail(BuildContext context,Map<String ,dynamic> user) {
    showDialog(
        context: context,
        builder: (ctx) => UserDetailDialog(user)

    );



  }
  _createUser(BuildContext context,Map<String,dynamic> img) {
    showDialog(
        context: context,
        builder: (ctx) => Dialog(
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.w))),
          child: Container(
            width: 50.w,
            child: DeleteCategoryDialog(
              title: '未查到数据',
              content: '是否录入？',
              onSubmit: () {
                Future.delayed(Duration(milliseconds: 500)).then((e) async {

                  Navigator.pushNamed(context, UnitRouter.create_user_page);

                });
                Navigator.of(context).pop();
                //BlocProvider.of<DetailBloc>(context).add(EventDelDetailImg(img,detail['info']));

                //
              },
            ),
          ),
        ));
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Theme(
        data: ThemeData(
        appBarTheme: AppBarTheme.of(context).copyWith(
      brightness: Brightness.light,
    ),
    ),
    child:Scaffold(
        appBar: AppBar(
          titleSpacing:40.w,
          leadingWidth: 0,
          title:  Row(
            children: [
              Text(title,style: TextStyle(color: Colors.black, fontSize: 48.sp,fontWeight: FontWeight.bold)),
              totalCount==""?Container(): Text('      共:',style: TextStyle(color: Colors.black, fontSize: 30.sp,fontWeight: FontWeight.w200)),
              Text(totalCount,style: TextStyle(color: Colors.redAccent, fontSize: 30.sp,fontWeight: FontWeight.normal)),
            ],
          ),
          //leading:const Text('Demo',style: TextStyle(color: Colors.black, fontSize: 15)),
          backgroundColor: Colors.white,
          elevation: 0, //去掉Appbar底部阴影
          actions:<Widget> [

            Container(

              child: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.black87,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, UnitRouter.search);
                },
              ),
            ),SizedBox(width: 20),
            Container(
              height: 20,
              width: 20,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.crop_free,
                  size: 24.0,
                  color: Colors.black,
                ),
                onPressed: (){
                  //Navigator.of(context).pushNamed(UnitRouter.qr_view);
                  _scan();
                  //FlutterAdPlugin.jumpAdList;
                },
              ),
            ),
            SizedBox(
              width: 60.w,
            )
          ],

          bottom: DropMenuHeader(
            selectedIndex: _selectedIndex,
            items: [
              ButtonModel(
                  text: _dropDownHeaderItemStrings[1],

                  onTap: (bool selected) {
                    _showFilter = selected;
                    _showSort = false;
                    _showPopView(0);
                  }),
              ButtonModel(
                  text: _leftSelectedModel.name,
                  onTap: (bool selected) {
                    _showSort = selected;
                    _showFilter = false;
                    _showPopView(0);
                  }),

            ],
            height: 60.h,
          ),
        ),
        body:  BlocListener<HomeBloc, HomeState>(
        listener: (ctx, state) {
      if (state is CheckUserSuccess) {

        BlocProvider.of<GlobalBloc>(context).add((EventSetIndexNum()));
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('审核成功'+state.Reason),
          backgroundColor: Colors.green,
        ));

      }
      if (state is DelImgSuccess) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('删除成功'),
          backgroundColor: Colors.blue,
        ));

      }
      if (state is Unauthenticated) {
        Navigator.of(context).pushReplacementNamed(UnitRouter.login);
      }

      if (state is WidgetsLoaded) {
       var data =state.photos;
      // print(data.toString());
       var mode =BlocProvider.of<GlobalBloc>(context).state.currentPhotoMode;
       if(mode == 0){
         title= "客户管理";

       }
       if(mode == 1){
         title= "缔结良缘库";

       }
       if(mode == 2){
         title= "我的客户";

       }
       if(mode == 3){
         title= "销售公海";

       }
       //setState(() {
        totalCount =state.count;
       //});
      }
    },
    child:BlocBuilder<HomeBloc, HomeState>(builder: (ctx, state) {
      return Stack(
            children: <Widget>[
              //BlocBuilder<GlobalBloc, GlobalState>(builder: _buildBackground),
              Container(
                //padding:  EdgeInsets.only(top: 25.h),
                child: ScrollConfiguration(
                    behavior: DyBehaviorNull(),
                    child:
                    SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
                      header: DYrefreshHeader(),
                      footer: DYrefreshFooter(),
                      controller: _refreshController,
                      onRefresh: _onRefresh,
                      onLoading: _onLoading,
                      child:  CustomScrollView(
                        physics: BouncingScrollPhysics(),
                        slivers: <Widget>[
                          // Container(
                          //   child: BlocBuilder<GlobalBloc, GlobalState>(builder: _buildHeadNum),
                          // ),
                          SliverToBoxAdapter(
                            child:  BlocBuilder<GlobalBloc, GlobalState>(builder: _buildHead),

                          ),
                      SliverToBoxAdapter(
                        child: Row(
                          children: [
                            // Container(
                            //   height: 50.h,
                            //   padding:  EdgeInsets.only(left: 35.w,top: 8.h),
                            //   child: Text('筛选条件:'
                            //
                            //   ),
                            // ),
                           Visibility(
                             visible: _visible,
                             child: Container(
                                height: 50.h,
                                width: 700.w,
                                padding:  EdgeInsets.only(left: 30.w),
                                child: ListView(
                                  shrinkWrap: true ,
                                    scrollDirection: Axis.horizontal,
                                    children:<Widget>  [
                                      ...buildLeftRightWidget(),
                                    _showAge?buildAgeWidget():Container()
                                    ],
                                  ),
                              ),
                           ),
                          ],
                        )),

                          _buildContent(ctx, state),
                        ],
                      ),
                    )
                ),
              ),
              buildPopView(),
            ],
          );
    }
    )
        )
    ));
  }
  Widget getLeftRightWidget() {

    return Container(padding:  EdgeInsets.only(right: 15.w),child:RawChip(
      label: Text('老孟'),
      onDeleted: (){
        print('onDeleted');
      },
      deleteIcon: Icon(Icons.delete),
      deleteIconColor: Colors.red,
      deleteButtonTooltipMessage: '删除',
    ));
  }
  List<Widget> buildLeftRightWidget() {

    var ll= searchParamList.list.where((element) =>  element.selected !=null)
        .map((e) {
            if(e.selectName !=null){
              _showChip=true;
            }
           return Container(padding:  EdgeInsets.only(right: 15.w,left: 1.w,top: 1.h,bottom: 1.h),child:RawChip(
             label: Text(e.selectName==null?"0":e.selectName,style: TextStyle(color: Colors.black, fontSize: 30.sp),),
             padding: EdgeInsets.only(left: 5.w,right: 5.w,top: 0.h,bottom: 5.h),
             onDeleted: (){
               //print('onDeleted');
               //setState(() {
                 deleteLeftRightWidget(e.selectName);
              // });
               var sex =BlocProvider.of<GlobalBloc>(context).state.sex;
               var mode =BlocProvider.of<GlobalBloc>(context).state.currentPhotoMode;
               BlocProvider.of<HomeBloc>(context).add(EventSearchErpUser(searchParamList,sex,mode,_showAge,_showAgeMax,_showAgeMin,serveType));
             },
             deleteIcon: Icon(Icons.delete),
             deleteIconColor: Colors.red,
             deleteButtonTooltipMessage: '删除',
           ));


       }).toList();

     return ll;
  }

   deleteLeftRightWidget(String code ) {
     _visible=false;
     _visibleCount=0;
     searchParamList.list
        .map((e) {
      if(e.selectName ==code) {
        e.selected=null;
        e.selectName=null;
        e.itemList.map((el) {
          if(el.name ==code){
             //el.isSelected =null;
             el.isSelected = !el.isSelected;
          }
          return el;
        }).toList();
        return e;
      }else{
        return e;
      }

    }).toList();

     searchParamList.list.map((e) {
       if(e.selected !="" && e.selected !=null){
         _visible=true;
         _visibleCount++;
       }

     }).toList();


  }

  Widget buildAgeWidget() {

    return Container(padding:  EdgeInsets.only(right: 15.w),child:RawChip(
      label: Text(_showAgeMin.toString()+"-"+_showAgeMax.toString()),
      onDeleted: (){
        print('onDeleted');
        _showAge =false;
        if(_visibleCount ==0){
          _visible=false;
        }

        var sex =BlocProvider.of<GlobalBloc>(context).state.sex;
        var mode =BlocProvider.of<GlobalBloc>(context).state.currentPhotoMode;
        BlocProvider.of<HomeBloc>(context).add(EventSearchErpUser(searchParamList,sex,mode,_showAge,_showAgeMax,_showAgeMin,serveType));

      },
      deleteIcon: Icon(Icons.delete),
      deleteIconColor: Colors.red,
      deleteButtonTooltipMessage: '删除',
    ));
  }

  Widget buildPopView() {
    if (_showFilter) {
      return FutureBuilder(
        future: loadStudent(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            SearchParamList tempSearchParamList;
            if (searchParamList!=null && searchParamList.list.length >0){
              tempSearchParamList=searchParamList;
            }else{
              tempSearchParamList=snapshot.data as SearchParamList;
              searchParamList =tempSearchParamList;
            }

            return DropMenuRightWidget(
              paramList: tempSearchParamList,
              showAgeMax: _showAgeMax,
              showAge: _showAge,
              showAgeMin: _showAgeMin,
              clickCallBack:
                  (SearchParamModel pressModel, ParamItemModel pressItem) {
                     searchParamList.list.map((e) {
                      if (e.paramCode==pressModel.paramCode){
                        if (pressItem.isSelected==true){
                          e.selected=null;
                          e.selectName=null;
                        }else{
                          e.selected=pressItem.code;
                          e.selectName =pressItem.name;
                        }

                        return e;
                      }
                    }).toList();
                print('${pressItem.name}');
              },
              clickSwith: (on , min,max){
                _showAge=on;
                _showAgeMax=max;
                _showAgeMin=min;
                print(on);
                print(min);
                print(max);
              },

              sureFun: () {
                var sex =BlocProvider.of<GlobalBloc>(context).state.sex;
                var mode =BlocProvider.of<GlobalBloc>(context).state.currentPhotoMode;
                BlocProvider.of<HomeBloc>(context).add(EventSearchErpUser(searchParamList,sex,mode,_showAge,_showAgeMax,_showAgeMin,serveType));
                _visible=false;
                _visibleCount=0;
                searchParamList.list.map((e) {
                  if(e.selected!="" && e.selected !=null){
                    _visible=true;
                    _visibleCount++;
                  }

                }).toList();
                if(_visibleCount==0){
                  if(_showAge ==true){
                    _visible=true;
                  }else{
                    _visible=false;
                  }
                }else{
                  _visible=true;
                }


                print("sure click");
                _showFilter = false;
                _showSort = false;
                _showPopView(2);
              },
              resetFun: () {
                print("reset click");
              },
            );
          } else {
            return Text("");
          }
        },
      );
    } else if (_showSort) {
      return DropMenuLeftWidget(
        dataSource: _leftWidgets,
        onSelected: (SortModel model) {
          _leftSelectedModel = model;
          print("select ${model.name}  ${model.code}");

          setState(() {
            serveType= model.code;
            _showSort = false;
            _showFilter = false;
            var mode =BlocProvider.of<GlobalBloc>(context).state.currentPhotoMode;
            if( mode== 2){
              var sex =BlocProvider.of<GlobalBloc>(context).state.sex;
              BlocProvider.of<HomeBloc>(context).add(EventSearchErpUser(searchParamList,sex,mode,_showAge,_showAgeMax,_showAgeMin,serveType));
            }

          });
        },
      );
    } else {
      return SizedBox(
        height: 0,
      );
    }
  }
  Future<String> _loadAStudentAsset(BuildContext context) async {
    return await DefaultAssetBundle.of(context)
        .loadString('assets/searchParam.json');
  }
  Future loadStudent(BuildContext context) async {
    String jsonString = await _loadAStudentAsset(context);
    final jsonResponse = json.decode(jsonString);
    SearchParamList paramList = new SearchParamList.fromJson(jsonResponse);
    for (SearchParamModel item in paramList.list) {
      if (item.dateFlag == true) {
        // item.itemList.add(new ParamItemModel(
        //   name: "自定义时间",
        //   code: "-1",
        // ));
      }
    }
    return paramList;
  }
  void _onValueChanged(int value) {
    BlocProvider.of<GlobalBloc>(context).add(EventSetIndexSex(value));
    var mode =BlocProvider.of<GlobalBloc>(context).state.currentPhotoMode;

    if(searchParamList ==null){
      BlocProvider.of<HomeBloc>(context).add(EventFresh(value,mode,searchParamList,_showAge,_showAgeMax,_showAgeMin,serveType));
    }else{
      BlocProvider.of<HomeBloc>(context).add(EventSearchErpUser(searchParamList,value,mode,_showAge,_showAgeMax,_showAgeMin,serveType));
    }

  }

  Widget _buildHead(BuildContext context, GlobalState state) {

    return Container(
        child:  Container(child:

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
//                交叉轴的布局方式，对于column来说就是水平方向的布局方式
          crossAxisAlignment: CrossAxisAlignment.center,
          //就是字child的垂直布局方向，向上还是向下
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            SizedBox(
              width: 1.w,
            ),
            Container(
              width: 100.w,
              child: Text("筛选:",   style:  TextStyle(
                fontSize: 32.sp,
                color: Colors.black,
              ),),
            ),
            CupertinoSegmentedControl<int>(
              //unselectedColor: Colors.yellow,
              //selectedColor: Colors.green,
              //pressedColor: Colors.blue,
              //borderColor: Colors.red,
              groupValue: state.sex==0 ? 1: state.sex,
              onValueChanged: _onValueChanged,
              padding: EdgeInsets.only(right: 0.w),
              children: {
                1: state.sex ==1 ?Padding(
                  padding: EdgeInsets.only(left: 50.w, right: 40.w),
                  child: Text("男",style:  TextStyle(
            fontSize: 30.sp,
            color: Colors.white,
            )),
                ):Text("男",style:  TextStyle(
                  fontSize: 30.sp,
                  color: Colors.blue,
                )),
                2: state.sex ==2 ?Padding(
                  padding: EdgeInsets.only(left: 50.w, right: 40.w),
                  child: Text("女",style:  TextStyle(
                    fontSize: 30.sp,
                    color: Colors.white,
                  )),
                ):Text("女",style:  TextStyle(
                  fontSize: 30.sp,
                  color: Colors.blue,
                )),
              },
            ),

            buildHeadTxt(context,state),
            PopupMenuButton<String>(
              itemBuilder: (context) => buildItems(),
              offset: Offset(0, 80.w),
              color: Color(0xffF4FFFA),
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  )),
              onSelected: (e) {
                print(e);
                if (e == '全部') {
                  BlocProvider.of<GlobalBloc>(context).add(EventSetIndexMode(0));
                  var sex =BlocProvider.of<GlobalBloc>(context).state.sex;
                  BlocProvider.of<HomeBloc>(context).add(EventFresh(sex,0,searchParamList,_showAge,_showAgeMax,_showAgeMin,serveType));
                }
                if (e == '我的') {
                  BlocProvider.of<GlobalBloc>(context).add(EventSetIndexMode(2));
                  var sex =BlocProvider.of<GlobalBloc>(context).state.sex;
                  BlocProvider.of<HomeBloc>(context).add(EventFresh(sex,2, searchParamList,_showAge,_showAgeMax,_showAgeMin,serveType));
                }
                if (e == '良缘') {
                  BlocProvider.of<GlobalBloc>(context).add(EventSetIndexMode(1));
                  var sex =BlocProvider.of<GlobalBloc>(context).state.sex;
                  BlocProvider.of<HomeBloc>(context).add(EventFresh(sex,1,searchParamList,_showAge,_showAgeMax,_showAgeMin,serveType));
                }
                if (e == '公海') {
                  BlocProvider.of<GlobalBloc>(context).add(EventSetIndexMode(3));
                  var sex =BlocProvider.of<GlobalBloc>(context).state.sex;
                  BlocProvider.of<HomeBloc>(context).add(EventFresh(sex,3,searchParamList,_showAge,_showAgeMax,_showAgeMin,serveType));
                }

              },
              onCanceled: () => print('onCanceled'),
            )

          ],
        )



        )
    );
  }
  List<PopupMenuItem<String>> buildItems() {
    final map = {
      "全部": Icons.border_all,
      "我的": Icons.mood_sharp,
      "良缘": Icons.wc,
      "公海": Icons.sports_baseball_rounded,
    };
    return map.keys
        .toList()
        .map((e) => PopupMenuItem<String>(
        value: e,
        child: Wrap(
          spacing: 10.w,
          children: <Widget>[
            Icon(
              map[e],
              color: Colors.blue,
            ),
            Text(e),
          ],
        )))
        .toList();
  }

  Widget buildHeadTxt(BuildContext context, GlobalState state) {
    if(state.currentPhotoMode==0){
     return SizedBox(
        width: 50,
        child: Text("全部"),
      );

    }
    if(state.currentPhotoMode==2){
      return SizedBox(
        width: 50,
        child: Text("我的"),
      );

    }
    if(state.currentPhotoMode==1){
      return SizedBox(
        width: 50,
        child: Text("良缘"),
      );

    }
    if(state.currentPhotoMode==3){
      return SizedBox(
        width: 50,
        child: Text("公海"),
      );

    }
    return SizedBox(
      width: 50,
      child: Text("全部"),
    );
  }
  Widget _buildPersistentHeader(List<String> num) => SliverPersistentHeader(
      pinned: true,
      delegate: FlexHeaderDelegate(
          minHeight: 25 + 56.0,
          maxHeight: 120.0,
          childBuilder: (offset, max, min) {
            double dy = max - 25 - offset;

            if (dy < min - 25) {
              dy = min - 25;
            }
            return TolyAppBar(
              maxHeight: dy,
              onItemClick: _switchTab,
              nums: num,
            );
          }));

  Widget _buildBackground(BuildContext context, GlobalState state) {
    if (state.showBackGround) {
      return BackgroundShower();
    }
    return Container();
  }
  Widget _buildHeadNum(BuildContext context, GlobalState state) {

    return _buildPersistentHeader(state.headNum);
  }
  Widget _buildContent(BuildContext context, HomeState state) {
    if (state is WidgetsLoading) {
      return SliverToBoxAdapter(
        child: Container(),
      );
    }

    if (state is WidgetsLoaded) {

      List<dynamic>  photos=state.photos;
      if (photos.isEmpty) return SliverToBoxAdapter(
          child:EmptyPage());
      return photos.isNotEmpty?SliverList(
        delegate: SliverChildBuilderDelegate(
            (_, int index) => _buildHomeItem(photos[index]),
            childCount: photos.length),
      ):SliverToBoxAdapter(
          child:Center(child: Container(
        alignment: FractionalOffset.center,
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.airplay, color: Colors.orangeAccent, size: 120.0),
            Container(
              padding:  EdgeInsets.only(top: 16.0),
              child:  Text(
                "暂时没有用户了，(""^ _ ^)/~┴┴",
                style:  TextStyle(
                  fontSize: 40.sp,
                  color: Colors.orangeAccent,
                ),
              ),
            )
          ],
        ),
      ),));
    }

    if (state is WidgetsLoadFailed) {
      return SliverToBoxAdapter(
        child: Container(
          child: Center(child: Container(
            alignment: FractionalOffset.center,
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.event_busy, color: Colors.orangeAccent, size: 120.0),
                Container(
                  padding:  EdgeInsets.only(top: 16.0),
                  child:  Text(
                    "数据异常，(≡ _ ≡)/~┴┴",
                    style:  TextStyle(
                      fontSize: 20,
                      color: Colors.orangeAccent,
                    ),
                  ),
                )
              ],
            ),
          ),),
        ),
      );
    }
    if (state is CheckUserSuccess) {
      List<WidgetModel> items = state.widgets;
      List<dynamic>  photos=state.photos;
      if (items.isEmpty) return EmptyPage();
      return photos.isNotEmpty?SliverList(
        delegate: SliverChildBuilderDelegate(
                (_, int index) => _buildHomeItem(photos[index]),
            childCount: photos.length),
      ):SliverToBoxAdapter(
          child:Center(child: Container(
        alignment: FractionalOffset.center,
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.airplay, color: Colors.orangeAccent, size: 120.0),
            Container(
              padding:  EdgeInsets.only(top: 16.0),
              child:  Text(
                "暂时没有需要审核的用户了，(""^ _ ^)/~┴┴",
                style:  TextStyle(
                  fontSize: 20,
                  color: Colors.orangeAccent,
                ),
              ),
            )
          ],
        ),
      ),));
    }
    if (state is DelImgSuccess) {
      List<WidgetModel> items = state.widgets;
      List<dynamic>  photos=state.photos;
      if (items.isEmpty) return EmptyPage();
      return photos.isNotEmpty?SliverList(
        delegate: SliverChildBuilderDelegate(
                (_, int index) => _buildHomeItem(photos[index]),
            childCount: photos.length),
      ):SliverToBoxAdapter(
          child:Center(child: Container(
        alignment: FractionalOffset.center,
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.airplay, color: Colors.orangeAccent, size: 120.0),
            Container(
              padding:  EdgeInsets.only(top: 16.0),
              child:  Text(
                "暂时没有需要审核的用户了，(""^ _ ^)/~┴┴",
                style:  TextStyle(
                  fontSize: 20,
                  color: Colors.orangeAccent,
                ),
              ),
            )
          ],
        ),
      ),));
    }
    return SliverToBoxAdapter(
      child: Container(),
    );
  }

  Widget _buildHomeItem(Map<String,dynamic> photo) {
    bool isVip;
    var vipExpireTime = photo['vip_expire_time'];
    if (vipExpireTime == null) {
      isVip = false;
    } else {
      isVip = true;
    }
   return HomeItemSupport.get(null, 6, photo,isVip);
  }
  _switchTab(int index, Color color) {
    BlocProvider.of<HomeBloc>(context)
        .add(EventTabTap());
  }

  _toDetailPage(WidgetModel model,Map<String,dynamic> photo) {
    BlocProvider.of<DetailBloc>(context).add(FetchWidgetDetail(photo));
    Navigator.pushNamed(context, UnitRouter.widget_detail, arguments: model);
  }

  @override
  bool get wantKeepAlive => true;
}

class FlexHeaderDelegate extends SliverPersistentHeaderDelegate {
  FlexHeaderDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.childBuilder,
  });

  final double minHeight; //最小高度
  final double maxHeight; //最大高度
  final Widget Function(double offset, double max, double min)
      childBuilder; //最大高度

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return childBuilder(shrinkOffset, maxHeight, minHeight);
  }

  @override //是否需要重建
  bool shouldRebuild(FlexHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight;
  }
}

// 下拉刷新头部、底部组件
class DYrefreshHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WaterDropHeader(
      waterDropColor: Colors.blue,
      refresh: SizedBox(
        width: 25.0,
        height: 25.0,
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
      ),
      complete: Container(

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.insert_emoticon,
              color: Colors.blue,
            ),
            Container(
              width: 15.0,
            ),
            Text(
              '更新好啦~',
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
      ),
      idleIcon: Icon(
        Icons.favorite,
        size: 14.0,
        color: Colors.white,
      ),
    );
  }
}

class DYrefreshFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClassicFooter(
      textStyle: TextStyle(color: Colors.blue),
      loadingText: '我正在努力...',
      failedText: '加载失败了~',
      idleText: '上拉加载更多~',
      canLoadingText: '释放加载更多~',
      noDataText: '没有更多啦~',
      failedIcon: Icon(Icons.insert_emoticon, color: Colors.blue),
      canLoadingIcon: Icon(Icons.insert_emoticon, color: Colors.blue),
      idleIcon: Icon(Icons.insert_emoticon, color: Colors.blue),
      loadingIcon: SizedBox(
        width: 25.0,
        height: 25.0,
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
      ),
    );
  }
}

