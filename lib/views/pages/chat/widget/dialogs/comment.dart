/*
 * @discripe: 登录弹窗弹窗
 */
import 'package:fbutton/fbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CommentDialog extends Dialog  {
  final BuildContext context;
  final void Function(void Function()) state;
  CommentDialog(this.context, this.state);
  final _Controller = TextEditingController(text: '');
  final List<Map<String, dynamic>> _items = [
    {
      'value': 'boxValue',
      'label': 'Box Label',
      'icon': Icon(Icons.stop),
    },
    {
      'value': 'circleValue',
      'label': 'Circle Label',
      'icon': Icon(Icons.fiber_manual_record),
      'textStyle': TextStyle(color: Colors.red),
    },
    {
      'value': 'starValue',
      'label': 'Star Label',
      'enable': false,
      'icon': Icon(Icons.grade),
    },
  ];
  int groupValue=0;
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 600.w,
            height: 700.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            child: OverflowBox(
              alignment: Alignment.bottomCenter,
              maxHeight: 700.h,
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: <Widget>[
                  Positioned(
                      top: 50.h,
                    child: Image.asset(
                      'assets/images/login_top.png',
                      width: 220.w,
                    ),
                  ),

                  Positioned(
                    top: 30.h,
                    right: 30.h,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Image.asset('assets/images/btn_close_black.png',
                        width: 30.w,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 30.w,
                      right: 30.w,
                      top: 80.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                          height: 50.h,
                        ),

                        Row(
                          children: [
                            Radio(
                              ///此单选框绑定的值 必选参数
                              value: 0,
                              ///当前组中这选定的值  必选参数
                              groupValue: groupValue,
                              ///点击状态改变时的回调 必选参数
                              onChanged: (v) {
                                state(() {
                                  groupValue = v;
                                });
                              },
                            ),
                            Radio(
                              ///此单选框绑定的值 必选参数
                              value: 1,
                              ///当前组中这选定的值  必选参数
                              groupValue: groupValue,
                              ///点击状态改变时的回调 必选参数
                              onChanged: (v) {
                                state(() {
                                  groupValue = v;
                                });
                              },
                            ),
                          ],
                        ),


                        Container(
                          width:300.w,
                          child: TextField(
                            controller: _Controller,
                            style: TextStyle(color: Colors.blue),
                            minLines: 10,
                            maxLines: 10,
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
                          padding: EdgeInsets.only(top: 40.h, bottom: 15.h),
                          child: RaisedButton(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20))),
                            color: Colors.lightBlue,
                            onPressed: (){
                              if (_Controller.text.isEmpty){
                                return;
                              }
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
        ],
      ),
    );
  }
}
