/*
 * @discripe: 登录弹窗弹窗
 */
import 'package:fbutton/fbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geen/app/router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_geen/blocs/detail/detail_bloc.dart';
import 'package:flutter_geen/blocs/detail/detail_event.dart';
class UserDetailDialog extends Dialog  {
  Map<String ,dynamic> user;
  UserDetailDialog(this.user);

  @override
  Widget build(BuildContext context) {

  String  imgUrl  = user['pic'][0];
  var info = user['info'];

    return Material(
      type: MaterialType.transparency,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 650.w,
            height: 650.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(6.w)),
            ),
            child: OverflowBox(
              alignment: Alignment.bottomCenter,
              maxHeight: 650.h,
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
                        color: Colors.black,
                        width: 30.w,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: 0.w,
                      right: 0.w,
                      top: 80.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                          height: 50.h,
                        ),

                         Container(
                            width: 700.w,
                            height: 330.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(3.w)),
                              image: new DecorationImage(
                                image: Image.asset(
                                  "assets/images/credit.png",
                                  fit: BoxFit.fitWidth,
                                  //width: 520.w,
                                  //height: 600.h,
                                  //: 240,
                                ).image,

                              ),
                            ),
                            child:  Stack(
                                children: <Widget>[
                                  Positioned(
                                    top: 50.h,
                                    left: 145.w,
                                    child:Text(info['name'],
                                        style: TextStyle(color: Colors.black, fontSize: 12)),

                                  ),

                                  Positioned(
                                    top: 87.h,
                                    left: 147.w,
                                    child:Text(info['gender']==1?"男":"女",
                                        style: TextStyle(color: Colors.black, fontSize: 12)),

                                  ),
                                  Positioned(
                                    top: 87.h,
                                    left: 262.w,
                                    child:Text(info['nation']==1?"汉":"其他",
                                        style: TextStyle(color: Colors.black, fontSize: 12)),

                                  ),
                                  Positioned(
                                    top: 130.h,
                                    left: 147.w,
                                    child:Text(info['birthday'].toString().substring(0,4),
                                        style: TextStyle(color: Colors.black, fontSize: 12)),

                                  ),
                                  Positioned(
                                    top: 130.h,
                                    left: 237.w,
                                    child:Text(info['birthday'].toString().substring(5,7),
                                        style: TextStyle(color: Colors.black, fontSize: 12)),

                                  ),
                                  Positioned(
                                    top: 130.h,
                                    left: 290.w,
                                    child:Text(info['birthday'].toString().substring(8,10),
                                        style: TextStyle(color: Colors.black, fontSize: 12)),

                                  ),

                                  Positioned(
                                      top: 170.h,
                                      left: 149.w,
                                      child:
                                      Container(
                                        width: 230.w,
                                        height: 98.h,
                                        child: Container(
                                            child:Text(info['location_place'].toString(),
                                                maxLines: 2,
                                                style: TextStyle(color: Colors.black, fontSize: 11))),
                                      )
                                  ),

                                  Positioned(
                                    top: 271.h,
                                    left: 205.w,
                                    child:Text("371327198611235566",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 6.w,
                                        )),

                                  ),
                                  // Positioned(
                                  //   top: 230.h,
                                  //   left: 95.w,
                                  //   child:Text("会员到期:2021-12-25 15:20:30",
                                  //       style: TextStyle(
                                  //         color: Colors.black,
                                  //         fontSize: 11,
                                  //         fontWeight: FontWeight.w100,
                                  //         letterSpacing: 0.w,
                                  //       )),
                                  //
                                  // ),
                                  Positioned(
                                    top: 35.h,
                                    left: 398.w,
                                    child: Container(
                                      decoration: new BoxDecoration(
                                        //背景
                                        color: Colors.transparent,
                                        //设置四周圆角 角度
                                        //borderRadius: BorderRadius.all(Radius.circular(10.w)),
                                      ),
                                      child: ClipRRect	(
                                        borderRadius: BorderRadius.all(Radius.circular(2.w)),
                                        child: Image.network(
                                          imgUrl==null?"":imgUrl,
                                          fit: BoxFit.cover,
                                          width: 160.w,
                                          height: 200.h,
                                        ),
                                      ),

                                    ),

                                  ),

                                  Positioned(
                                    top: 20.h,
                                    left: 373.w,
                                    child: Container(
                                      decoration: new BoxDecoration(
                                        //背景
                                        color: Colors.transparent,
                                        //设置四周圆角 角度
                                        borderRadius: BorderRadius.all(Radius.circular(10.w)),
                                      ),
                                      child: ClipRRect	(
                                        borderRadius: BorderRadius.all(Radius.circular(2.0)),
                                        child: Image.asset(
                                          "assets/images/rank1.png",
                                          //fit: BoxFit.cover,
                                          width: 60.w,
                                          height: 60.h,
                                        ),
                                      ),

                                    ),

                                  ),
                                ]),




                          ),




                        Padding(
                          padding: EdgeInsets.only(top: 20.h, bottom: 15.h,left: 50.h,right: 50.h),
                          child: RaisedButton(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20))),
                            color: Colors.lightBlue,
                            onPressed: (){

                              BlocProvider.of<DetailBloc>(context).add(FetchWidgetDetail(user['info']));
                              Navigator.pushNamed(context, UnitRouter.widget_detail);

                            },
                            child: Text("查看用户详情",
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
