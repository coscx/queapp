import 'package:flutter/material.dart';


/// 说明:

typedef FunNum1 = Function(double t);

class MathRunner extends StatefulWidget {
  MathRunner({Key key, this.child, this.f, this.g, this.reverse = true})
      : super(key: key);
  final Widget child;
  final FunNum1 f;
  final FunNum1 g;
  final bool reverse;

  @override
  _MathRunnerState createState() => _MathRunnerState();
}

class _MathRunnerState extends State<MathRunner>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation animationX;
  double _x = -1.0;
  double _y = 0;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3))..repeat(reverse: widget.reverse);
    animationX = Tween(begin: -1.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _x = widget.f(animationX.value);
          _y = widget.g(animationX.value);
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
        child: Align(
          alignment: Alignment(_x, _y),
          child: widget.child,
        )
    );
  }
}
