import 'package:dio/dio.dart';
import 'package:flutter_geen/app/api/issues_api.dart';
import 'package:flutter_geen/app/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geen/app/res/toly_icon.dart';
import 'package:flutter_geen/app/utils/Toast.dart';
import 'package:flutter_geen/blocs/home/home_bloc.dart';
import 'package:flutter_geen/blocs/home/home_event.dart';
import 'package:flutter_geen/blocs/login/login_state.dart';
import 'package:flutter_geen/components/permanent/feedback_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geen/blocs/login/login_bloc.dart';
import 'package:flutter_geen/blocs/login/login_event.dart';
import 'package:flutter_geen/views/dialogs/delete_category_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:flutter_screenutil/flutter_screenutil.dart';
class LoginFrom extends StatefulWidget {
  @override
  _LoginFromState createState() => _LoginFromState();
}

class _LoginFromState extends State<LoginFrom> {
  final _usernameController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');

  bool _showPwd = false;
  String _result = "无";

  @override
  void initState() {
    super.initState();
    fluwx.weChatResponseEventHandler.distinct((a, b) => a == b).listen((res) async {
      if (res is fluwx.WeChatAuthResponse) {
          if(res.state =="wechat_sdk_demo_login"){
            BlocProvider.of<LoginBloc>(context).add(
              EventWxLogin(code: res.code),
            );
            if (!mounted) return;
            setState(() {
              _result = "state :${res.state} \n code:${res.code}";
            });

          }

      }
    });
  }
  @override
  void dispose() {
    super.dispose();
    _result = null;
  }
  _showToast(BuildContext ctx, String msg, bool collected) {
    Toasts.toast(
      ctx,
      msg,
      duration: Duration(milliseconds:  5000 ),
      action: collected
          ? SnackBarAction(
          textColor: Colors.white,
          label: '收藏夹管理',
          onPressed: () => Scaffold.of(ctx).openEndDrawer())
          : null,
    );
  }
  @override
  Widget build(BuildContext context) {
    return

      BlocListener<LoginBloc, LoginState>(
        listener: (ctx, state) {
            if (state is LoginFailed) {
              Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('${state.reason}'),
              backgroundColor: Colors.red,
          ));
              BlocProvider.of<LoginBloc>(context).add(
                EventLoginFailed(),
              );
        }
                 if (state is LoginSuccess) {
                   BlocProvider.of<LoginBloc>(context).add(
                     EventLoginFailed(),
                   );

                   BlocProvider.of<HomeBloc>(context).add(EventTabTap());
                Navigator.of(context).pushReplacementNamed(UnitRouter.nav);
            }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
              builder:_buildLoginByState
          )
          );
  }


  Widget _buildLoginByState(BuildContext context,LoginState state) {
    return Stack(
      children: [
      Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text("ERP系统",style: TextStyle(fontSize: 40.sp),),
        SizedBox(height: 15.h,),
        Text("登录",style: TextStyle(color: Colors.grey),),
        SizedBox(height:30.h,),
        buildUsernameInput(),
        Stack(
          alignment: Alignment(0.8,0),
          children: [
            buildPasswordInput(),
            FeedbackWidget(
                onPressed: ()=> setState(() => _showPwd=!_showPwd),
                child: Icon(_showPwd?TolyIcon.icon_show:TolyIcon.icon_hide)
            )
          ],
        ),
        Row(
          children: <Widget>[
            Checkbox(value: true, onChanged: (e) => {}),
            Text(
              "自动登录",
              style: TextStyle(color: Color(0xff444444), fontSize: 30.sp),
            ),
            Spacer(),
            GestureDetector(
              onTap: (){
                _register(context);
              },
              child:
            Text(
              "如何注册?",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 25.sp,
                  decoration: TextDecoration.underline),
            ))
          ],
        ),
        _buildBtn(state),
        buildOtherLogin(),
        Container(
          child: state is LoginLoading
              ? CircularProgressIndicator()
              : null,
        )

      ],
    ),


      ],


    );

  }

  _register(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) => Dialog(
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.w))),
          child: Container(
            width: 50.w,
            child: DeleteCategoryDialog(
              title: '注册功能暂未开放',
              content: '请联系主管申请注册',
              onSubmit: () {
                //BlocProvider.of<HomeBloc>(context).add(EventResetCheckUser(photo,1));
                Navigator.of(context).pop();
              },
            ),
          ),
        ));
  }
  void _doLogIn() {

    print('---用户名:${_usernameController.text}------密码：${_passwordController.text}---');
    if (_usernameController.text.isEmpty){
      return;
    }
    if (_passwordController.text.isEmpty){
      return;
    }
   BlocProvider.of<LoginBloc>(context).add(
     EventLogin(
         username: _usernameController.text,
         password: _passwordController.text),
   );
  }

  Widget _buildBtn(LoginState state) => Container(
    margin: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w,bottom: 0),
    height: 80.h,
    width: MediaQuery.of(context).size.width,
    child:
    RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(35.w))),
      color: Colors.blue,
      onPressed: state is LoginInital?  _doLogIn :null,
      child: Text("登   录",
          style: TextStyle(color: Colors.white, fontSize: 30.sp)),
    ),
  );

  Widget buildUsernameInput(){
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(0.5),
              width: 2.w,
            ),
            borderRadius: BorderRadius.circular(30.w),
          ),
          margin:
           EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          child: Row(
            children: <Widget>[
              Padding(
                padding:
                EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                child: Icon(
                  Icons.person_outline,
                  color: Colors.grey,
                ),
              ),
              Container(
                height: 20.h,
                width: 1.w,
                color: Colors.grey.withOpacity(0.5),
                margin:  EdgeInsets.only(left: 00.0, right: 10.w),
              ),
              Expanded(
                child: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '请输入用户名...',
                    hintStyle: TextStyle(color: Colors.grey,fontSize: 30.sp),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget buildPasswordInput(){
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(0.5),
              width: 2.w,
            ),
            borderRadius: BorderRadius.circular(30.w),
          ),
          margin:
           EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          child: Row(
            children: <Widget>[
              Padding(
                padding:
                EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                child: Icon(
                  Icons.lock_outline,
                  color: Colors.grey,
                ),
              ),
              Container(
                height: 30.h,
                width: 1.w,
                color: Colors.grey.withOpacity(0.5),
                margin:  EdgeInsets.only(left: 00.0, right: 10.w),
              ),
              Expanded(
                child: TextField(
                  obscureText: !_showPwd,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '请输入密码...',
                    hintStyle: TextStyle(color: Colors.grey,fontSize: 30.sp),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
  Widget buildOtherLogin(){
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top:30.0),
          child: Row(
            children: [
              Expanded(child: Divider(height: 20,)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('',style: TextStyle(color: Colors.grey),),
              ),
              Expanded(child: Divider(height: 20,)),
            ],
          ),
        ),
        GestureDetector(
          onTap: (){
            fluwx
                .sendWeChatAuth(
                scope: "snsapi_userinfo", state: "wechat_sdk_demo_login")
                .then((data) {});
          },
          child: SvgPicture.asset(
            "assets/packages/images/login_wechat.svg",
            //color: Colors.green,
          ),
        )
      ],
    );
  }
}
