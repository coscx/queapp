import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_geen/app/res/toly_icon.dart';
import 'package:flutter_geen/app/utils/convert_man.dart';
import 'package:flutter_geen/components/permanent/circle_image.dart';
import 'package:flutter_geen/components/permanent/color_wrapper.dart';
import 'package:flutter_geen/model/github/issue.dart';


/// 说明: 

class IssueItem extends StatelessWidget {
  final Issue issue;

  IssueItem({this.issue});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: 1 / window.devicePixelRatio))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildTop(),
          Padding(
            padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10),
            child: Text(
              issue.title,
              style: TextStyle(fontSize: 15, color: Colors.grey, shadows: [
                Shadow(color: Colors.white, offset: Offset(1, .5))
              ]),
            ),
          ),
          Row(
            children: <Widget>[
              Spacer(),
              WrapColor(
                  color: Colors.greenAccent,
                  child: Text(
                    issue.commentNum.toString(),
                    style: TextStyle(color: Colors.white),
                  )),
              SizedBox(
                width: 5,
              ),
              Icon(
                TolyIcon.icon_common,
                size: 20,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTop() {
    return Row(
      children: <Widget>[
        CircleImage(
          image: NetworkImage(issue.user.avatar_url),
          size: 40,
          borderSize: 2,
        ),
        SizedBox(
          width: 10,
        ),
        WrapColor(
            child: Text(
              "#${issue.number}",
              style: TextStyle(color: Colors.white),
            )),
        SizedBox(
          width: 10,
        ),
        Text(
          issue.user.login,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Text(ConvertMan.time2string(issue.createdAt)),
      ],
    );
  }
}