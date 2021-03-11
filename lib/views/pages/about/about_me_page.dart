
/// 说明:

import 'package:flutter/material.dart';
import 'package:flutter_geen/app/res/toly_icon.dart';
import 'package:flutter_geen/components/permanent/circle_image.dart';
import 'package:flutter_geen/components/permanent/feedback_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutMePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(bottom: 50),
                    child: Image.asset(
                      'assets/images/sabar.webp',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              _buildBar(context),
              Positioned(
                  bottom: 0,
                  left: 50,
                  child: CircleImage(
                    size: 100,
                    shadowColor: Theme.of(context).primaryColor,
                    image: AssetImage('assets/images/ic_launcher.png'),
                  )),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(24),
                child: Stack(children: <Widget>[
                  Positioned(
                    right: 10,
                    top: 0,
                    child: _buildLinkIcon(),
                  ),
                  _buildInfo()
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              padding: EdgeInsets.only(left: 10),
              child: Icon(
                Icons.arrow_back,
                size: 30,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Spacer(),
          FeedbackWidget(
            onPressed: () =>
                _launchURL("https://github.com/coscx/gold"),
            child: Icon(
              TolyIcon.icon_email,
              size: 20,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      debugPrint('Could not launch $url');
    }
  }

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'QueQiao Team',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Text(
          'The King Of Coder. ',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 10),
        Text(
          '海的彼岸有我未曾见证的风采。',
          style: TextStyle(fontSize: 16),
        ),
        Divider(
          height: 18,
        ),

        Text(
              '愿青梅煮酒，与君天涯共话。',
          style: TextStyle(color: Colors.grey),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: 190,
              child: Column(
                children: <Widget>[


                ],
              ),
            ),

          ],
        ),
      ],
    );
  }

  Wrap _buildLinkIcon() {
    return Wrap(
      spacing: 20,
      children: <Widget>[

        FeedbackWidget(
            onPressed: () =>
                _launchURL("https://github.com/coscx/gold"),
            child: Wrap(
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                Icon(
                  TolyIcon.icon_github,
                  size: 35,
                ),
                SizedBox(height: 4,),
                Text('Github')
              ],
            )),
      ],
    );
  }
}
