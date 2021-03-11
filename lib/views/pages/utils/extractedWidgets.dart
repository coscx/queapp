import 'package:flutter/material.dart';
class MyContainerTile extends StatelessWidget {
  const MyContainerTile({this.child, this.height});

  final Widget child;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color:  Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(1, 3),
            blurRadius: 4.0,
          ),
        ],
      ),
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: child,
    );
  }
}

class ResultContainer extends StatelessWidget {
  const ResultContainer({
    Key key,
    @required this.title,
    @required this.value,
    this.units,
  }) : super(key: key);

  final String title;
  final String value;
  final String units;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(top: 6.0, bottom: 6.0),
      decoration: BoxDecoration(
        color:  Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(1, 3),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Text(
            title,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(value),

              Text(units)

            ],
          )
        ],
      ),
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
