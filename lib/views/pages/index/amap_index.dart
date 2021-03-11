// import 'package:amap_map_fluttify/amap_map_fluttify.dart';
// import 'package:bot_toast/bot_toast.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// class SelectLocationFromMapPage extends StatefulWidget {
//   @override
//   _SelectLocationFromMapPageState createState() =>
//       _SelectLocationFromMapPageState();
// }
//
// class _SelectLocationFromMapPageState extends State<SelectLocationFromMapPage> {
//   AmapController _controller;
//   List<Poi> poiList;
//   static List<PoiModel> list = new List();
//   static List<PoiModel> searchlist = new List();
//   PoiModel poiModel;
//   String keyword = "";
//   String address = "";
//   bool isloading = true;
//   bool isFirst =false;
//   String returnAddress ="";
//   MyLocationOption locationOption =MyLocationOption(show: true);
//   @override
//   void initState() {
//     super.initState();
//   }
//  @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     //_controller.dispose();
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//         data: ThemeData(
//         appBarTheme: AppBarTheme.of(context).copyWith(
//       brightness: Brightness.light,
//     ),
//     ),
//     child:Scaffold(
//       resizeToAvoidBottomPadding: false, //防止底部布局被顶起
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         title: Text(
//         '选择位置信息',
//         //style: CustomTextStyle.appBarTitleTextStyle,
//         style: TextStyle(color: Colors.black, fontSize: 40.sp,fontWeight: FontWeight.bold)
//         ),
//         elevation: 0.0,
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         actions:<Widget> [
//
//         Container(
//           margin: EdgeInsets.only(right: 10.w),
//           child: IconButton(
//           icon: Icon(Icons.add_location_alt),
//           onPressed: () {
//             if (returnAddress ==""){
//               BotToast.showSimpleNotification(title: returnAddress);
//             }
//             Navigator.pop(context,returnAddress);
//           },
//           color: Colors.deepOrange,
//           splashColor:Colors.grey,
//           highlightColor:Colors.blue[300],
//           tooltip:'确认选择',
//           ),
//         ),
//       SizedBox(
//             width: 10.w,
//           )
//         ],
//       ),
//
//       body: Column(
//         children: <Widget>[
//             //data: new ThemeData(
//               //  primaryColor: Colors.transparent, hintColor: Colors.transparent),
//             Container(
//              // color: Colors.transparent,
//               padding: EdgeInsets.all(5.w),
//               child: Container(
//                 height: 72.h,
//                 margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h),
//                 child: TextField(
//                   style: TextStyle(fontSize: 32.sp, letterSpacing: 2.w),
//                   controller: TextEditingController.fromValue(TextEditingValue(
//                     // 设置内容
//                     text: keyword,
//                     selection: TextSelection.fromPosition(TextPosition(
//                         affinity: TextAffinity.downstream,
//                         offset: keyword?.length ?? 0)),
//                     // 保持光标在最后
//                   )),
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(40.w)),
//                     ),
//                     hintText: '输入关键字',
//                     hintStyle:
//                     TextStyle(color: Color(0xFFBEBEBE), fontSize: 30.sp),
//                     contentPadding:
//                      EdgeInsets.symmetric(vertical: 8.h, horizontal: 1.w),
//                     prefixIcon: Icon(
//                       Icons.search,
//                       color: Colors.grey,
//                       size: 50.sp,
//                     ),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         Icons.clear,
//                         color: Colors.grey,
//                         size: 40.sp,
//                       ),
//                       onPressed: () {
//                         keyword = "";
//                         setState(() {});
//                       },
//                     ),
//                     fillColor: Colors.white,
//                     filled: true,
//                   ),
//
//                   inputFormatters: [],
//                   //内容改变的回调
//                   onChanged: (text) {
//                     print('change $text');
//                     keyword = text;
//                   },
//                   //内容提交(按回车)的回调
//                   onSubmitted: (text) {
//                     print('submit $text');
//                     // 触发关闭弹出来的键盘。
//                     keyword = text;
//                     setState(() {
//                       isloading = true;
//                       FocusScope.of(context).requestFocus(FocusNode());
//                     });
//
//                     searchAroundAddress(text.toString());
//                   },
//                   //按回车时调用
//                   onEditingComplete: () {
//                     print('onEditingComplete');
//                   },
//                 ),
//               ),
//             ),
//
//           Container(
//             height: 600.h,
//             child: Stack(
//               children: <Widget>[
//                 AmapView(
//                   showZoomControl: false,
//                   centerCoordinate: LatLng(35, 121),
//                   maskDelay: Duration(milliseconds: 500),
//                   zoomLevel: 16,
//                   onMapCreated: (controller) async {
//                     _controller = controller;
//                     if (await requestPermission()) {
//                         await controller.showMyLocation(locationOption);
//                       //Future.delayed(Duration(milliseconds: 500)).then((e) async {
//                         await controller?.showLocateControl(true);
//                         final latLng = await _controller?.getLocation();
//                         await enableFluttifyLog(false); // 关闭log
//                         isFirst =false;
//                         _loadData(latLng);
//                      // });
//                     }
//                   },
//                   onMapMoveEnd: (MapMove move) async {
//                   _loadData(move.latLng);
//                 },
//                 ),
//                 Center(
//                   child: Icon(
//                     Icons.location_on,
//                     size: 72.sp,
//                     color: Color(0xFFFF0000),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Visibility(
//               visible: !isloading,
//               maintainSize: false,
//               maintainSemantics: false,
//               maintainInteractivity: false,
//               replacement: PageLoading(),
//               child: ListView.builder(
//                   itemCount: list.length,
//                   itemBuilder: (BuildContext context, int position) {
//                     print("itemBuilder" + list.length.toString());
//                     PoiModel item = list[position];
//                     return Stack(
//                       children: [
//
//                         Container(
//                           margin:
//                           EdgeInsets.only(top: 25.h, bottom: 0.h, right: 18.w),
//                           alignment: Alignment.centerRight,
//                           child:   Icon(
//                             Icons.done,
//                             size: 60.sp,
//                             color: item.select == true
//                                 ? Colors.green
//                                 : Colors.transparent,
//                           ),
//                         ),
//                         InkWell(
//                           child: Container(
//                             //color: item.select==true ?Colors.black12:Colors.white,
//                             child: Column(
//                               children: <Widget>[
//                                 Container(
//                                   margin:
//                                   EdgeInsets.only(top: 15.h, bottom: 5.h, left: 15.w),
//                                   child: Row(
//                                     children: <Widget>[
//                                       Icon(
//                                         Icons.place,
//                                         size: 40.sp,
//                                         color: position == 0
//                                             ? Colors.green
//                                             : Colors.grey,
//                                       ),
//                                       Text(item.title,
//                                           style: TextStyle(
//                                               fontSize: 32.sp,
//                                               color: position == 0
//                                                   ? Colors.green
//                                                   : Color(0xFF787878)))
//                                     ],
//                                   ),
//                                 ),
//                                 Row(
//                                   children: [
//                                     Container(
//                                       margin:
//                                       EdgeInsets.only(top: 5.h, bottom: 5.h, left: 18.sp),
//                                       alignment: Alignment.centerLeft,
//                                       child: Text(
//                                         item.address,
//                                         style: TextStyle(
//                                           fontSize: 26.sp,
//                                           color: Color(0xFF646464),
//                                         ),
//                                       ),
//                                     ),
//
//                                   ],
//                                 ),
//                                 Divider(
//                                   height: 1.h,
//                                 ),
//
//                               ],
//                             ),
//                           ),
//                           onTap: () async {
//
//                             setState(() {
//                               list=   list.map((e) {
//                                 if (e.latLng == item.latLng){
//                                   e.select =true;
//                                   returnAddress = item.title+"#"+item.address+"#"+item.latLng.longitude.toString()+"#"+item.latLng.latitude.toString();
//                                   return e;
//                                 } else{
//                                   e.select =false;
//                                   return e;
//                                 }
//                               }).toList();
//
//
//
//                             });
//
//                           },
//                         ),
//                       ],
//                     );
//                   }),
//             ),
//           ),
//         ],
//       ),
//     ));
//   }
//
//   void _loadData(LatLng latLng) async {
//
//     if (isFirst ==true){
//      // return;
//     }
//     if (mounted) {
//       setState(() {
//         isloading = true;
//       });
//     }
//
//
//     /// 逆地理编码（坐标转地址）
//     ReGeocode reGeocodeList = await AmapSearch.instance.searchReGeocode(
//       latLng,
//     );
//
//     //print(await reGeocodeList.toString());
//     address = await reGeocodeList.formatAddress;
//    if(address ==""){
//      address ="江苏省苏州市姑苏区吴门桥街道吴中大厦";
//    }
//
//     final poiList = await AmapSearch.instance.searchKeyword(
//       address.toString(),
//       city: "苏州",
//     );
//     //final poiList =new List();
//     poiModel = new PoiModel("当前位置", address, latLng,false);
//     list.clear();
//     list.add(poiModel);
//     for (var poi in poiList) {
//       String title = await poi.title;
//       String cityName = await poi.cityName;
//       String provinceName = await poi.provinceName;
//       String address = await poi.address;
//       LatLng latLng = await poi.latLng;
//
//       list.add(new PoiModel(
//           title.toString(),
//           provinceName.toString() + cityName.toString() + address.toString(),
//           latLng,false));
//     }
//     if (mounted) {
//       setState(() {
//         isloading = false;
//       });
//     }
//     isFirst =true;
//   }
//   /// 动态申请定位权限
//   Future<bool> requestPermission() async {
//     // 申请权限
//     bool hasLocationPermission = await requestLocationPermission();
//     if (hasLocationPermission) {
//       print("定位权限申请通过");
//     } else {
//       print("定位权限申请不通过");
//     }
//     return true;
//   }
//   /// 申请定位权限
//   /// 授予定位权限返回true， 否则返回false
//   Future<bool> requestLocationPermission() async {
//     //获取当前的权限
//     var status = await Permission.location.status;
//     if (status == PermissionStatus.granted) {
//       //已经授权
//       return true;
//     } else {
//       //未授权则发起一次申请
//       status = await Permission.location.request();
//       if (status == PermissionStatus.granted) {
//         return true;
//       } else {
//         return false;
//       }
//     }
//   }
//   void searchAroundAddress(String text) async {
//     final poiList = await AmapSearch.instance.searchKeyword(
//       text,
//       city: "苏州",
//     );
//
//     list.clear();
//     list.add(poiModel);
//     for (var poi in poiList) {
//       String title = await poi.title;
//       LatLng latLng = await poi.latLng;
//       String cityName = await poi.cityName;
//       String provinceName = await poi.provinceName;
//       String address = await poi.address;
//       list.add(new PoiModel(
//           title.toString(),
//           provinceName.toString() + cityName.toString() + address.toString(),
//           latLng,false));
//     }
//     setState(() {
//       isloading = false;
//       FocusScope.of(context).requestFocus(FocusNode());
//     });
//   }
// }
//
// class PoiModel {
//   LatLng latLng;
//   String title;
//   String address;
//   bool select;
//   PoiModel(this.title, this.address, this.latLng,this.select);
// }
// class PageLoading extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           CupertinoActivityIndicator(),
// //          Text(‘  正在加载‘, style: TextStyle(fontSize: 16.0),),
//         ],
//       ),
//     );
//   }
// }