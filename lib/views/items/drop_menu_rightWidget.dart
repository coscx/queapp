import 'package:flutter_geen/views/pages/utils/DyBehaviorNull.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart' as frs;
import 'package:flutter/material.dart';
import 'package:flutter_geen/views/items/SearchParamModel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_geen/views/pages/home/home_page.dart';
typedef DropMenuRightCallback = void Function(SearchParamModel model, ParamItemModel item);
typedef SwitchCallback = void Function(bool swith,int a,int b);
class DropMenuRightWidget extends StatefulWidget {
  final SearchParamList paramList;
  final DropMenuRightCallback clickCallBack;
  final VoidCallback resetFun;
  final VoidCallback sureFun;
  final SwitchCallback clickSwith;
  final bool showAge ;
  final int showAgeMin ;
  final int showAgeMax ;
  String resultCount;

  DropMenuRightWidget({
    this.paramList,
    this.clickCallBack,
    this.resetFun,
    this.sureFun,
    this.resultCount,
    this.clickSwith,
    this.showAgeMin,
    this.showAgeMax,
    this.showAge,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _dropMenuRightWidgetState();
  }
}

class _dropMenuRightWidgetState extends State<DropMenuRightWidget> {
  int minValue ;
  int maxValue;
  bool _onOff;
  RangeValues _rangeValues = RangeValues(90, 270);
  @override
  void initState() {
    super.initState();
    minValue =widget.showAgeMin;
    maxValue=widget.showAgeMax;
    _onOff=widget.showAge;
    _rangeValues= RangeValues(minValue.toDouble(), maxValue.toDouble());
  }
  Widget buildButton(
    int modelIndex,
    int itemIndex,
    DropMenuRightCallback onPressed, {
    bgColor = Colors.white,
    Color titleColor,
    double height = 32,
  }) {
    titleColor = titleColor ?? Color(0xFF333333);
    SearchParamModel model = widget.paramList.list[modelIndex];
    ParamItemModel item = model.itemList[itemIndex];

    // return RLKBLoCBuilder(
    //     builder: (BuildContext context, Map data, RLKBaseBLoC bloc) {
    //   DropMenuHeaderBLoC bloc2 = bloc as DropMenuHeaderBLoC;
      return Container(
        height: height,
        child: FlatButton(
            padding: EdgeInsets.all(0),
            onPressed: () {
              widget.clickCallBack(model, item);
              if (model.multiFlag == true) {

              } else {

                for (ParamItemModel itemModel in model.itemList) {
                  if (itemModel != item) {
                    itemModel.isSelected = false;
                  }
                  
                }
              }
              item.isSelected = !item.isSelected;
              setState(() {});
              onPressed ?? onPressed(model, item);

            },
            child: Text(
              item.name,
              style: TextStyle(
                  color: item.isSelected ? Color(0xFFF12E49) : titleColor),
            )),
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(
                color: item.isSelected ? Color(0xFFF12E49) : Color(0xFFDDDDDD),
                width: 1)),
      );
    //});
  }

  bool _hasSelectedItem () {
    for (SearchParamModel model in widget.paramList.list) {
      for (ParamItemModel item in model.itemList) {
        if(item.isSelected == true) {
          return true;
        }
      }
    }
    return false;
  }

  Widget buildTitle(String title) {
    return Container(
      height: 44,
      alignment: Alignment(-1, 0.2),
      padding: EdgeInsets.only(left: 0),
      child: Text(title),
    );
  }

  Widget buildItem(int i) {
    SearchParamModel model = widget.paramList.list[i];
    return Column(
      // shrinkWrap: true,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildTitle(model.paramName),
        Container(
          child: model.dateSelectorType==1?  Wrap(
            alignment: WrapAlignment.start,
            runSpacing: 10,
            spacing: 16,
            children:  List.generate(model.itemList.length, (j) {
              ParamItemModel item = model.itemList[j];
              if (item.name == "自定义时间0") {
                return Container(
                  margin: EdgeInsets.only(top: 0),
                  padding:
                      EdgeInsets.only(left: 0, right: 20, top: 0, bottom: 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                          child: buildButton(i, j,
                        (SearchParamModel pressModel,
                            ParamItemModel pressItem) {
                          print('${pressItem.name}');
                        },
                      )),
                      FlatButton(
                          onPressed: null,
                          child: Text(
                            '清空',
                            style: TextStyle(
                                fontSize: 14, color: Color(0xff4A90E2)),
                          ))
                    ],
                  ),
                );
              } else {
                return buildButton(i, j,
                  (SearchParamModel pressModel, ParamItemModel pressItem) {
                    print('${pressItem.name}');
                  },
                );
              }
            })
          ):
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
            CupertinoSwitch(
            value: _onOff,
            onChanged: (onOff) {
            setState(() {
            _onOff = onOff;
            if(widget.clickSwith != null) {
              widget.clickSwith(_onOff, minValue, maxValue);
            }

            });
            },
            activeColor: Colors.blue,
            //trackColor: Colors.white10,
            ),

          // Container(
          //   width: 400.w,
          //   child: RangeSlider(
          //       values: _rangeValues,
          //       divisions: 700,
          //       min: minValue.toDouble(),
          //       max: maxValue.toDouble(),
          //       labels: RangeLabels("${_rangeValues.start.toStringAsFixed(1)}",
          //           "${_rangeValues.end.toStringAsFixed(1)}"),
          //       activeColor: Colors.orangeAccent,
          //       inactiveColor: Colors.green.withAlpha(99),
          //       onChangeStart: (value) {
          //         print('开始滑动:$value');
          //       },
          //       onChangeEnd: (value) {
          //         print('滑动结束:$value');
          //       },
          //       onChanged: (value) {
          //                 setState(() {
          //                _rangeValues = value;
          //                if(widget.clickSwith != null){
          //                   widget.clickSwith(_onOff, value.start.floor(),value.end.floor());
          //                 }
          //         });
          //       }),
          // ),
              Text(
                minValue.toString()+"",
                style:  TextStyle(
                  fontSize: 38.sp,
                  color: Colors.orangeAccent,
                ),
              ),
              Container(
                width: ScreenUtil().screenWidth*0.6,
                child: frs.RangeSlider(
                  min: 14.0,
                  max: 70.0,
                  lowerValue: minValue.toDouble(),
                  upperValue: maxValue.toDouble(),
                  divisions: 56,
                  showValueIndicator: true,
                  valueIndicatorMaxDecimals: 0,
                  onChanged: (double newLowerValue, double newUpperValue) {
                    setState(() {
                      minValue = newLowerValue.round();
                      maxValue = newUpperValue.round();

                    });

                    if(widget.clickSwith != null){
                      widget.clickSwith(_onOff, minValue,maxValue);
                    }
                  },
                  onChangeStart:
                      (double startLowerValue, double startUpperValue) {
                    print(
                        'Started with values: $startLowerValue and $startUpperValue');
                  },
                  onChangeEnd: (double newLowerValue, double newUpperValue) {
                    print(
                        'Ended with values: $newLowerValue and $newUpperValue');
                  },
                ),
                // child: CupertinoRangeSlider(
                //   minValue: minValue.roundToDouble(),
                //   maxValue: maxValue.roundToDouble(),
                //   min: 14.0,
                //   max: 70.0,
                //   onMinChanged: (minVal){
                //     setState(() {
                //       minValue = minVal.round();
                //     if(widget.clickSwith != null){
                //       widget.clickSwith(_onOff, minValue,maxValue);
                //     }
                //     });
                //   },
                //   onMaxChanged: (maxVal){
                //     setState(() {
                //       maxValue = maxVal.round();
                //       if(widget.clickSwith != null) {
                //         widget.clickSwith(_onOff, minValue, maxValue);
                //       }
                //     });
                //   },
                // ),
              ),
              Text(
                maxValue.toString()+"",
                style:  TextStyle(
                  fontSize: 38.sp,
                  color: Colors.orangeAccent,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    return
      ScrollConfiguration(
        behavior: DyBehaviorNull(),
    child:
      ListView(
        physics: const BouncingScrollPhysics(),
      children: [
        Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: Container(
                  margin: EdgeInsets.only(left: 70.w, right: 20.w, top: 9.h),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: List.generate(
                        widget.paramList.list.length,
                        (i) => Container(
                              child: buildItem(i),
                            )),
                  ),
                ),
              ),
              Container(
                height: 1,
                color: Color(0xfff0f0f0),
                margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h, bottom: 10.h),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 60.w, right: 30.w, bottom: 16.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                        child: Container(
                      height: 42,
                      child: FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            for (SearchParamModel model in widget.paramList.list) {
                              for (ParamItemModel item in model.itemList) {
                                item.isSelected = false;

                              }
                            }
                            setState(() {});
                            widget.resetFun();
                          },
                          child: Text(
                            "重置",
                            style:
                                TextStyle(color: Color(0xFF666666), fontSize: 16),
                          )),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          border: Border.all(color: Color(0xFFDDDDDD), width: 1)),
                    )),
                    Container(
                      width: 11,
                    ),
                    Expanded(
                        child: Container(
                      height: 42,
                      child: FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            setState(() {});
                            widget.sureFun();
                          },
                          child: Text(
                            widget.resultCount == null ? "确定" : "查看${widget.resultCount}个结果",
                            style:
                                TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
                          )),
                      decoration: BoxDecoration(
                        color: Color(0xFFF12E49),
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
