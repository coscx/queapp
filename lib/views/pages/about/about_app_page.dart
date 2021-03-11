import 'package:flutter/cupertino.dart';

/// 说明:

import 'package:flutter/material.dart';
import 'package:flutter_geen/app/res/toly_icon.dart';
import 'package:flutter_geen/components/permanent/circle.dart';
import 'package:flutter_geen/components/permanent/circle_image.dart';
import 'package:flutter_geen/components/permanent/feedback_widget.dart';
import 'package:flutter_geen/components/permanent/panel.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutAppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      height: 150,
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
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(24),
                child: _buildInfo(),
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
                _launchURL("http://guguteam.com"),
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

    }
  }

  Widget _buildInfo() {
    return Stack(
      children: <Widget>[
        Positioned(
          right: 10,
          top: 0,
          child: Wrap(
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
                      Text('Github')
                    ],
                  )),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Flutter',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'APP简介',
              style: TextStyle(fontSize: 16),
            ),

            Divider(
              height: 20,
            ),
            InfoPanel(
              title: '简介',
              info:          '      QueQiao是一款国际社交APP，倾向用户群体90-00后国际化文化社交平台，QueQiao社交基于大数据智能推荐、从人际网到恋爱约会，再到文化传播，多模式切换进行匹配好友，帮助用户结识异国他乡的朋友与文化 ，QueQiao尊重女士优先，在这里女性会备受尊重，严格的聊天信誉评价系统，让社交更加纯洁。QueQiao国际社交APP，可定位任何国家任何地区快速认识当地人的一款软件，基于人际网，约会恋爱，文化传播于一身的平台，你可以在这里认识不同国家兴趣爱好相同的人，闺蜜或是恋人，也可以是一起打球的兄弟，喜欢养狗的人或是异国同行设计师，互相喜欢方可匹配，在这里世界都近在咫尺，无缝连接，不用担心语言，快捷聊天翻译，让沟通不再是麻烦的问题。',
            ),
            Divider(
              height: 20,
            ),
            InfoPanel(
                title: '产品功能',
                info:    '1、QueQiao划片配对。\n'
                    'QueQiao划片含有三个模式，分别是：A人际网、B恋爱约会、C文化传播。划片快捷匹配相同爱好的朋友，大数据分类用户。炫酷的特效，简洁实用的界面，QueQiao极力打造一款最实用的标签化国际社交软件。\n'
                    '2、问答标签\n'
                    '为每个用户提供包括星座爱好学历身高体重等几十上百的标签。\n'
                    '3、雷达定位\n'
                    '互相匹配成功的好友可以在雷达上看见对方的map，在地图上快捷聊天打招呼。\n'
                    '4、匿名评价\n'
                    '互相匹配成功后互相聊天后可以匿名评价对方，远离不礼貌无素质的人，让社交更纯净！\n'
                 ,
            ),
            Divider(
              height: 20,
            ),
            InfoPanel(
              title: '软件特点',
              info:    '1、随意定位异地坐标。'+

              '2、与好友之间共享实时位置。'+

            '3、匿名评价好友。'+

            '4、随意切换交往模式。'+

            '5、一键翻译对话。'+

            '6、颜色区分好友关系'+

            '7、标签分类人群'+

             ' 8、用户快速制作分享优质文章'
                 ,
            )
          ],
        ),
      ],
    );
  }
}

class InfoPanel extends StatelessWidget {
  final String title;
  final String info;


  InfoPanel({this.title, this.info});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Circle(color: Theme.of(context).primaryColor,), Padding(
              padding: const EdgeInsets.only(left: 15,top: 15,bottom: 15),
              child: Text('$title',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            )
          ],
        ),
        Panel(
        color: Theme.of(context).primaryColor.withAlpha(33),
          child: Text(
            '$info',
            style: TextStyle(color: Colors.grey,
                fontSize: 13,
                shadows: [
                  Shadow(
                      color: Colors.white,
                      offset: Offset(1,1)
                  )
                ]),
          ),
        ),
      ],
    );
  }
}
