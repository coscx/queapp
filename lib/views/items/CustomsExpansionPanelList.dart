import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/// create by GUGU Team on 2020-03-30
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 178,
//      "name": 'ExpansionPanelList基本使用',
//      "priority": 1,
//      "subtitle":
//          "【children】 : 子组件列表   【List<Widget>】\n"
//          "【animationDuration】 : 动画时长   【Duration】\n"
//          "【expansionCallback】 : 展开回调   【List<Widget>】\n"
//          "【onPressed】 : 点击事件  【Function()】",
//    }
class CustomsExpansionPanelList extends StatefulWidget {
  @override
  _CustomsExpansionPanelListState createState() =>
      _CustomsExpansionPanelListState();
}

class _CustomsExpansionPanelListState extends State<CustomsExpansionPanelList> {
  var data = <Color>[
    Colors.red[50],

  ];
  int _position = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 725.w,
      child: ExpansionPanelList(
        children: data.map((color) => _buildItem(color)).toList(),
        animationDuration: Duration(milliseconds: 200),
        expansionCallback: (index, open) {
          setState(() => _position=open?-1:index);
        },
      ),
    );
  }

  ExpansionPanel _buildItem(Color color) {
    return ExpansionPanel(
        isExpanded: data.indexOf(color) == _position,
        canTapOnHeader: true,
        headerBuilder: (ctx, index) => Center(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 50.w, right: 0.w,top: 25.h),
                height: 100.h,
                width: 180.w,
                decoration:BoxDecoration(color: color, shape: BoxShape.rectangle
                ,borderRadius: BorderRadius.all(Radius.circular(5.w))
                ),
                child: Text(
                  "留言",
                  style: TextStyle(fontSize: 18.0, color: Colors.grey),
                ),
              ),
              Container(
                width: 420.w,
                alignment: Alignment.center,
                height: 100.h,
                child: Text(
                  "",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _item(context),
            _item(context),
            _item(context),
            _item(context),
            _item(context),
            _item(context),
            _item(context),
            _item(context),

          ],
        )
    );
  }

  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";

  Widget _item(BuildContext context) {
    bool isDark = false;

    return  Container(
      width: double.infinity,
      height: 100.h,
      child:  Material(
          color:  Colors.white ,
          child: InkWell(
            onTap: (){},
            child: Container(
              margin: EdgeInsets.only(left: 10.w, right: 20.w),
              child: Column(
                  children: <Widget>[

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                            children: <Widget>[

                              Container(
                                margin: EdgeInsets.only(left: 15.w),
                                child: Text(
                                  "李忆如：",
                                  style: TextStyle(fontSize: 15.0, color: Colors.grey),
                                ),
                              )
                            ]),
                        Visibility(
                          visible: true,
                          child: Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(right: 1.w),
                                  child: Row(children: <Widget>[
                                    Visibility(
                                        visible: true,
                                        child:  Container(
                                          width: 560.w,
                                            child:Text(
                                          "得分的风格规范的电饭锅电饭锅给得分打发打发放大得分",
                                              overflow: TextOverflow.ellipsis,// 文字显示不全样式
                                          style: TextStyle(
                                              fontSize: 15.0, color: Colors.grey),
                                        ))),

                                  ]),
                                ),



                              ]),
                        )
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                            children: <Widget>[

                              Container(
                                margin: EdgeInsets.only(left: 220.w),
                                child: Text(
                                  "添加日期：",
                                  style: TextStyle(fontSize: 15.0, color: Colors.grey),
                                ),
                              )
                            ]),
                        //Visibility是控制子组件隐藏/可见的组件
                        Visibility(
                          visible: true,
                          child: Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(right: 10.w),
                                  child: Row(children: <Widget>[
                                    Visibility(
                                        visible: true,
                                        child: Text(
                                          "2021-1-15 15:15:30",
                                          style: TextStyle(
                                              fontSize: 15.0, color: Colors.grey),
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
                  ]
              )



            ),
          )),
    );
  }
}
