import 'package:flutter/material.dart';
import 'package:flutter_geen/components/permanent/circle.dart';
class TolyAppBar extends StatefulWidget {
  final double maxHeight;
  final Function(int, Color) onItemClick;
  final List<String> nums;
  @override
  _TolyAppBarState createState() => _TolyAppBarState();

  final int defaultIndex;

  TolyAppBar({this.maxHeight, this.onItemClick, this.defaultIndex = 0,this.nums});
}

const _kBorderRadius = BorderRadius.only(
  bottomLeft: Radius.circular(15),
  bottomRight: Radius.circular(15),
);

const _kTabTextStyle = TextStyle(color: Colors.white, shadows: [
  const Shadow(color: Colors.black, offset: Offset(0.5, 0.5), blurRadius: 0.5)
]);

class _TolyAppBarState extends State<TolyAppBar>
    with SingleTickerProviderStateMixin {
  double _width = 0;
  int _selectIndex = 0;

  static const List<int> colors = [
    0xff44D1FD,
    0xffFD4F43,
    0xffB375FF,
    0xFF4CAF50,
    0xFFFF9800,
    0xFF00F1F1,
    0xFFDBD83F
  ];

  static  List<String> info = [
    '0',
    '0',
    '0',
    '0',
    '0',
    '0',
    '0'
  ];


  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this)
      ..addListener(_render)
      ..addStatusListener(_listenStatus);
    _selectIndex = widget.defaultIndex;
    info=widget.nums?? info;
    super.initState();
  }

  void _render() {
    setState(() {});
  }

  void _listenStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      setState(() {});
    }
  }

  int get nextIndex => (_selectIndex + 1) % colors.length;

  bool clicked = false;

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width / colors.length;
    return Container(
      alignment: Alignment.center,
      child: Flow(
          delegate: TolyAppBarDelegate(
              _selectIndex, clicked ? _controller.value : 1, widget.maxHeight),
          children: [
            ...colors
                .map((e) => GestureDetector(
                onTap: () => _onTap(e), child: _buildChild(e)))
                .toList(),
            ...colors.map((e) => Circle(
              color: Color(e),
              radius: 6,
            ))
          ]),
    );
  }

  Widget _buildChild(int color) => Container(
    alignment: const Alignment(0, 0.4),
    decoration: BoxDecoration(boxShadow: [
      BoxShadow(
          color: _selectIndex == colors.indexOf(color)
              ? Colors.transparent
              : Color(colors[_selectIndex]),
          offset: Offset(1, 1),
          blurRadius: 2)
    ], color: Color(color), borderRadius: _kBorderRadius),
    height: widget.maxHeight + 20,
    width: _width,
    child: Column(
      children: <Widget>[
        SizedBox(
          height: widget.maxHeight-37,
        ),
        Icon(
          Icons.star,
          color: true ? Colors.blue : Colors.grey,
          size: 30,
        ),
        Text(
            (widget.nums?? info)[colors.indexOf(color)],
          style: _kTabTextStyle,
        ),
      ],
    ),
  );

  _onTap(int color) {
    if (_selectIndex == colors.indexOf(color)) return;
    clicked = true;
    setState(() {
      _controller.reset();
      _controller.forward();
      _selectIndex = colors.indexOf(color);
      if (widget.onItemClick != null)
        widget.onItemClick(_selectIndex, Color(color));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class TolyAppBarDelegate extends FlowDelegate {
  final int selectIndex;
  final double factor;
  final double height;

  TolyAppBarDelegate(this.selectIndex, this.factor, this.height);

  @override
  void paintChildren(FlowPaintingContext context) {
    double ox = 0;
    double obx = 0;

    for (int i = 0; i < context.childCount / 2; i++) {
      Size cSize = context.getChildSize(i);
      if (i == selectIndex) {
        context.paintChild(i,
            transform: Matrix4.translationValues(ox, 20.0 * factor - 20, 0.0));
        ox += cSize.width;
      } else {
        context.paintChild(i,
            transform: Matrix4.translationValues(ox, -20, 0.0));
        ox += cSize.width;
      }
    }

    for (int i = (context.childCount / 2).floor(); i < context.childCount; i++) {
      if (i - (context.childCount / 2).floor() == selectIndex) {
        obx += context.getChildSize(0).width;
      } else {
        context.paintChild(i,
            transform: Matrix4.translationValues(
                obx + context.getChildSize(0).width / 2 - 5, height + 5, 0));
        obx += context.getChildSize(0).width;
      }
    }
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) => true;
}
