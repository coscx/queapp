// import 'dart:io' show Platform;
// import 'package:flutter/material.dart';
// import 'package:flutter_bmfbase/BaiduMap/bmfmap_base.dart';
// import 'package:flutter_bmfmap/BaiduMap/bmfmap_map.dart';
// import 'package:flutter_geen/views/pages/index/map_base_page_state.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// class BaiduMap extends StatefulWidget {
//   @override
//   _BaiduMapState createState() => _BaiduMapState();
// }
//
// class _BaiduMapState extends BMFBaseMapState<BaiduMap> {
//   BMFCoordinate _coordinate;
//   BMFMapPoi _mapPoi;
//   String _touchPointStr = '触摸点';
//
//   @override
//   void onBMFMapCreated(BMFMapController controller) {
//     super.onBMFMapCreated(controller);
//
//     /// 点中底图标注后会回调此接口
//     myMapController?.setMapOnClickedMapPoiCallback(
//         callback: (BMFMapPoi mapPoi) {
//           print('点中底图标注后会回调此接口poi=${mapPoi?.toMap()}');
//           setState(() {
//             _mapPoi = mapPoi;
//             _touchPointStr = '标注触摸点';
//           });
//         });
//
//     /// 点中底图空白处会回调此接口
//     myMapController?.setMapOnClickedMapBlankCallback(
//         callback: (BMFCoordinate coordinate) {
//           print('点中底图空白处会回调此接口coord=${coordinate?.toMap()}');
//           setState(() {
//             _coordinate = coordinate;
//             _mapPoi = null;
//             _touchPointStr = '空白触摸点';
//           });
//         });
//
//     /// 双击地图时会回调此接口
//     myMapController?.setMapOnDoubleClickCallback(
//         callback: (BMFCoordinate coordinate) {
//           print('双击地图时会回调此接口coord=${coordinate?.toMap()}');
//           setState(() {
//             _coordinate = coordinate;
//             _mapPoi = null;
//             _touchPointStr = '双击触摸点';
//           });
//         });
//
//     /// 长按地图时会回调此接口
//     myMapController?.setMapOnLongClickCallback(
//         callback: (BMFCoordinate coordinate) {
//           setState(() {
//             _coordinate = coordinate;
//             _mapPoi = null;
//             _touchPointStr = '长按触摸点';
//           });
//           print('长按地图时会回调此接口coord=${coordinate?.toMap()}');
//         });
//
//     /// 3DTouch 按地图时会回调此接口
//     ///（仅在支持3D Touch，且fouchTouchEnabled属性为true时，会回调此接口）
//     /// coordinate 触摸点的经纬度
//     /// force 触摸该点的力度(参考UITouch的force属性)
//     /// maximumPossibleForce 当前输入机制下的最大可能力度(参考UITouch的maximumPossibleForce属性)
//     myMapController?.setMapOnForceTouchCallback(callback:
//         (BMFCoordinate coordinate, double force, double maximumPossibleForce) {
//       setState(() {
//         _coordinate = coordinate;
//         _mapPoi = null;
//         _touchPointStr = '3D触摸点';
//       });
//       print(
//           '3DTouch 按地图时会回调此接口\ncoord=${coordinate
//               ?.toMap()}\nforce=$force\nmaximumPossibleForce=$maximumPossibleForce');
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     return MaterialApp(
//         home: Theme(
//         data: ThemeData(
//         appBarTheme: AppBarTheme.of(context).copyWith(
//       brightness: Brightness.light,
//     ),
//     ),
//     child:Scaffold(
//           appBar:  AppBar(
//             titleSpacing:60.w,
//             leadingWidth: 0,
//             title:  Text('消息',style: TextStyle(color: Colors.black, fontSize: 50.sp,fontWeight: FontWeight.bold)),
//             //leading:const Text('Demo',style: TextStyle(color: Colors.black, fontSize: 15)),
//             backgroundColor: Colors.white,
//             elevation: 0, //去掉Appbar底部阴影
//             actions:<Widget> [
//
//               Container(
//                 margin: EdgeInsets.fromLTRB(0.w,10.h,0.w,0.h),
//                 height: 20.h,
//                 width: 20.w,
//                 child: IconButton(
//                   padding: EdgeInsets.zero,
//                   icon: Icon(
//                     Icons.add_circle_outline,
//                     size: 48.sp,
//                     color: Colors.black,
//                   ),
//                   onPressed: null,
//                 ),
//               ),
//               SizedBox(
//                 width: 80.w,
//               )
//             ],
//           ),
//           body: Stack(children: <Widget>[generateMap(), generateControlBar()]),
//         )));
//   }
//
//   @override
//   Widget generateControlBar() {
//     return Container(
//         width: screenSize.width,
//         height: 100,
//         color: Colors.redAccent,
//         child: Column(
//           children: <Widget>[
//             Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   RaisedButton(
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(10))),
//                       color: Colors.redAccent,
//                       textColor: Colors.white,
//                       child: Text(
//                         '改变地图中心点',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       onPressed: () {
//                         myMapController?.setCenterCoordinate(
//                             BMFCoordinate(39.90, 116.40), true,
//                             animateDurationMs: 1000);
//                       }),
//                   RaisedButton(
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(10))),
//                       color: Colors.redAccent,
//                       textColor: Colors.white,
//                       child: Text(
//                         '旋转地图',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       onPressed: () {
//                         myMapController.setNewMapStatus(
//                             mapStatus: BMFMapStatus(fRotation: 45));
//                       }),
//                   RaisedButton(
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(10))),
//                       color: Colors.redAccent,
//                       textColor: Colors.white,
//                       child: Text(
//                         '设置俯仰角',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       onPressed: () {
//                         myMapController.setNewMapStatus(
//                             mapStatus: BMFMapStatus(fOverlooking: -45));
//                       }),
//                 ]),
//             Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   RaisedButton(
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(10))),
//                       color: Colors.redAccent,
//                       textColor: Colors.white,
//                       child: Text(
//                         '设置地图显示区域',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       onPressed: () async {
//                         BMFCoordinateBounds visibleMapBounds =
//                         BMFCoordinateBounds(
//                             northeast: BMFCoordinate(
//                                 39.94001804746338, 116.41224644234747),
//                             southwest: BMFCoordinate(
//                                 39.90299859954822, 116.38359947963427));
//                         await myMapController?.setVisibleMapBounds(
//                             visibleMapBounds, false);
//                       }),
//                   Platform.isAndroid
//                       ? RaisedButton(
//                       shape: RoundedRectangleBorder(
//                           borderRadius:
//                           BorderRadius.all(Radius.circular(10))),
//                       color: Colors.redAccent,
//                       textColor: Colors.white,
//                       child: Text(
//                         '按像素移动地图中心点',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       onPressed: () {
//                         myMapController?.setScrollBy(30, 30,
//                             animateDurationMs: 1000);
//                       })
//                       : SizedBox(width: 0),
//                 ]),
//           ],
//         ));
//   }
//
// }
