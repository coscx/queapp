import 'package:flutter/material.dart';

/// 说明: 

class WrapColor extends StatelessWidget {
  final Widget child;
  final Color color;
  final double radius;
  final EdgeInsetsGeometry padding;

  WrapColor(
      {this.child,
        this.color = Colors.blue,
        this.radius = 5,
        this.padding =
        const EdgeInsets.only(left: 4, right: 4, top: 0, bottom: 0)});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      padding: padding,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(radius))),
    );
  }
}