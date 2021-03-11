import 'package:flutter/material.dart';
import 'package:flutter_geen/app/res/toly_icon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'arc_clipper.dart';
import 'login_form.dart';


/// 说明:

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return

//      BlocListener<AuthenticBloc, AuthenticState>(
//      listener: (context, state) {
//        if (state is AuthSuccess) {
//          Navigator.of(context).pushReplacementNamed(Router.nav);
//        }
//      },
//      child:

      Scaffold(
          body: SingleChildScrollView(
            child: Wrap(children: [
        arcBackground(),
        Container(
            width: MediaQuery.of(context).size.width,
            padding:  EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
            child:
//
//          BlocBuilder<LoginBloc, LoginState>(
//            builder: (_, state) {
//              return

                  Stack(
                  alignment: Alignment.center,
                  children: [
                    LoginFrom(),
//                  if (state is LoginFailure)
//                    Positioned(
//                        bottom: 0,
//                        child: ErrorMsg(
//                          error: state.error,
//                        )),
//                  if (state is LoginLoading)
//                    LoadingView(
//                      text: "登录中...",
//                    )
                  ],

                  )
//              );
//            },
//          ),
//        )
//      ]
                  )]
//        ),
    ),
          ));
  }

  Widget arcBackground() {
    return ArcBackground(
      image: AssetImage("assets/images/caver.webp"),
      child: Padding(
        padding:  EdgeInsets.all(100.w),
        child: Container(
          padding:  EdgeInsets.all(20.w),
          decoration: BoxDecoration(
              color: Colors.white.withAlpha(0), shape: BoxShape.rectangle),

          child: Image.asset(
              "assets/images/login_top.png",
               width: ScreenUtil().setWidth(400),
               height: ScreenUtil().setWidth(200),
          )
        ),
      ),
    );
  }
}

class ArcBackground extends StatelessWidget {
  final Widget child;
  final ImageProvider image;

  ArcBackground({this.child, this.image});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ArcClipper(),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: image,
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
