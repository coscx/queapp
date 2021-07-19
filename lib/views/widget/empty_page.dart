import 'package:flutter/material.dart';


/// 说明: 

class EmptyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 300,
      alignment: Alignment.center,
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
             Icon(Icons.style, color: Colors.grey, size: 80.0),
             Container(
              padding:  EdgeInsets.only(top: 16.0),
              child:  Text(
                "暂无数据",
                style:  TextStyle(
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
    );
  }
}
