import 'package:flutter/material.dart';


class PartyCell extends StatelessWidget {


  const PartyCell({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Navigator.pushNamed(context, 'search')
    // TODO: implement build
    _buildContainer();

  }

  Container _buildContainer() {
    return Container(
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      border:
          Border(bottom: BorderSide(width: 0.5, color: Color(0xFFd9d9d9))),
    ),
    child: new Row(
      children: [
        Image.network(
          "resultsListBean.url",
          width: 130,
          height: 90,
          fit: BoxFit.cover,
        ),
        new Expanded(
          child: Container(
            height: 95,
            padding: EdgeInsets.only(
              left: 6,
            ),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "getText(resultsListBean.title)",
                  style: TextStyle(fontSize: 16, color: Colors.redAccent),
                ),
                Padding(padding: EdgeInsets.only(top: 8.0)),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            _buildDecoratedBox(
                                "resultsListBean.tag1", Colors.redAccent),
                            Padding(padding: EdgeInsets.only(left: 4.0)),
                            _buildDecoratedBox(
                                "resultsListBean.tag2", Colors.redAccent),
                            Padding(padding: EdgeInsets.only(left: 4.0)),
                            _buildDecoratedBox(
                                "resultsListBean.tag3", Colors.redAccent),
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 8.0)),
                        Text(
                          "getText(resultsListBean.sub_describe)",
                          style: TextStyle(
                              fontSize: 12, color: Colors.redAccent),
                        )
                      ],
                    )),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "getText(resultsListBean.price)",
                        style:
                            TextStyle(fontSize: 18, color: Colors.redAccent),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
  }

  Widget _buildDecoratedBox(String text, Color color) {
    if (text == null) {
      return Text('');
    } else {
      return DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(2.0),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(2.0, 1.0, 2.0, 1.0),
          child: Text(
            text,
            style: TextStyle(fontSize: 12, color: color),
          ),
        ),
      );
    }
  }
}
