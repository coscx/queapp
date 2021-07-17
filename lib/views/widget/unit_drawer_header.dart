import 'package:flutter/material.dart';


/// 说明: 

class UnitDrawerHeader extends StatelessWidget {
  final Color color;
  final String id;

  UnitDrawerHeader({this.color,this.id});

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      padding: EdgeInsets.only(top: 10, left: 15),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/wy_300x200_filter.webp'),
            fit: BoxFit.cover),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Wrap(
            spacing: 10,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              FlutterLogo(
//                colors: Colors.orange,
                size: 35,
              ),
              Text(
                'Flutter',
                style: TextStyle(fontSize: 24, color: Colors.white, shadows: [
                  Shadow(
                      color: Colors.black,
                      offset: Offset(1, 1),
                      blurRadius: 3)
                ]),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            id,
            style: TextStyle(fontSize: 15, color: Colors.white, shadows: [
              Shadow(color: color, offset: Offset(.5, .5), blurRadius: 1)
            ]),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Flutter make dream',
            style: TextStyle(fontSize: 15, color: Colors.white, shadows: [
              Shadow(color: color, offset: Offset(.5, .5), blurRadius: 1)
            ]),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Spacer(
                flex: 5,
              ),
              Text(
                '—— QueQiao Team',
                style: TextStyle(fontSize: 15, color: Colors.white, shadows: [
                  Shadow(
                      color: Colors.orangeAccent,
                      offset: Offset(.5, .5),
                      blurRadius: 1)
                ]),
              ),
              Spacer(
                flex: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
