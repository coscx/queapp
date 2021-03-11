import 'dart:async';
import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:city_pickers/city_pickers.dart';
import 'package:city_pickers/modal/result.dart';
import 'package:flui/flui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_geen/app/router.dart';
import 'package:flutter_geen/components/imageview/image_preview_page.dart';
import 'package:flutter_geen/components/imageview/image_preview_view.dart';
import 'package:flutter_geen/components/permanent/circle.dart';
import 'package:flutter_geen/views/dialogs/delete_category_dialog.dart';
import 'package:flutter_geen/views/pages/utils/DyBehaviorNull.dart';
import 'package:flutter_my_picker/flutter_my_picker.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_star/flutter_star.dart';
import 'package:flutter_geen/app/res/cons.dart';
import 'package:flutter_geen/blocs/bloc_exp.dart';
import 'package:flutter_geen/components/permanent/feedback_widget.dart';
import 'package:flutter_geen/components/permanent/panel.dart';
import 'package:flutter_geen/components/project/widget_node_panel.dart';
import 'package:flutter_geen/views/pages/widget_detail/category_end_drawer.dart';
import 'package:flutter_geen/views/items/tag.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter_geen/app/api/issues_api.dart';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:flutter_geen/views/items/share.dart';
class WidgetDetailPage extends StatefulWidget {


  WidgetDetailPage();

  @override
  _WidgetDetailPageState createState() => _WidgetDetailPageState();
}

class _WidgetDetailPageState extends State<WidgetDetailPage> {
  String memberId ;
  int connectStatus =4;
  int canEdit = 0;
  Map<String,dynamic>  userDetail;
  final List<ShareOpt> list = [
    ShareOpt(title:'微信', img:'assets/packages/images/login_wechat.svg',shareType:ShareType.SESSION,doAction:(shareType,shareInfo)async{
      if(shareInfo == null) return;
      /// 分享到好友
      var model = fluwx.WeChatShareWebPageModel(
        shareInfo.url,
        title: shareInfo.title,
        thumbnail: fluwx.WeChatImage.network(shareInfo.img),
        scene: fluwx.WeChatScene.SESSION,
      );
      fluwx.shareToWeChat(model);
    }),
  ];
  @override
  void initState() {
    super.initState();
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
      endDrawer: CategoryEndDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, //去掉Appbar底部阴影
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("用户详情",
            style:TextStyle(
              fontFamily: "Quicksand",
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
              fontSize: 38.sp,
              decoration: TextDecoration.none,
              color: Colors.black,
            )
        ),
        actions: <Widget>[
          _buildShare(),
          _buildToHome(),
          _buildCollectButton(context),
          Container(
            margin: EdgeInsets.fromLTRB(0.w, 15.h, 0.w, 0.h),
            child: PopupMenuButton<String>(
             icon: Icon(
               Icons.addchart,
                color: Colors.black,
              ),
              itemBuilder: (context) => buildItems(),
              offset: Offset(0, 60),
              color: Color(0xffF4FFFA),
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  )),
              onSelected: (e) {
                print(e);
                if (e == '移入良缘库') {
                  //BlocProvider.of<GlobalBloc>(context).add(EventSetIndexMode(0));
                 // var sex =BlocProvider.of<GlobalBloc>(context).state.sex;
                  //BlocProvider.of<HomeBloc>(context).add(EventFresh(sex,0,searchParamList,_showAge,_showAgeMax,_showAgeMin,serveType));
                }
                if (e == '移入公海') {
                  //BlocProvider.of<GlobalBloc>(context).add(EventSetIndexMode(2));
                  //var sex =BlocProvider.of<GlobalBloc>(context).state.sex;
                  //BlocProvider.of<HomeBloc>(context).add(EventFresh(sex,2, searchParamList,_showAge,_showAgeMax,_showAgeMin,serveType));
                }
                if (e == '划分客户') {
                  //BlocProvider.of<GlobalBloc>(context).add(EventSetIndexMode(1));
                  //var sex =BlocProvider.of<GlobalBloc>(context).state.sex;
                  //BlocProvider.of<HomeBloc>(context).add(EventFresh(sex,1,searchParamList,_showAge,_showAgeMax,_showAgeMin,serveType));
                }

              },
              onCanceled: () => print('onCanceled'),
            ),
          )
        ],


      ),
      body: Builder(builder: _buildContent),
    ));
  }
  List<PopupMenuItem<String>> buildItems() {
    final map = {
      "移入良缘库": Icons.archive_outlined,
      "移入公海": Icons.copyright_rounded,
      "划分客户": Icons.pivot_table_chart,
    };
    return map.keys
        .toList()
        .map((e) => PopupMenuItem<String>(
        value: e,
        child: Wrap(
          spacing: 5.h,
          children: <Widget>[
            Icon(
              map[e],
              color: Colors.black,
            ),
            Text(e),
          ],
        )))
        .toList();
  }
  Widget _buildContent(BuildContext context) => WillPopScope(
      onWillPop: () => _whenPop(context),
      child: ScrollConfiguration(
          behavior: DyBehaviorNull(),
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            BlocBuilder<DetailBloc, DetailState>(builder: _buildTitle),
            BlocBuilder<DetailBloc, DetailState>(builder: _buildDetail)
          ],
        ),
      )));

  Widget _buildToHome() => Builder(
      builder: (ctx) => GestureDetector(
          onLongPress: () => Scaffold.of(ctx).openEndDrawer(),
          child: Padding(
            padding:  EdgeInsets.only(top: 10.h),
            child: Container(
              width: 60.h,
              height: 60.h,
              margin: EdgeInsets.fromLTRB(10.w, 0.h, 5.w, 0.h),
              child:Lottie.asset('assets/packages/lottie_flutter/appointment.json'),
            ),
          ),
          onTap: () async {
            // Navigator.of(context).pushNamed(UnitRouter.baidu_map).then((value) {
            //   if(value != null && value !="")
            //   _showToast(ctx, value, true);
            // });
            if(canEdit ==1){
              _appoint(context,userDetail);

            }else{
              _showToast(ctx, "权限不足", true);
            }

          }
          ));
  Widget _buildShare() => Builder(
      builder: (ctx) => GestureDetector(
          onLongPress: () => Scaffold.of(ctx).openEndDrawer(),
          child: Padding(
            padding:  EdgeInsets.only(top: 15.h),
            child: Container(
              width: 80.h,
              height: 80.h,
              margin: EdgeInsets.fromLTRB(10.w, 0.h, 0.w, 0.h),
              child:Lottie.asset('assets/packages/lottie_flutter/share.json'),
            ),
          ),
          onTap: () async {
            showModalBottomSheet(
              /**
               * showModalBottomSheet常用属性
               * shape 设置形状
               * isScrollControlled：全屏还是半屏
               * isDismissible：外部是否可以点击，false不可以点击，true可以点击，点击后消失
               * backgroundColor : 设置背景色
               */
                backgroundColor: Colors.transparent,
                context: context,
                builder: (BuildContext context) {
                  return ShareWidget(
                    ShareInfo('Hello world','http://www.baidu.com',"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.mp.sohu.com%2Fupload%2F20170601%2Faf68bce89ac945e7ad00da688a25fb08.png&refer=http%3A%2F%2Fimg.mp.sohu.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1613110527&t=2cdb6d82fcfc0482bb12ffd8cac9b01a",""),
                    list: list,
                  );
                });
          }
      ));
  Widget _buildCollectButton( BuildContext context) {
    //监听 CollectBloc 伺机弹出toast
    return BlocListener<DetailBloc, DetailState>(
        listener: (ctx, st) {
          if (st is DelSuccessData){
              _showToast(ctx, st.reason, true);
          }
        },
        child: FeedbackWidget(
          onPressed: () {
            _comment(context,connectStatus,userDetail);
          } ,
          child: BlocBuilder<CollectBloc, CollectState>(
              builder: (_, s) => Padding(
                    padding:  EdgeInsets.only(right: 20.0,top: 10.h),
                    child: Container(
                      width: 60.h,
                      height: 60.h,
                      margin: EdgeInsets.fromLTRB(10.w, 5.h, 5.w, 0.h),
                      child:Lottie.asset('assets/packages/lottie_flutter/chat.json'),
                    ),
                  )),
        ));
  }

  final List<int> colors = Cons.tabColors;
  int _position = 0;
  Future<bool> _whenPop(BuildContext context) async {
    if (Scaffold.of(context).isEndDrawerOpen) return true;
      return true;
  }
  List<Widget> _listViewConnectList(List<dynamic>connectList ){
    return connectList.map((e) =>
    _item(context,e['username'],e['connect_time']==null?"":e['connect_time'],e['connect_message'],e['subscribe_time']==null?"":e['subscribe_time'],e['connect_status'].toString(),e['connect_type'].toString())
    ).toList();
  }
  List<Widget> _listViewAppointList(List<dynamic>connectList ){
    return connectList.map((e) =>
        _item_appoint(context,e['username'],e['other_name']==null?"":e['other_name'],e['appointment_address'],e['appointment_time']==null?"":e['appointment_time'],e['can_write'].toString(),e['remark'].toString(),e['feedback1'].toString())
    ).toList();
  }

  Widget _buildDetail(BuildContext context, DetailState state) {
    //print('build---${state.runtimeType}---');
    if (state is DetailWithData  ) {
     return _BuildStateDetail(context,state.userdetails,state.connectList,state.appointList);
    }
    if(state is DelSuccessData){
      return _BuildStateDetail(context,state.userdetails,state.connectList,state.appointList);
    }
    if(state is DetailLoading){

    }
    return Container(
      child: Container(child:
      Column(
        children: [
          SizedBox(
            height: 0.h,
          ),
          //Image.asset("assets/images/loadings.gif"),
          Lottie.asset('assets/packages/lottie_flutter/loading.json'),
        ],
      )),
    );
  }
  Widget _BuildStateDetail(BuildContext context, Map<String,dynamic> userdetails, Map<String,dynamic> connectLists, Map<String,dynamic> appointLists){

    var info = userdetails['info'];
    canEdit= userdetails['can_edit'];
    userDetail=info;
    List<dynamic> connectList = connectLists['data'];
    List<dynamic> appointList = appointLists['data'];
    if (connectList.length>0){
      Map<String ,dynamic> e=connectList.first;
      if (e!=null)
        connectStatus=e['connect_status'];
    }
    List<Widget> list = _listViewConnectList(connectList);
    List<Widget> appointListView = _listViewAppointList(appointList);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 15.w, right: 5.w,bottom: 0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //CustomsExpansionPanelList()
              //_item(context),
              WidgetNodePanel(
                  codeFamily: 'Inconsolata',
                  text: "基础资料",
                  code: "",
                  show: Container(
                    width:  ScreenUtil().screenWidth*0.98,
                    // height: 300,
                    child:
                    Wrap(
                        alignment: WrapAlignment.start,
                        direction: Axis.horizontal,
                        spacing: 0,
                        runSpacing: 0,
                        children: <Widget>[
                          GestureDetector(
                              onTap: (){

                              },child: _item_detail(context,Colors.black,Icons.format_list_numbered,"编号",info['code'].toString(),false)),
                          GestureDetector(
                              onTap: (){
                                _showEditDialog(context,"请输入姓名","",info['name'].toString(),"name",1,info);
                              },child: _item_detail(context,Colors.black,Icons.backpack_outlined,"姓名",info['name'].toString(),true)),
                          GestureDetector(
                              onTap: (){
                                showPickerArray(context,[["未知","男生","女生"]],info['gender']==0?[1]:[info['gender']],"gender",info,"",true);
                              },child:  _item_detail(context,Colors.black,Icons.support_agent,"性别",info['gender']==1?"男生":"女生",true)),
                          GestureDetector(
                              onTap: (){
                              },child: _item_detail(context,Colors.black,Icons.contact_page_outlined,"年龄",info['age']==0?"-":info['age'].toString()+"岁",false)),
                          GestureDetector(
                              onTap: (){
                                showPickerDateTime(context,info['birthday']==null?"-":info['birthday'].toString(),"birthday",info);
                              },child:  _item_detail(context,Colors.black,Icons.broken_image_outlined,"生日",info['birthday']==null?"-":info['picker.adapter.text']!=""?info['birthday'].toString():info['birthday'].toString().substring(0,10)+"("+info['chinese_zodiac']+"-"+info['zodiac']+")",true)),
                          GestureDetector(
                              onTap: (){

                              },child:  _item_detail(context,Colors.red,Icons.settings_backup_restore_outlined,"八字",info['bazi'].toString(),false)),
                          GestureDetector(
                              onTap: (){
                              },child:  _item_detail(context,Colors.orange,Icons.whatshot,"五行",info['wuxing'].toString(),false)),
                          GestureDetector(
                              onTap: () async {
                                Result result = await CityPickers.showCityPicker(
                                    context: context,
                                    locationCode: info['np_area_code'] =="" ? (info['np_city_code'] ==""? "320500":info['np_city_code'] ) :info['np_area_code'] ,
                                    cancelWidget: Text("取消",style: TextStyle(color: Colors.black),),
                                    confirmWidget: Text("确定",style: TextStyle(color: Colors.black),)
                                );
                                print(result);
                                if(result !=null){
                                  var results= await IssuesApi.editCustomerAddress(info['uuid'],1,result);
                                  if(results['code']==200){
                                    BlocProvider.of<DetailBloc>(context).add(EditDetailEventAddress(result,1));
                                    _showToast(context,"编辑成功",false);
                                  }else{

                                    _showToast(context,results['message'],false);
                                  }
                                }
                              },child:  _item_detail(context,Colors.black,Icons.local_activity_outlined,"籍贯",info['native_place']==null?"-":(info['native_place']==""?"-":info['native_place'].toString()),true)),
                          GestureDetector(
                              onTap: () async {
                                Result result = await CityPickers.showCityPicker(
                                    context: context,
                                    locationCode: info['lp_area_code'] =="" ? (info['lp_city_code'] ==""? "320500":info['lp_city_code'] ) :info['lp_area_code'] ,
                                    cancelWidget: Text("取消",style: TextStyle(color: Colors.black),),
                                    confirmWidget: Text("确定",style: TextStyle(color: Colors.black),)
                                );
                                print(result);
                                if(result !=null){
                                  var results= await IssuesApi.editCustomerAddress(info['uuid'],2,result);
                                  if(results['code']==200){
                                    BlocProvider.of<DetailBloc>(context).add(EditDetailEventAddress(result,2));
                                    _showToast(context,"编辑成功",false);
                                  }else{
                                    _showToast(context,results['message'],false);
                                  }
                                }
                              },child:  _item_detail(context,Colors.black,Icons.house_outlined,"居住",info['location_place']==null?"-":(info['location_place']==""?"-":info['location_place'].toString()),true)),
                          GestureDetector(
                              onTap: (){
                              },child:  _item_detail(context,Colors.black,Icons.point_of_sale,"销售",info['sale_user'].toString(),false)),
                          GestureDetector(
                              onTap: (){
                                showPickerArray(context,[_nationLevel],info['nation']==0?[1]:[info['nation']],"nation",info,"",true);
                              },child: _item_detail(context,Colors.black,Icons.gamepad_outlined,"民族",info['nation']==""?"-":_getNationLevel((info['nation'])),true)),
                          GestureDetector(
                              onTap: (){
                                showPickerArray(context,[_getHeightList()],info['height']==0?[70]:[_getIndexOfList(_getHeightList(),info['height'].toString())],"height",info,"身高(cm)",false);
                              },child:  _item_detail(context,Colors.black,Icons.height,"身高",info['height']==0?"-":info['height'].toString()+"cm",true)),
                          GestureDetector(
                              onTap: (){
                                showPickerArray(context,[_getWeightList()],info['weight']==0?[35]:[_getIndexOfList(_getWeightList(),info['weight'].toString())],"weight",info,"体重(kg)",false);
                              },child:  _item_detail(context,Colors.black,Icons.line_weight,"体重",info['weight']==0?"-":info['weight'].toString()+"kg",true)),
                          GestureDetector(
                              onTap: (){
                              },child:  _item_detail(context,Colors.black,Icons.design_services_outlined,"服务",info['serve_user']==""?"-":info['serve_user'].toString(),false)),
                          GestureDetector(
                              onTap: (){
                                _showEditDialog(context,"请输入兴趣","",info['interest']==null?"-":(info['interest']==""?"-":info['interest'].toString()),"interest",5,info);
                              },child:  _item_detail(context,Colors.black,Icons.integration_instructions_outlined,"兴趣",info['interest']==""?"-":info['interest'].toString(),true)),
                          GestureDetector(
                              onTap: (){
                                showPickerArray(context,[_floodLevel],info['blood_type']==0?[3]:[info['blood_type']],"blood_type",info,"",true);
                              },child:  _item_detail(context,Colors.black,Icons.blur_on_outlined,"血型",info['blood_type']==0?"-":_getFloodLevel(info['blood_type']),true)),
                          GestureDetector(
                              onTap: (){
                                _showEditDialog(context,"请输入择偶要求","",info['demands']==null?"":(info['demands']==""?"":info['demands'].toString()),"demands",5,info);
                              },child:   _item_detail(context,Colors.black,Icons.developer_mode,"择偶",info['demands']==null?"-":(info['demands']==""?"-":info['demands'].toString()),true)),
                          GestureDetector(
                              onTap: (){
                                _showEditDialog(context,"请输入备注","",info['remark']==null?"":(info['remark']==""?"":info['remark'].toString()),"remark",5,info);
                              },child:    _item_detail(context,Colors.black,Icons.bookmarks_outlined,"备注",info['remark']==null?"-":(info['remark']==""?"-":info['remark'].toString()),true)),

                        ]
                    ),

                  )
              ),

            ],
          ),
        ),

        Container(
          margin: EdgeInsets.only(left: 15.w, right: 5.w,bottom: 0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              //CustomsExpansionPanelList()
              //_item(context),
              WidgetNodePanel(
                  codeFamily: 'Inconsolata',
                  text: "学历工作及资产",
                  code: "",
                  show: Container(
                    width:  ScreenUtil().screenWidth*0.98,
                    // height: 300,
                    child:
                    Wrap(
                        alignment: WrapAlignment.start,
                        direction: Axis.horizontal,
                        spacing: 0,
                        runSpacing: 0,
                        children: <Widget>[
                          GestureDetector(
                              onTap: (){
                                showPickerArray(context,[_EduLevel],info['education']==0?[1]:[info['education']],"education",info,"",true);
                              } ,child:_item_detail_gradute(context,Colors.redAccent,Icons.menu_book,"个人学历",info['education']==0?"-":_getEduLevel(info['education']),true)),
                          GestureDetector(
                              onTap: (){
                                _showEditDialog(context,"请输入毕业院校","",info['school']==null?"":(info['school']==""?"":info['school'].toString()),"school",1,info);
                              } ,child:_item_detail_gradute(context,Colors.black,Icons.school,"毕业院校",info['school'].toString()==""?"-":info['school'].toString(),true)),
                          GestureDetector(
                              onTap: (){
                                _showEditDialog(context,"请输入所学专业","",info['major']==null?"":(info['major']==""?"":info['major'].toString()),"major",1,info);
                              } ,child:_item_detail_gradute(context,Colors.black,Icons.tab,"所学专业",info['major']==""?"-":info['major'].toString(),true)),
                          GestureDetector(
                              onTap: (){
                                showPickerArray(context,[_companyTypeLevel],info['work']==0?[1]:[info['work']],"work",info,"",true);
                              } ,child:_item_detail_gradute(context,Colors.black,Icons.reduce_capacity,"企业类型",info['work']==0?"-":_getCompanyLevel(info['work'])+"",true)),
                          GestureDetector(
                              onTap: (){
                                showPickerArray(context,[_WorkTypeLevel],info['work_job']==0?[1]:[info['work_job']],"work_job",info,"",true);
                              } ,child:_item_detail_gradute(context,Colors.black,Icons.location_city,"所属行业",info['work_job']==""?"-":_getWorkType(info['work_job']),true)),
                          GestureDetector(
                              onTap: (){
                                _showEditDialog(context,"请输入职位描述","",info['work_industry']==null?"":(info['work_industry']==""?"":info['work_industry'].toString()),"work_industry",5,info);
                              } ,child:_item_detail_gradute(context,Colors.black,Icons.description_outlined,"职位描述",info['work_industry']==""?"-":info['work_industry'].toString(),true)),
                          GestureDetector(
                              onTap: (){
                                showPickerArray(context,[_WorkOverTimeLevel],info['work_overtime']==0?[1]:[info['work_overtime']],"work_overtime",info,"",true);
                              } ,child:_item_detail_gradute(context,Colors.black,Icons.more_outlined,"加班情况",info['work_overtime']==""?"-":_getWorkOverTime(info['work_overtime']),true)),
                          GestureDetector(
                              onTap: (){
                                showPickerArray(context,[_IncomeLevel],info['income']==0?[1]:[info['income']],"income",info,"",true);
                              } ,child:_item_detail_gradute(context,Colors.redAccent,Icons.monetization_on_outlined,"收入情况",info['income']==0?"-":_getIncome(info['income']),true)),
                          GestureDetector(
                              onTap: (){
                                showPickerArray(context,[_hasHouseLevel],info['has_house']==0?[1]:[info['has_house']],"has_house",info,"",true);
                              } ,child:_item_detail_gradute(context,Colors.redAccent,Icons.house_outlined,"是否有房",info['has_house']==0?"-":_getHasHouse(info['has_house']),true)),
                          GestureDetector(
                              onTap: (){
                                showPickerArray(context,[_houseFutureLevel],info['loan_record']==0?[1]:[info['loan_record']],"loan_record",info,"",true);
                              } ,child: _item_detail_gradute(context,Colors.black,Icons.copyright_rounded,"房贷情况",info['loan_record']==0?"-":_getHouseFuture(info['loan_record']),true)),
                          GestureDetector(
                              onTap: (){
                                showPickerArray(context,[_hasCarLevel],info['has_car']==0?[1]:[info['has_car']],"has_car",info,"",true);
                              } ,child:_item_detail_gradute(context,Colors.black,Icons.car_rental,"是否有车",info['has_car']==0?"-":_getHasCar(info['has_car']),true)),
                          GestureDetector(
                              onTap: (){
                                showPickerArray(context,[_carLevelLevel],info['car_type']==0?[1]:[info['car_type']],"car_type",info,"",true);
                              } ,child: _item_detail_gradute(context,Colors.black,Icons.wb_auto_outlined,"车辆档次",info['car_type']==0?"-":_getCarLevel(info['car_type']),true)),

                        ]
                    ),
                  )
              ),
            ],
          ),

        ),

        Container(
          margin: EdgeInsets.only(left: 15.w, right: 5.w,bottom: 0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //CustomsExpansionPanelList()
              //_item(context),
              WidgetNodePanel(
                  codeFamily: 'Inconsolata',
                  text: "婚姻及父母家庭",
                  code: "",
                  show: Container(
                    width:  ScreenUtil().screenWidth*0.98,
                    // height: 300,
                    child:
                    Wrap(
                        alignment: WrapAlignment.start,
                        direction: Axis.horizontal,
                        spacing: 0,
                        runSpacing: 0,
                        children: <Widget>[
                          GestureDetector(
                              onTap: (){
                                showPickerArray(context,[_marriageLevel],info['marriage']==0?[1]:[info['marriage']],"marriage",info,"",true);
                              } ,child:  _item_detail_gradute(context,Colors.redAccent,Icons.wc,"婚姻状态",info['marriage']==0?"-":_getMarriageLevel(info['marriage']),true)),
                          GestureDetector(
                              onTap: (){
                                showPickerArray(context,[_childLevel],info['has_child']==0?[1]:[info['has_child']],"has_child",info,"",true);
                              } ,child:  _item_detail_gradute(context,Colors.redAccent,Icons.child_care,"子女信息",info['has_child']==0?"-":_getChildLevel(info['has_child']),true)),
                          GestureDetector(
                              onTap: (){
                                _showEditDialog(context,"请输入子女备注","",info['child_remark']==null?"":(info['child_remark']==""?"":info['child_remark'].toString()),"child_remark",5,info);
                              } ,child:_item_detail_gradute(context,Colors.black,Icons.mark_chat_read_outlined,"子女备注",info['child_remark']==""?"-":info['child_remark'].toString(),true)),
                          GestureDetector(
                              onTap: (){
                                showPickerArray(context,[_onlyChildLevel],info['only_child']==0?[1]:[info['only_child']],"only_child",info,"",true);
                              } ,child:_item_detail_gradute(context,Colors.black,Icons.looks_one_outlined,"独生子女",info['only_child']==0?"-":_getOnlyChildLevel(info['only_child'])+"",true)),
                          GestureDetector(
                              onTap: (){
                                showPickerArray(context,[_parentLevel],info['parents']==0?[1]:[info['parents']],"parents",info,"",true);
                              } ,child: _item_detail_gradute(context,Colors.black,Icons.watch_later_outlined,"父母状况",info['parents']==0?"-":_getParentLevel(info['parents']),true)),
                          GestureDetector(
                              onTap: (){
                                _showEditDialog(context,"请输入父亲职业","",info['father_work']==null?"":(info['father_work']==""?"":info['father_work'].toString()),"father_work",1,info);
                              } ,child: _item_detail_gradute(context,Colors.black,Icons.attribution_rounded,"父亲职业",info['father_work']==""?"-":info['father_work'].toString(),true)),
                          GestureDetector(
                              onTap: (){
                                _showEditDialog(context,"请输入母亲职业","",info['mother_work']==null?"":(info['mother_work']==""?"":info['mother_work'].toString()),"mother_work",1,info);
                              } ,child:_item_detail_gradute(context,Colors.black,Icons.sports_motorsports_outlined,"母亲职业",info['mother_work']==""?"-":info['mother_work'].toString(),true)),
                          GestureDetector(
                              onTap: (){
                                _showEditDialog(context,"请输入父母收入","",info['parents_income']==null?"":(info['parents_income']==""?"":info['parents_income'].toString()),"parents_income",1,info);
                              } ,child: _item_detail_gradute(context,Colors.redAccent,Icons.monetization_on,"父母收入",info['parents_income']==""?"-":info['parents_income'].toString(),true)),
                          GestureDetector(
                              onTap: (){
                                showPickerArray(context,[_parentProtectLevel],info['parents_insurance']==0?[1]:[info['parents_insurance']],"parents_insurance",info,"",true);
                              } ,child: _item_detail_gradute(context,Colors.redAccent,Icons.nine_k,"父母社保",info['parents_insurance']==0?"-":_getParentProtectLevel(info['parents_insurance']),true)),
                        ]
                    ),
                  )
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 15.w, right: 5.w,bottom: 0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //CustomsExpansionPanelList()
              //_item(context),
              WidgetNodePanel(
                  codeFamily: 'Inconsolata',
                  text: "用户画像相关",
                  code: "",
                  show: Container(
                    width:  ScreenUtil().screenWidth*0.98,
                    // height: 300,
                    child:
                    Wrap(
                        alignment: WrapAlignment.start,
                        direction: Axis.horizontal,
                        spacing: 0,
                        runSpacing: 0,
                        children: <Widget>[
                          GestureDetector(
                              onTap: (){
                                showPickerArray(context,[_faithLevel],info['faith']==0?[0]:[info['faith']],"faith",info,"",true);
                              } ,child:_item_detail_gradute(context,Colors.black,Icons.fastfood,"宗教信仰",info['faith']==0?"-":_getFaithLevel(info['faith']),true)),
                          GestureDetector(
                              onTap: (){
                                showPickerArray(context,[_smokeLevel],info['smoke']==0?[0]:[info['smoke']],"smoke",info,"",true);
                              } ,child:_item_detail_gradute(context,Colors.black,Icons.smoking_rooms,"是否吸烟",info['smoke']==0?"-":_getSmokeLevel(info['smoke']),true)),
                          GestureDetector(
                              onTap: (){
                                showPickerArray(context,[_drinkLevel],info['drinkwine']==0?[0]:[info['drinkwine']],"drinkwine",info,"",true);
                              } ,child:_item_detail_gradute(context,Colors.black,Icons.wine_bar,"是否喝酒",info['drinkwine']==0?"-":_getDrinkLevel(info['drinkwine']),true)),
                          GestureDetector(
                              onTap: (){
                                showPickerArray(context,[_lifeLevel],info['live_rest']==0?[0]:[info['live_rest']],"live_rest",info,"",true);
                              } ,child:_item_detail_gradute(context,Colors.black,Icons.nightlife,"生活作息",info['live_rest']==0?"-":_getLifeLevel(info['live_rest'])+"",true)),
                          GestureDetector(
                              onTap: (){
                                showPickerArray(context,[_creatLevel],info['want_child']==0?[0]:[info['want_child']],"want_child",info,"",true);
                              } ,child:_item_detail_gradute(context,Colors.black,Icons.child_friendly_outlined,"生育欲望",info['want_child']==0?"-":_getCreatLevel(info['want_child']),true)),
                          GestureDetector(
                              onTap: (){
                                showPickerArray(context,[_marriageDateLevel],info['marry_time']==0?[0]:[info['marry_time']],"marry_time",info,"",true);
                              } ,child:_item_detail_gradute(context,Colors.black,Icons.margin,"结婚预期",info['marry_time']==0?"-":_getMarriageDateLevel(info['marry_time']),true)),
                        ]
                    ),
                  )
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 15.w, right: 5.w,bottom: 0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //CustomsExpansionPanelList()
              //_item(context),
              WidgetNodePanel(
                  codeFamily: 'Inconsolata',
                  text: "用户图片",
                  code: "",
                  show: Container(
                    width:  ScreenUtil().screenWidth*0.98,
                    // height: 300,
                    child:
                    Wrap(
                        alignment: WrapAlignment.start,
                        direction: Axis.horizontal,
                        spacing: 0,
                        runSpacing: 0,
                        children: <Widget>[
                          _buildLinkTo(
                            context,
                            userdetails,
                          ),
                        ]
                    ),
                  )
              ),
            ],
          ),
        ),

        //_buildNodes(state.nodes, state.widgetModel.name)
        Container(
          margin: EdgeInsets.only(left: 15.w, right: 5.w,bottom: 0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //CustomsExpansionPanelList()
              //_item(context),
              WidgetNodePanel(
                  codeFamily: 'Inconsolata',
                  text: "客户沟通记录",
                  code: "",
                  show: list.length > 0 ? Container(
                    width:  ScreenUtil().screenWidth*0.98,
                    // height: 300,
                    child:
                    Wrap(
                        alignment: WrapAlignment.start,
                        direction: Axis.horizontal,
                        spacing: 0,
                        runSpacing: 0,
                        children: <Widget>[
                          ...list
                        ]
                    ),
                  ):Container(child: Text("暂无沟通"),)
              ),
            ],
          ),
        ),
        //_buildNodes(state.nodes, state.widgetModel.name)
        Container(
          margin: EdgeInsets.only(left: 15.w, right: 5.w,bottom: 0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //CustomsExpansionPanelList()
              //_item(context),
              WidgetNodePanel(
                  codeFamily: 'Inconsolata',
                  text: "客户排约记录",
                  code: "",
                  show: appointListView.length > 0 ? Container(
                    width:  ScreenUtil().screenWidth*0.98,
                    // height: 300,
                    child:
                    Wrap(
                        alignment: WrapAlignment.start,
                        direction: Axis.horizontal,
                        spacing: 0,
                        runSpacing: 0,
                        children: <Widget>[
                          ...appointListView
                        ]
                    ),
                  ):Container(child: Text("暂无排约"),)
              ),
            ],
          ),
        ),
      ],
    );
  }




  Widget _buildTitle(BuildContext context, DetailState state) {
    //print('build---${state.runtimeType}---');
    if (state is DetailWithData) {
      return header(state.userdetails);
      return WidgetDetailTitle(
        usertail: state.userdetails,
      );
    }
    return Container();
  }
  Widget _item_photo(BuildContext context) {
    bool isDark = false;

    return  Container(
      padding:  EdgeInsets.only(
          top: 10.h,
          bottom: 0
      ),
      width: double.infinity,
      height: 80.h,
      child:  Material(
          color:  Colors.transparent ,
          child: InkWell(
            onTap: (){},
            child: Container(
              margin: EdgeInsets.only(left: 10.w, right: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                      children: <Widget>[
                        Icon(
                          Icons.account_circle_outlined,
                          size: 18,
                          color: Colors.black54,
                        ),

                        Container(
                          margin: EdgeInsets.only(left: 15.w),
                          child: Text(
                            "姓名",
                            style: TextStyle(fontSize: 30.sp, color: Colors.grey),
                          ),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(10),
                        ),
                        Visibility(
                            visible: true,
                            child: Text(
                              "用户已接待，有意愿继续服务",
                              style: TextStyle(
                                  fontSize: 12.sp, color: Colors.black),
                            )),
                      ]),
                  //Visibility是控制子组件隐藏/可见的组件
                  Visibility(
                    visible: true,
                    child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 10.w),
                            child: Row(children: <Widget>[

                              SizedBox(
                                width: ScreenUtil().setWidth(10),
                              ),
                              Visibility(
                                  visible: true,
                                  child: Text(
                                    "2021-01-12 15:35:30",
                                    style: TextStyle(
                                        fontSize: 7.sp, color: Colors.grey),
                                  )),



                              Visibility(
                                  visible: false,
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage("rightImageUri"),
                                  ))
                            ]),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 15,
                            color: Colors.black54,
                          )

                        ]),
                  )
                ],
              ),
            ),
          )),
    );
  }

  Widget _item_detail(BuildContext context,Color color,IconData icon,String name ,String answer,bool show) {
    bool isDark = false;

    return  Container(
      padding:  EdgeInsets.only(
          top: 10.h,
          bottom: 0
      ),
      width: double.infinity,
      //height: 80.h,
      child:  Material(
          color:  Colors.transparent ,
          child: Container(
            child: Container(
              margin: EdgeInsets.only(left: 10.w, right: 20.w,top: 10.h,bottom: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                      children: <Widget>[
                        Icon(
                          icon,
                          size: 32.sp,
                          color: Colors.black54,
                        ),

                        Container(
                          margin: EdgeInsets.only(left: 15.w),
                          child: Text(
                            name,
                            style: TextStyle(fontSize: 30.sp, color: Colors.grey),
                          ),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(10.w),
                        ),
                        Visibility(
                            visible: true,
                            child: Container(
                              width: ScreenUtil().screenWidth*0.71,
                              child: Text(
                                answer,
                                maxLines: 20,
                                style: TextStyle(
                                    fontSize: 28.sp, color: color),
                              ),
                            )),
                      ]),
                  //Visibility是控制子组件隐藏/可见的组件
                  Visibility(
                    visible: show,
                    child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 10.w),
                            child: Row(children: <Widget>[

                              SizedBox(
                                width: ScreenUtil().setWidth(10.w),
                              ),
                              Visibility(
                                  visible: false,
                                  child: Text(
                                    "2021-01-12 15:35:30",
                                    style: TextStyle(
                                        fontSize: 14.sp, color: Colors.grey),
                                  )),



                              Visibility(
                                  visible: false,
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage("rightImageUri"),
                                  ))
                            ]),
                          ),

                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 30.sp,
                            color: Colors.black54,
                          )

                        ]),
                  )
                ],
              ),
            ),
          )),
    );
  }
  Widget _item_detail_gradute(BuildContext context,Color color,IconData icon,String name ,String answer,bool show) {
    bool isDark = false;

    return  Container(
      padding:  EdgeInsets.only(
          top: 10.h,
          bottom: 0
      ),
      width: double.infinity,
      //height: 180.h,
      child:  Material(
          color:  Colors.transparent ,
          child: Container(
            child: Container(
              margin: EdgeInsets.only(left: 10.w, right: 20.w,top: 10.h,bottom: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                      children: <Widget>[
                        Icon(
                          icon,
                          size: 32.sp,
                          color: Colors.black54,
                        ),

                        Container(
                          margin: EdgeInsets.only(left: 15.w),
                          child: Text(
                            name,
                            style: TextStyle(fontSize: 30.sp, color: Colors.grey),
                          ),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(10.w),
                        ),
                        Visibility(
                            visible: true,
                            child: Container(
                              width: ScreenUtil().screenWidth*0.6,
                              child: Text(
                                answer,
                                maxLines: 20,
                                style: TextStyle(
                                    fontSize: 28.sp, color: color),
                              ),
                            )),
                      ]),
                  //Visibility是控制子组件隐藏/可见的组件
                  Visibility(
                    visible: show,
                    child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 10.w),
                            child: Row(children: <Widget>[

                              SizedBox(
                                width: ScreenUtil().setWidth(10.w),
                              ),
                              Visibility(
                                  visible: false,
                                  child: Text(
                                    "2021-01-12 15:35:30",
                                    style: TextStyle(
                                        fontSize: 14.sp, color: Colors.grey),
                                  )),



                              Visibility(
                                  visible: false,
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage("rightImageUri"),
                                  ))
                            ]),
                          ),

                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 30.sp,
                            color: Colors.black54,
                          )

                        ]),
                  )
                ],
              ),
            ),
          )),
    );
  }
  Widget _item(BuildContext context,String name ,String connectTime,String content,String subscribeTime,String connectStatus,String connectType) {
    bool isDark = false;

    return  Container(
      padding:  EdgeInsets.only(
        top: 10.h,
        bottom: 0
      ),
      width: double.infinity,
      //height: 180.h,
      child:  Material(
          color:  Colors.transparent ,
          child: InkWell(
            onTap: (){
              _showBottom(context,content,_getStatusIndex(int.parse(connectStatus)),connectType);
              },
            child: Container(
                margin: EdgeInsets.only(left: 15.w, right: 20.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                          children: <Widget>[
                            Circle(
                              //connectType 沟通类型 1-线上沟通 2-到店沟通
                              color: connectType=="1"?Colors.green:Colors.redAccent,
                              radius: 5,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15.w),
                              child: Text(
                                name==null?"":name,
                                style: TextStyle(fontSize: 30.sp, color: Colors.black54),
                              ),
                            ),
                            SizedBox(
                              width: ScreenUtil().setWidth(10.w),
                            ),
                            Visibility(
                                visible: true,
                                child: Container(
                                  width: ScreenUtil().screenWidth*0.71,
                                  child: Text(
                                   content,
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 25.sp, color: Colors.black,fontWeight: FontWeight.w900),
                                  ),
                                )),
                          ]),
                      //Visibility是控制子组件隐藏/可见的组件
                      Visibility(
                        visible: true,
                        child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 15.sp,
                                color: Colors.black54,
                              )

                            ]),
                      )
                    ],
                  ),

                  Container(
                    margin: EdgeInsets.only(left: 10.w,top: 10.h),
                    child: Row(children: <Widget>[

                      SizedBox(
                        width: ScreenUtil().setWidth(10.w),
                      ),
                      Visibility(
                          visible: true,
                          child: Text(
                            "沟通时间:"+(connectTime==null?"":connectTime),
                            style: TextStyle(
                                fontSize: 20.sp, color: Colors.black54),
                          )),
                      SizedBox(
                        width: ScreenUtil().setWidth(10.w),
                      ),

                        Visibility(
                          visible: true,
                          child: Text(
                            "预约时间:"+(subscribeTime==null?"":subscribeTime),
                            style: TextStyle(
                                fontSize: 20.sp, color: Colors.black54),
                          )),
                    ]),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Widget _item_appoint(BuildContext context,String name ,String other_name,String appointment_address,String appointment_time,String can_write,String remark,String feedback1) {
    bool isDark = false;

    return  Container(
      padding:  EdgeInsets.only(
          top: 10.h,
          bottom: 0
      ),
      width: double.infinity,
      //height: 180.h,
      child:  Material(
          color:  Colors.transparent ,
          child: InkWell(
            onTap: (){
              _showAppointBottom(context,name,other_name,appointment_time,appointment_address,remark,feedback1);
            },
            child: Container(
              margin: EdgeInsets.only(left: 15.w, right: 20.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                          children: <Widget>[
                            Circle(
                              //connectType 沟通类型 1-线上沟通 2-到店沟通
                              color: Colors.redAccent,
                              radius: 5,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15.w),
                              child: Text(
                                name==null?"":name,
                                style: TextStyle(fontSize: 30.sp, color: Colors.black54),
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Container(
                              child: Icon(
                                Icons.account_tree_outlined,
                                size: 32.sp,
                                color: Colors.grey,
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 15.w),
                              child: Text(
                                other_name==null?"":other_name,
                                style: TextStyle(fontSize: 30.sp, color: Colors.black54),
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Visibility(
                                visible: true,
                                child: Container(
                                  width: ScreenUtil().screenWidth*0.49,
                                  child: Text(
                                    remark,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 25.sp, color: Colors.black,fontWeight: FontWeight.w900),
                                  ),
                                )),
                          ]),
                      //Visibility是控制子组件隐藏/可见的组件
                      Visibility(
                        visible: true,
                        child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 25.sp,
                                color: Colors.black54,
                              )

                            ]),
                      )
                    ],
                  ),

                  Container(
                    margin: EdgeInsets.only(left: 10.w,top: 10.h),
                    child: Row(children: <Widget>[

                      SizedBox(
                        width: ScreenUtil().setWidth(10.w),
                      ),
                      Visibility(
                          visible: true,
                          child: Text(
                            "约会时间:"+(appointment_time==null?"":appointment_time),
                            style: TextStyle(
                                fontSize: 20.sp, color: Colors.black54),
                          )),
                      SizedBox(
                        width: ScreenUtil().setWidth(10.w),
                      ),



                      Visibility(
                          visible: true,
                          child: Container(
                            width: ScreenUtil().screenWidth*0.51,
                            child: Text(
                              "约会地点:"+(appointment_address==null?"":appointment_address),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 20.sp, color: Colors.black54),
                            ),
                          )),
                    ]),
                  ),
                ],
              ),
            ),
          )),
    );
  }
  avatar(String url,bool isVip) {
    return Container(

      child: Stack(
        children: [
          isVip ? Container(

            width: 180.w,
            height: 180.h,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/radio_header_1.png"),
                  fit: BoxFit.cover,
                ),
            ),
            margin: EdgeInsets.only(left: 12.w),
          ):Container(),
          Container(
            margin: EdgeInsets.only(left: 42.w,top: 20.h),

            child: CircleAvatar(
              radius:(60.w) ,
              child: ClipOval(
                child: Image.network(
                  url,
                   fit: BoxFit.cover,
                  width: 120.w,
                  height: 120.h,
                ),
              ),
              backgroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  header(Map<String,dynamic> user) {
    bool isVip;
    var vipExpireTime =user['info']['vip_expire_time'];
    if(vipExpireTime ==null){
      isVip=false;
    }else{
      isVip=true;
    }
    return Container(
      height: 140.h,
      margin: EdgeInsets.only(top: 8.h,bottom: 10.h,left: 12.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          GestureDetector(
          onTap: () {
              ImagePreview.preview(
                context,
                images: List.generate(1, (index) {
                return ImageOptions(
                        url: user['pic'].length> 0? (user['pic'][0]) :("assets/packages/images/ic_user_none_round.png"),
                        tag: user['pic'].length> 0? (user['pic'][0]) :("assets/packages/images/ic_user_none_round.png"),
                        );
                }),
              );
          },
      child:Padding(
            padding: EdgeInsets.only(left: 10.w, right: 0.w),
            child: user['pic'].length> 0? avatar(user['pic'][0],isVip) :Image.asset("assets/packages/images/ic_user_none_round.png"),
          )),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                 Container(
                 margin: EdgeInsets.fromLTRB(10.w, 5.h, 5.w, 0.h),
                 child:
                 Text(
                  user['info']['name'],
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 32.sp,
                    ),
                  )),
                  Container(
                      color: Colors.black12,
                      padding: EdgeInsets.fromLTRB(5.w, 0.h, 5.w, 0.h),
                      margin: EdgeInsets.fromLTRB(5.w, 10.h, 5.w, 0.h),
                      alignment: Alignment.centerLeft,
                      height: 24.h,
                      child: Text(
                        user['info']['age'].toString(),
                        style: TextStyle(color: Colors.black, fontSize: 18.sp),
                      )),

                  user['info']['vip_expire_time']!=null?Container(
                      width: 60.h,
                      height: 60.h,
                      margin: EdgeInsets.fromLTRB(10.w, 5.h, 5.w, 0.h),
                      child:Lottie.asset('assets/packages/lottie_flutter/vip-crown.json'),
                      ):Container(),
                  Container(
                      margin: EdgeInsets.fromLTRB(0.w, 5.h, 5.w, 0.h),
                      child:
                      Text(
                        user['info']['vip_name']+""+(user['info']['vip_expire_time']==null?"":"("+user['info']['vip_expire_time']+")"),
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w300,
                          fontSize: 25.sp,
                        ),
                      )),

                ],
              ),
              Row(
                children: <Widget>[
                   Tag(
                      color: Colors.black12,
                      borderColor: Colors.black12,
                      borderWidth: 0,
                      margin: EdgeInsets.fromLTRB(10.w, 10.h, 5.w, 0.h),
                      height: 40.h,
                      text: Text(
                        user['info']['native_place'].toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.sp,
                        ),
                      ),

                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(10.w, 5.h, 5.w, 0.h),
                      child:
                      Text(
                        user['info']['serve_user'] !="" ?"服务:":"",
                        style: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontWeight: FontWeight.w300,
                          fontSize: 25.sp,
                        ),
                      )),
                  Container(
                      margin: EdgeInsets.fromLTRB(10.w, 5.h, 5.w, 0.h),
                      child:
                      Text(
                        user['info']['serve_user'],
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 25.sp,
                        ),
                      )),

                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildLinkTo(BuildContext context, Map<String,dynamic> userdetail) {

    List<dynamic> imgList =userdetail['pics'];
    List<Widget> list = [];
    if (imgList.length > 0 && imgList !=null){
      imgList.map((e)  {
        if(e ==null ) return e;
        list.add( Column(
          children:<Widget> [
            Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(13.w, 25.h, 0.w, 10.h),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          children:<Widget> [
                            GestureDetector(
                                onTap: () {
                                  ImagePreview.preview(
                                    context,
                                    images: List.generate(1, (index) {
                                      return ImageOptions(
                                        url: e['file_url'],
                                        tag: e['file_url'],
                                      );
                                    }),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(2.w, 0.h, 2.w, 0.h),
                                  child: CachedNetworkImage(imageUrl: e['file_url'],
                                    width: 140.w,
                                    height: 240.h,
                                  ),
                                )
                            )

                          ],

                        ),

                      ],

                    ),
                    padding:  EdgeInsets.all(4.w),
                    decoration:const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),

                  Positioned(
                      top: 25.h,
                      right: 0.w,
                      child:
                      FeedbackWidget(
                        onPressed: () {
                          _deletePhoto(context,e,userdetail);
                        },
                        child: const Icon(
                          CupertinoIcons.delete_solid,
                          color: Colors.white,
                        ),
                      )
                  ),
                ]
            )
          ],
        ));
      }
      ).toList();
    }

     list.add(
         GestureDetector(
             child: Padding(
               padding:  EdgeInsets.only(left: 35.w),
               child: Container(
                   child:
                   Image.asset(
                       "assets/images/add.png",
                     width: 160.w,
                     height: 300.h,

                   )
               ),
             ),
             onTap: () async {
               //_getPermission(context);
               List<Asset> images = List<Asset>();
               List<Asset> resultList = List<Asset>();
               String error = 'No Error Dectected';
               //Navigator.of(ctx).pop();
               try {
                 resultList = await MultiImagePicker.pickImages(
                   // 选择图片的最大数量
                   maxImages: 1,
                   // 是否支持拍照
                   enableCamera: true,
                   materialOptions: MaterialOptions(
                     // 显示所有照片，值为 false 时显示相册
                       startInAllView: false,
                       allViewTitle: '所有照片',
                       actionBarColor: '#2196F3',
                       textOnNothingSelected: '没有选择照片'
                   ),
                 );
               } on Exception catch (e) {
                 e.toString();
               }
               if (!mounted) return;
               images = (resultList == null) ? [] : resultList;
               // 上传照片时一张一张上传
               for(int i = 0; i < images.length; i++) {
                 // 获取 ByteData

                 ByteData byteData = await images[i].getByteData(quality: 60);
                 try {
                   var resultConnectList= await IssuesApi.uploadPhoto("1",byteData,_loading);
                   // print(resultConnectList['data']);

                   var result= await IssuesApi.editCustomer(userdetail['info']['uuid'],"1",resultConnectList['data']);
                   if(result['code']==200){
                     BlocProvider.of<DetailBloc>(context).add(UploadImgSuccessEvent(userdetail,resultConnectList['data']));
                     _showToast(context,"上传成功",false);
                   }else{
                     _showToast(context,result['message'],false);
                   }
                 } on DioError catch(e){
                   var dd=e.response.data;
                   EasyLoading.showSuccess(dd['message']);
                   //_showToast(context,dd['message'],false);
                 }
                 EasyLoading.dismiss();
               }
             }
         )
     );

    return Wrap(
      children: [
        ...list
      ],
    );
  }
}
showPickerArray(BuildContext context,List<List<String >> pickerData,List<int > select,String type,Map<String , dynamic> info,String title,bool isIndex) {
   Picker(
      adapter: PickerDataAdapter<String>(pickerdata: pickerData, isArray: true),
      hideHeader: true,
      title: new Text("请选择"+title),
      cancelText: "取消",
      confirmText: "确定",
       selecteds:select,
     // columnPadding: EdgeInsets.only(top: 50.h,bottom: 50.h,left: 50.w,right: 50.w),
       selectedTextStyle: TextStyle(
         fontSize: 34.sp,
         color: Colors.redAccent,
       ),
      textStyle: TextStyle(
        fontSize: 28.sp,
        color: Colors.black,
      ),
      onConfirm: (Picker picker, List value) async {
        print(value.toString());
        print(picker.getSelectedValues());
        int values;
        if(isIndex){
          values = value.first;
        }else{
          values = int.parse(picker.getSelectedValues().first);
        }

        var result= await IssuesApi.editCustomerOnce(info['uuid'],type,values);
        if(result['code']==200){
          BlocProvider.of<DetailBloc>(context).add(EditDetailEvent(type,values));
          _showToast(context,"编辑成功",false);
        }else{

          _showToast(context,result['message'],false);
        }
      }
  ).showDialog(context);
}
_showToast(BuildContext ctx, String msg, bool collected) {
  if (msg ==null){
    msg="ti";
  }
  // Toasts.toast(
  //   ctx,
  //   msg,
  //   duration: Duration(milliseconds:  5000 ),
  //   action: collected
  //       ? SnackBarAction(
  //       textColor: Colors.white,
  //       label: '收藏夹管理',
  //       onPressed: () => Scaffold.of(ctx).openEndDrawer())
  //       : null,
  // );
  BotToast.showNotification(
    backgroundColor: Colors.white,
    leading: (cancel) => Container(
      child: IconButton(
        icon: Icon(Icons.error, color: Colors.redAccent),
        onPressed: cancel,
      )),
    title: (text)=>Container(
        child: Text(msg,style: new TextStyle(
        color: Colors.black, fontSize: 40.sp)),
      ),
    duration: const Duration(seconds: 5),

    trailing: (cancel) => Container(
      child: IconButton(
       icon: Icon(Icons.cancel),
      onPressed: cancel,
      ),
    ),
    onTap: () {
      BotToast.showText(text: 'Tap toast');
    },); //弹出简单通知Toast
}
showPickerDateTime(BuildContext context,String date,String type,Map<String ,dynamic> info) {
  String dates = "";
  if (date =="-"){
    dates ="1999-01-01 08:00:00";
  }else{
    dates=date;
  }
   Picker(
      adapter:  DateTimePickerAdapter(
        type: PickerDateTimeType.kYMDHM,
        isNumberMonth: true,
        //strAMPM: const["上午", "下午"],
        // yearSuffix: "年",
        // monthSuffix: "月",
        // daySuffix: "日",
        value: DateTime.parse(dates),
        maxValue: DateTime.now(),
        minuteInterval: 1,
        minHour: 0,
        maxHour: 23,
        // twoDigitYear: true,
      ),
      title: new Text("选择时间"),
       cancelText: "取消",
       confirmText: "确定",
       textAlign: TextAlign.center,
      selectedTextStyle: TextStyle(color: Colors.blue),
      delimiter: [
        PickerDelimiter(column: 4, child: Container(
          width: 16.0,
          alignment: Alignment.center,
          child: Text(':', style: TextStyle(fontWeight: FontWeight.bold)),
          color: Colors.white,
        ))
      ],
      footer: Container(
        height: 50.0,
        alignment: Alignment.center,
        child: Text(''),
      ),
      onConfirm: (Picker picker, List value) async {
        var result= await IssuesApi.editCustomerOnceString(info['uuid'],type,picker.adapter.text);
        if(result['code']==200){
          BlocProvider.of<DetailBloc>(context).add(EditDetailEventString(type,picker.adapter.text));
          _showToast(context,"编辑成功",false);
        }else{

          _showToast(context,result['message'],false);
        }
        print(picker.adapter.text);
      },
      onSelect: (Picker picker, int index, List<int> selecteds) {

         var stateText = picker.adapter.toString();

      }
  ).showDialog(context);
}

_showEditDialog(BuildContext context,String title,String hintText ,String text,String type,int maxLine,Map<String ,dynamic> info){

  TextEditingController _controller= TextEditingController.fromValue(TextEditingValue(
    text: '${text == null ? "" : text}',  //判断keyword是否为空
  ));
  showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Container(
            //elevation: 0.0,
            child: Column(
              children: <Widget>[
                //Text(text),
                TextField(
                  minLines: maxLine,
                  maxLines: maxLine,
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: hintText,

                    //filled: true,
                    //fillColor: Colors.white
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('取消'),
            ),
            Container(
              child: CupertinoDialogAction(
                onPressed: () async {

                  var result= await IssuesApi.editCustomerOnceString(info['uuid'],type,_controller.text);
                  if(result['code']==200){
                    BlocProvider.of<DetailBloc>(context).add(EditDetailEventString(type,_controller.text));
                    //_showToast(context,"编辑成功",false);
                  }else{

                    _showToast(context,result['message'],false);
                  }
                  Navigator.pop(context);


                },
                child: Text('确定'),
              ),
            ),
          ],
        );
      });
}
_getEduLevel(info) {

  try {
    return _EduLevel[info];
  } catch (e) {
    return "未知";
  }

}
_getWorkType(info) {


  try {
    return _WorkTypeLevel[info];
  } catch (e) {
    return "未知";
  }

}
_getWorkOverTime(info) {


  try {
    return _WorkOverTimeLevel[info];
  } catch (e) {
    return "未知";
  }

}
_getIncome(info) {

  try {
    return _IncomeLevel[info];
  } catch (e) {
    return "未知";
  }

}

_getHasHouse(info) {


  try {
    return _hasHouseLevel[info];
  } catch (e) {
    return "未知";
  }

}

_getHouseFuture(info) {


  try {
    return _houseFutureLevel[info];
  } catch (e) {
    return "未知";
  }

}

_getHasCar(info) {


  try {
    return _hasCarLevel[info];
  } catch (e) {
    return "未知";
  }

}
_getCarLevel(info) {


  try {
    return _carLevelLevel[info];
  } catch (e) {
    return "未知";
  }

}


_getMarriageLevel(info) {


  try {
    return _marriageLevel[info];
  } catch (e) {
    return "未知";
  }

}
_getChildLevel(info) {


  try {
    return _childLevel[info];
  } catch (e) {
    return "未知";
  }

}
_getOnlyChildLevel(info) {


  try {
    return _onlyChildLevel[info];
  } catch (e) {
    return "未知";
  }

}
_getParentLevel(info) {


  try {
    return _parentLevel[info];
  } catch (e) {
    return "未知";
  }

}
_getParentProtectLevel(info) {


  try {
    return _parentProtectLevel[info];
  } catch (e) {
    return "未知";
  }

}
_getFaithLevel(info) {


  try {
    return _faithLevel[info];
  } catch (e) {
    return "未知";
  }

}

_getSmokeLevel(info) {


  try {
    return _smokeLevel[info];
  } catch (e) {
    return "未知";
  }

}

_getDrinkLevel(info) {


  try {
    return _drinkLevel[info];
  } catch (e) {
    return "未知";
  }

}
_getLifeLevel(info) {


  try {
    return _lifeLevel[info];
  } catch (e) {
    return "未知";
  }

}

_getCreatLevel(info) {
  try {
    return _creatLevel[info];
  } catch (e) {
    return "未知";
  }

}

_getMarriageDateLevel(info) {


  try {
    return _marriageDateLevel[info];
  } catch (e) {
    return "未知";
  }

}
_getFloodLevel(info) {


  try {
    return _floodLevel[info];
  } catch (e) {
    return "未知";
  }

}

_getSexLevel(info) {


  try {
    return _sexLevel[info];
  } catch (e) {
    return "未知";
  }

}
_getNationLevel(info) {


  try {
    return _nationLevel[info];
  } catch (e) {
    return "未知";
  }

}
_getCompanyLevel(info) {


  try {
    return _companyTypeLevel[info];
  } catch (e) {
    return "未知";
  }

}
int _getIndexOfList(List<String> orc,String input) {
    var index =orc.indexOf(input);
    return index;
}
List<String> _getAgeList() {

  List<String> age =[] ;
  for (var i = 14; i < 99; i++) {
    age.add(i.toString()+" 岁");
  }
  return age;
}
List<String> _getWeightList() {

  List<String> weight =[] ;
  for (var i = 30; i < 200; i++) {
    weight.add(i.toString());
  }
  return weight;
}
List<String> _getHeightList() {

  List<String> height=[] ;
  for (var i = 100; i < 200; i++) {
    height.add(i.toString());
  }
  return height;
}


List<String> _nationLevel = [
  "未知","汉族","蒙古族","回族","藏族","维吾尔族","苗族","彝族","壮族","布依族","朝鲜族","满族","侗族","瑶族","白族","土家族",
  "哈尼族","哈萨克族","傣族","黎族","傈僳族","佤族","畲族","高山族","拉祜族","水族","东乡族","纳西族","景颇族","柯尔克孜族",
  "土族","达斡尔族","仫佬族","羌族","布朗族","撒拉族","毛南族","仡佬族","锡伯族","阿昌族","普米族","塔吉克族","怒族", "乌孜别克族",
  "俄罗斯族","鄂温克族","德昂族","保安族","裕固族","京族","塔塔尔族","独龙族","鄂伦春族","赫哲族","门巴族","珞巴族","基诺族"
];
List<String> _sexLevel = [
  "未知",
  "男生",
  "女生",
];
List<String> _floodLevel = [
  "未知",
  "A型",
  "B型",
  "O型",
  "AB型",


];
List<String> _EduLevel = [
  "未知",
  "高中及以下",
  "大专",
  "本科",
  "硕士",
  "博士及以上",
  "国外留学",
  "其他",

];
List<String> _WorkTypeLevel = [
  "未知",
  "企事业单位公务员",
  "教育医疗",
  "民营企业",
  "私营业主",
  "其他",

];
List<String> _companyTypeLevel = [
  "未知",
  "国企",
  "外商独资",
  "合资",
  "民营",
  "股份制企业",
  "上市公司",
  "国家机关",
  "事业单位",
  "银行",
  "医院",
  "学校",
  "律师事务所",
  "社会团体",
  "港澳台公司",
  "其他",
];
List<String> _WorkOverTimeLevel = [
  "未知",
  "不加班",
  "偶尔加班",
  "经常加班",

];
List<String> _IncomeLevel = [
  "未知",
  "5万及以下",
  "5-10万",
  "10-15万",
  "15-20万",
  "20-30万",
  "30-50万",
  "50-70万",
  "70-100万",
  "100万以上",
];
List<String> _hasHouseLevel = [
  "未知",
  "无房",
  "1套房",
  "2套房",
  "3套房及以上",
  "其他",
];
List<String> _houseFutureLevel = [
  "未知",
  "无房贷",
  "已还清",
  "在还贷",

];
List<String> _hasCarLevel = [
  "未知",
  "有车",
  "无车",
];
List<String> _carLevelLevel = [
  "未知",
  "无车产",
  "5-10万车",
  "10-20万车",
  "20-30万车",
  "30-50万车",
  "50万以上车",
];
List<String> _marriageLevel = [
  "未知",
  "未婚",
  "离异带孩",
  "离异单身",
  "离异未育",
  "丧偶",
];
List<String> _childLevel = [
  "未知",
  "有",
  "无",
];
List<String> _onlyChildLevel = [
  "未知",
  "是",
  "否",
];
List<String> _parentLevel = [
  "未知",
  "父母同在",
  "父歿母在",
  "父在母歿",
  "父母同歿",
];
List<String> _parentProtectLevel = [
  "未知",
  "父亲有医保",
  "母亲有医保",
  "父母均有医保",
];
List<String> _faithLevel = [
  "未知",
  "无信仰",
  "基督教",
  "天主教",
  "佛教",
  "道教",
  "伊斯兰教",
  "其他宗教",

];
List<String> _smokeLevel = [
  "未知",
  "不吸烟",
  "偶尔吸烟",
  "经常吸烟",
  "有戒烟计划",
];
List<String> _drinkLevel = [
  "未知",
  "不喝酒",
  "偶尔喝",
  "应酬喝",
  "经常喝",
  "有戒酒计划",
];
List<String> _lifeLevel = [
  "未知",
  "很规律",
  "经常熬夜",
];
List<String> _creatLevel = [
  "未知",
  "想要孩子",
  "可以考虑",
  "想要孩子",
];
List<String> _marriageDateLevel = [
  "未知",
  "半年内",
  "一年内",
  "2年内",
  "还没想好",
];



_loading(int a, int b){
                double _progress;
                _progress = 0;
                _progress = a / b;
                EasyLoading.showProgress(_progress, status: '${(_progress * 100).toStringAsFixed(0)}%');
                //_progress += 0.03;
                if (_progress >= 1) {
                  EasyLoading.dismiss();
                }
}


final _Controller = TextEditingController(text: '');
final _appointController = TextEditingController(text: '');
FocusNode _textFieldNode = FocusNode();
FocusNode _remarkFieldNode = FocusNode();
final _usernameController = TextEditingController(text: '');
FocusNode _textPlaceFieldNode = FocusNode();
final _placeController = TextEditingController(text: '');
List<String> goals = ["请选择","1.新分未联系",  "2.号码无效", "3.号码未接通",  "4.可继续沟通", "5.有意向面谈",  "6.确定到店时间", "7.已到店，意愿需跟进", "8.已到店，考虑7天付款",  "9.高级会员,支付预付款",  "10.高级会员，费用已结清", "11.毁单",  "12.放弃"];
String goalValue = '4.可继续沟通';
DateTime _date = new DateTime.now();
DateTime _date1= _date.add(new Duration(days: 3));
int connect_type=1;
var time1s=_date.toString();
var time2s=_date.add(new Duration(days: 3)).toString();
String time1=time1s.substring(0,19),time2=time2s.substring(0,19);

String other_uuid;
String appointment_time=_date.toString().substring(0,19);
String appointment_address;
String remark;
String address_lng;
String address_lat;
String customer_uuid;


_getStatusIndex(info) {

  try {
    return goals[info];
  } catch (e) {
    return "4.可继续沟通";
  }

}

_appoint(BuildContext context,Map<String,dynamic> detail) {



  showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
          builder: (context, state) {

            return  GestureDetector(
              onTap: (){
                _textPlaceFieldNode.unfocus();
                _textFieldNode.unfocus();
                _remarkFieldNode.unfocus();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 700.w,
                    height: 800.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    child: SingleChildScrollView(
                      //alignment: Alignment.bottomCenter,
                      //maxHeight: 700.h,
                      child: Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: <Widget>[
                          // Positioned(
                          //   top: 20.h,
                          //   child: Image.asset(
                          //     'assets/images/login_top.png',
                          //     width: 220.w,
                          //   ),
                          // ),

                          Positioned(
                            top: 30.h,
                            right: 30.h,
                            child: GestureDetector(
                              onTap: () {

                                goalValue = '1.新分未联系';
                                _date = new DateTime.now();
                                connect_type=1;
                                var time1s=_date.toString();
                                var time2s=_date.add(new Duration(days: 3)).toString();
                                time1=time1s.substring(0,19);
                                time2=time2s.substring(0,19);
                                _Controller.clear();
                                Navigator.of(context).pop();
                              } ,
                              child: Image.asset('assets/images/btn_close_black.png',
                                width: 40.w,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 30.w,
                              right: 30.w,
                              top: 0.h,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                SizedBox(
                                  height: 20.h,
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap:(){

                                        MyPicker.showPicker(
                                            context: context,
                                            current: _date,
                                            mode: MyPickerMode.dateTime,
                                            onConfirm: (v){
                                              //_change('yyyy-MM-dd HH:mm'),
                                              print(v);
                                              state(() {
                                                _date=v;
                                                appointment_time = v.toString().substring(0,19);
                                              });
                                            }
                                        );

                                      },
                                      child: Row(
                                        children: [
                                          Text("排约时间",style: TextStyle(
                                              fontSize: 30.sp, color: Colors.grey)),
                                          Icon(Icons.keyboard_arrow_down_outlined),
                                        ],
                                      ),
                                    ),


                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap:(){



                                      },
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Text(appointment_time,style: TextStyle(
                                                fontSize: 40.sp, color: Colors.redAccent,fontWeight:FontWeight.w800 )),

                                          ],
                                        ),
                                      ),
                                    ),


                                  ],
                                ),

                                SizedBox(
                                  height: 10.w,
                                ),

                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                           height:100.h,
                                        child: TextField(
                                            focusNode:_textFieldNode ,
                                            autofocus: false,
                                            style: TextStyle(color: Colors.black, fontSize: 28.sp),
                                            //scrollPadding:   EdgeInsets.only(top: 10.h, left: 35.w, bottom: 5.h),
                                            controller: _usernameController,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                                labelText: "排约对象",
                                                labelStyle: TextStyle(color: Colors.blue),
                                                hintText: "请选择>>>",
                                                enabledBorder: const OutlineInputBorder(
                                                  borderSide:
                                                  const BorderSide(color: Colors.blue, width: 1),
                                                ),
                                                border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(5.0)
                                                )
                                            )
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.w,
                                    ),

                              Container(
                                height:70.h,
                                padding:  EdgeInsets.only(top: 0.h, left: 15.w, bottom: 0.h),
                                child:OutlineButton(
                                  onPressed: (){

                                    Navigator.pushNamed(context, UnitRouter.search_page_appoint).then((value) {
                                      List<String> data = value.toString().split("#");
                                      other_uuid =data.elementAt(0);
                                      _usernameController .text=data.elementAt(1);
                                      _textPlaceFieldNode.unfocus();
                                      _textFieldNode.unfocus();


                                    });

                                  },
                                  child: Text("搜索用户"),
                                  textColor: Colors.blue,
                                  splashColor: Colors.green,
                                  highlightColor: Colors.black,
                                  shape: BeveledRectangleBorder(
                                    side: BorderSide(
                                      color: Colors.red,
                                      width: 2.w,
                                    ),
                                    borderRadius: BorderRadius.circular(10.w),
                                  ),
                                ),
                              )


                                  ],
                                ),
                                SizedBox(
                                  height: 10.w,
                                ),

                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height:100.h,
                                        child: TextField(
                                            focusNode:_textPlaceFieldNode ,
                                            autofocus: false,
                                            style: TextStyle(color: Colors.black, fontSize: 28.sp),
                                            controller: _placeController,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                                labelText: "排约地点",
                                                labelStyle: TextStyle(color: Colors.blue),
                                                hintText: "请选择>>>",
                                                enabledBorder: const OutlineInputBorder(
                                                  borderSide:
                                                  const BorderSide(color: Colors.blue, width: 1),
                                                ),
                                                border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(5.0)
                                                )
                                            )
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.w,
                                    ),

                                    Container(
                                      height:70.h,
                                      padding:  EdgeInsets.only(top: 0.h, left: 15.w, bottom: 0.h),
                                      child:OutlineButton(
                                        onPressed: (){
                                          Navigator.pushNamed(context, UnitRouter.baidu_map).then((value) {
                                             List<String> data = value.toString().split("#");
                                              appointment_address =data.elementAt(0)+"-"+data.elementAt(1)+"";
                                              address_lng=data.elementAt(2);
                                              address_lat=data.elementAt(3);
                                             _placeController.text=appointment_address;
                                          });
                                        },
                                        child: Text("搜索地点"),
                                        textColor: Colors.blue,
                                        splashColor: Colors.green,
                                        highlightColor: Colors.black,
                                        shape: BeveledRectangleBorder(
                                          side: BorderSide(
                                            color: Colors.red,
                                            width: 2.w,
                                          ),
                                          borderRadius: BorderRadius.circular(10.w),
                                        ),
                                      ),
                                    )


                                  ],
                                ),
                                SizedBox(
                                  height: 10.w,
                                ),


                                SizedBox(
                                  height: 20.w,
                                ),
                                Container(
                                  width:300.w,
                                  child: TextField(
                                    controller: _appointController,
                                    focusNode: _remarkFieldNode,
                                    style: TextStyle(color: Colors.black),
                                    minLines: 7,
                                    maxLines: 7,
                                    cursorColor: Colors.green,
                                    cursorRadius: Radius.circular(3.w),
                                    cursorWidth: 5.w,
                                    showCursor: true,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10.w),
                                      hintText: "请输入...",
                                      border: OutlineInputBorder(),
                                    ),
                                    onChanged: (v){},
                                  )
                                  ,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 20.h, bottom: 5.h),
                                  child: RaisedButton(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(20))),
                                    color: Colors.lightBlue,
                                    onPressed: (){
                                      customer_uuid = detail['uuid'];
                                      if (_usernameController.text.isEmpty){
                                        BotToast.showSimpleNotification(title: "请选择排约用户");
                                        return;
                                      }
                                      if (_placeController.text.isEmpty){
                                        BotToast.showSimpleNotification(title: "请选择排约地点");
                                        return;
                                      }
                                      if (_appointController.text.isEmpty){
                                        BotToast.showSimpleNotification(title: "请输入约会记录");
                                        return;
                                      }
                                      if (other_uuid==""){
                                        BotToast.showSimpleNotification(title: "请选择排约用户");
                                        return;
                                      }
                                      if (appointment_time==""){
                                        BotToast.showSimpleNotification(title: "请选择排约时间");
                                        return;
                                      }
                                      if (appointment_address ==""){
                                        BotToast.showSimpleNotification(title: "请选择排约地点");
                                        return;
                                      }
                                      if (address_lng==""){
                                        BotToast.showSimpleNotification(title: "请选择排约地点");
                                        return;
                                      }
                                      if (address_lat==""){
                                        BotToast.showSimpleNotification(title: "请选择排约地点");
                                        return;
                                      }
                                      remark= _appointController.text;
                                      if(other_uuid !=null)
                                      BlocProvider.of<DetailBloc>(context).add(AddAppointEvent(detail,other_uuid,appointment_time,appointment_address,remark,address_lng,address_lat,_usernameController.text));
                                      _usernameController.clear();
                                      _placeController.clear();
                                      _appointController.clear();
                                      other_uuid="";

                                      appointment_time="";

                                      appointment_address ="";

                                      address_lng="";

                                      address_lat="";
                                      appointment_time=_date.toString().substring(0,19);

                                      Navigator.of(context).pop();
                                    },
                                    child: Text("提交",
                                        style: TextStyle(color: Colors.white, fontSize: 18)),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            );


          })
  );
}
_comment(BuildContext context,int connectStatus,Map<String,dynamic> detail) {

  goalValue=_getStatusIndex(connectStatus);

  showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
          builder: (context, state) {

           return  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 700.w,
                  height: 800.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  child: SingleChildScrollView(
                    //alignment: Alignment.bottomCenter,
                    //maxHeight: 700.h,
                    child: Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: <Widget>[
                        // Positioned(
                        //   top: 20.h,
                        //   child: Image.asset(
                        //     'assets/images/login_top.png',
                        //     width: 220.w,
                        //   ),
                        // ),

                        Positioned(
                          top: 30.h,
                          right: 30.h,
                          child: GestureDetector(
                            onTap: () {

                               goalValue = '1.新分未联系';
                               _date = new DateTime.now();
                               connect_type=1;
                               var time1s=_date.toString();
                               var time2s=_date.add(new Duration(days: 3)).toString();
                                time1=time1s.substring(0,19);
                                time2=time2s.substring(0,19);
                               _Controller.clear();
                              Navigator.of(context).pop();
                            } ,
                            child: Image.asset('assets/images/btn_close_black.png',
                              width: 40.w,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 30.w,
                            right: 30.w,
                            top: 0.h,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              SizedBox(
                                height: 0.h,
                              ),

                              Row(
                                children: [
                                  Text("沟通方式: ",style: TextStyle(
                                  fontSize: 28.sp, color: Colors.grey)),
                                  Text("电话",style: TextStyle(
                                      fontSize: 28.sp, color: Colors.black)),
                                  Radio(
                                    activeColor: Colors.deepOrangeAccent,
                                    ///此单选框绑定的值 必选参数
                                    value: 1,
                                    ///当前组中这选定的值  必选参数
                                    groupValue: connect_type,
                                    ///点击状态改变时的回调 必选参数
                                    onChanged: (v) {
                                      state(() {
                                        connect_type = v;
                                      });
                                    },
                                  ),
                                  Text("到店",style: TextStyle(
                                      fontSize: 28.sp, color: Colors.black)),
                                  Radio(
                                    activeColor: Colors.deepOrangeAccent,
                                    ///此单选框绑定的值 必选参数
                                    value: 2,
                                    ///当前组中这选定的值  必选参数
                                    groupValue: connect_type,
                                    ///点击状态改变时的回调 必选参数
                                    onChanged: (v) {
                                      state(() {
                                        connect_type = v;
                                      });
                                    },
                                  ),
                                ],
                              ),

                              SingleChildScrollView(
                                //设置水平方向排列
                                  scrollDirection: Axis.horizontal,
                                  child:Row(
                                children: [
                                  Text("沟通状态: ",style: TextStyle(
                                      fontSize: 14, color: Colors.grey)),
                                  Padding(
                                    padding:
                                    EdgeInsets.only(left: 0.w),
                                    child: Container(
                                      width: 393.w,
                                      child: DropdownButton<String>(
                                        value: goalValue,
                                        icon:
                                        Icon(Icons.keyboard_arrow_down_outlined),
                                        iconSize: 30.sp,
                                        elevation: 4,
                                        underline: Container(
                                          height: 3.h,
                                          color: Colors.redAccent,
                                        ),
                                        onChanged: (String newValue) {
                                          state(() {
                                            goalValue = newValue;
                                          connectStatus=  _getIndexOfList(goals,newValue);
                                          });
                                        },
                                        items: goals
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                    style: TextStyle(
                                                fontSize: 32.sp, color: Colors.black)
                                                ),
                                              );
                                            }).toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap:(){

                                      MyPicker.showPicker(
                                        context: context,
                                        current: _date,
                                        mode: MyPickerMode.dateTime,
                                          onConfirm: (v){
                                          //_change('yyyy-MM-dd HH:mm'),
                                          print(v);
                                          state(() {
                                            _date=v;
                                            time1 = v.toString().substring(0,19);
                                          });
                                        }
                                      );

                                    },
                                    child: Row(
                                      children: [
                                        Text("沟通时间",style: TextStyle(
                                            fontSize: 30.sp, color: Colors.grey)),
                                        Icon(Icons.keyboard_arrow_down_outlined),
                                      ],
                                    ),
                                  ),

                                  GestureDetector(
                                    onTap:(){

                                      MyPicker.showPicker(
                                          context: context,
                                          current: _date1,
                                          mode: MyPickerMode.dateTime,
                                          onConfirm: (v){
                                            //_change('yyyy-MM-dd HH:mm'),
                                            print(v);
                                            state(() {
                                              _date1=v;
                                              time2 = v.toString().substring(0,19);
                                            });
                                          }
                                      );

                                    },
                                    child: Row(
                                      children: [
                                        Text("下次沟通时间 ",style: TextStyle(
                                            fontSize: 30.sp, color: Colors.grey)),
                                        Icon(Icons.keyboard_arrow_down_outlined),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                              SizedBox(
                                height: 10.w,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap:(){



                                    },
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Text(time1,style: TextStyle(
                                              fontSize: 28.sp, color: Colors.redAccent,fontWeight:FontWeight.w800 )),

                                        ],
                                      ),
                                    ),
                                  ),

                                  GestureDetector(
                                    onTap:(){



                                    },
                                    child: Row(
                                      children: [
                                        Text(time2,style: TextStyle(
                                            fontSize: 28.sp, color: Colors.redAccent,fontWeight:FontWeight.w800)),

                                      ],
                                    ),
                                  ),

                                ],
                              ),

                              SizedBox(
                                height: 20.w,
                              ),
                              Container(
                                width:300.w,
                                child: TextField(
                                  controller: _Controller,
                                  style: TextStyle(color: Colors.black),
                                  minLines: 7,
                                  maxLines: 7,
                                  cursorColor: Colors.green,
                                  cursorRadius: Radius.circular(3.w),
                                  cursorWidth: 5.w,
                                  showCursor: true,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10.w),
                                    hintText: "请输入...",
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (v){},
                                )
                                ,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20.h, bottom: 5.h),
                                child: RaisedButton(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20))),
                                  color: Colors.lightBlue,
                                  onPressed: (){
                                    if (_Controller.text.isEmpty){
                                      return;
                                    }
                                    if (time1==""){
                                      return;
                                    }
                                    if (time2==""){
                                      return;
                                    }


                                    if (detail != null)
                                    BlocProvider.of<DetailBloc>(context).add(AddConnectEvent(detail,_Controller.text,connectStatus,time1,connect_type,time2));
                                    goalValue = '1.新分未联系';
                                    _date = new DateTime.now();
                                    connect_type=1;
                                    time1="";
                                    time2="";
                                    _date = new DateTime.now();
                                    connect_type=1;
                                    var time1s=_date.toString();
                                    var time2s=_date.add(new Duration(days: 3)).toString();
                                    time1=time1s.substring(0,19);
                                    time2=time2s.substring(0,19);
                                    _Controller.clear();
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("提交",
                                      style: TextStyle(color: Colors.white, fontSize: 18)),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 20.h,
                ),
              ],
            );


          })
  );
}

_showBottom(BuildContext context,String text,String status,String type){
  showFLBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ScrollConfiguration(
            behavior: DyBehaviorNull(),
        child:FLCupertinoActionSheet(
          child: Container(
            color: Colors.white,
            constraints: BoxConstraints(
              minHeight: 450.h,
              // minWidth: double.infinity, // //宽度尽可能大
            ),
            padding:  EdgeInsets.only(left: 25.w, right: 25.w,top: 25.h,bottom: 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Opacity(
                      opacity:  0.2,
                      child: Container(
                      child: Text(
                      "沟通方式:" + (type=="1"?"电话":"到店"),
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 24.sp,color:type=="2"?Colors.redAccent:Colors.green,fontWeight: FontWeight.w300),
                      ),
                    )),

                    Opacity(
                      opacity: 0.2 ,
                      child: Container(
                      child: Text(
                        "沟通状态:" +status,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 24.sp,color:Colors.black54,fontWeight: FontWeight.w300),
                      ),
                    )),

                  ],
                ),
              SizedBox(height: 10.h,),
                Container(
                  child: Text(
                    text,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 32.sp,fontWeight: FontWeight.w900),
                  ),
                )
              ],
            ),
          ),
          cancelButton: CupertinoActionSheetAction(
            child: const Text('关闭'),
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context, 'Cancel');
            },
          ),
        ));
      }).then((value) {
    //print(value);
  });
}
_showAppointBottom(BuildContext context,String userName,String otherName,String time,String address,String remark,String feedback){
  showFLBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ScrollConfiguration(
            behavior: DyBehaviorNull(),
            child:FLCupertinoActionSheet(
              child: Container(
                color: Colors.white,
                constraints: BoxConstraints(
                  minHeight: 450.h,
                  // minWidth: double.infinity, // //宽度尽可能大
                ),
                padding:  EdgeInsets.only(left: 25.w, right: 25.w,top: 25.h,bottom: 20.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      child: Text(
                        "服务红娘:" + userName,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 28.sp,color:Colors.black,fontWeight: FontWeight.w800),
                      ),
                    ),
                    SizedBox(height: 10.h,),

                    Container(
                      child: Text(
                        "约会对象:" + otherName,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 28.sp,color:Colors.black,fontWeight: FontWeight.w800),
                      ),
                    ),
                    SizedBox(height: 10.h,),

                    Container(
                      child: Text(
                        "约会时间:" + time,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 28.sp,color:Colors.black,fontWeight: FontWeight.w800),
                      ),
                    ),
                    SizedBox(height: 10.h,),

                    Container(
                      child: Text(
                        "约会地点:" + address,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 28.sp,color:Colors.black,fontWeight: FontWeight.w800),
                      ),
                    ),
                    SizedBox(height: 10.h,),

                    Container(
                      child: Text(
                        "约会备注:" + remark,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 28.sp,color:Colors.black,fontWeight: FontWeight.w800),
                      ),
                    ),

                    Container(
                      child: Text(
                        "回访记录:" + (feedback == null || feedback == "null"?"":feedback),
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 28.sp,color:Colors.black,fontWeight: FontWeight.w800),
                      ),
                    ),
                  ],
                ),
              ),
              cancelButton: CupertinoActionSheetAction(
                child: const Text('关闭'),
                isDefaultAction: true,
                onPressed: () {
                  Navigator.pop(context, 'Cancel');
                },
              ),
            ));
      }).then((value) {
    //print(value);
  });
}
_deletePhoto(BuildContext context,Map<String,dynamic> img,Map<String,dynamic> detail) {
  showDialog(
      context: context,
      builder: (ctx) => Dialog(
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Container(
          width: 50,
          child: DeleteCategoryDialog(
            title: '删除图片',
            content: '是否确定继续执行?',
            onSubmit: () {
              BlocProvider.of<DetailBloc>(context).add(EventDelDetailImg(img,detail['info']));
              Navigator.of(context).pop();
            },
          ),
        ),
      ));
}
class WidgetDetailTitle extends StatelessWidget {
  final Map<String,dynamic> usertail;
  WidgetDetailTitle({this.usertail});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            _buildLeft(usertail),
            _buildRight(usertail),
          ],
        ),
        Divider(),
      ],
    ));
  }

  final List<int> colors = Cons.tabColors;

  Widget _buildLeft(Map<String,dynamic> usertail) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20),
              child: Text(
                "用户名："  + usertail['user']['userName'],
                style: TextStyle(
                    fontSize: 20.sp,
                    color: Color(0xff1EBBFD),
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Panel(child: Text(
                   "性别："  + (usertail['user']['sex'].toString()=="1"?"男":"女")+
                   " 年龄："  + usertail['user']['age'].toString()+
                   " 手机号："  + usertail['user']['tel'].toString()+
                   " 颜值："  + usertail['user']['facescore'].toString()
              )),
            )
          ],
        ),
      );

  Widget _buildRight(Map<String,dynamic> usertail) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  //tag: "hero_widget_image_${usertail['user']['memberId'].toString()}",
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      child: Image(image: FadeInImage.assetNetwork(
                        placeholder:'assets/images/ic_launcher.png',
                        image:usertail['user']['img'],
                      ).image))),
            ),
          ),
          StarScore(
            score: 0,
            star: Star(size: 15, fillColor: Colors.blue),
          )
        ],
      );

}
