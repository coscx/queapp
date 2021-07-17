import 'package:flutter/material.dart';
import 'package:flutter_geen/app/res/toly_icon.dart';

import 'arc_clipper.dart';
import 'login_form.dart';
import 'logins_form.dart';


/// 说明:

class LoginPhone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: SingleChildScrollView(
            child: Wrap(children: [
        arcBackground(),
        Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
            child:
            Stack(
                  alignment: Alignment.center,
                  children: [
                    LoginPhoneFrom(),
                  ],
                  )
                  )]
    ),
          ));
  }

  Widget arcBackground() {
    return ArcBackground(
      image: AssetImage("assets/images/caver.webp"),
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Container(
          height: 150,
          // padding: const EdgeInsets.all(20),
          // decoration: BoxDecoration(
          //    color: Colors.blue.withAlpha(88), shape: BoxShape.rectangle),
          // child: Icon(TolyIcon.icon_bug,size: 100,color: Colors.pink,)
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
