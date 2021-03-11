import 'package:flutter/material.dart';

import 'package:flutter_geen/app/res/toly_icon.dart';

import 'package:flutter_geen/components/permanent/circle.dart';
import 'package:flutter_geen/components/permanent/code/code_widget.dart';
import 'package:flutter_geen/components/permanent/panel.dart';
import 'package:share/share.dart';
import 'package:toggle_rotate/toggle_rotate.dart';

import '../permanent/feedback_widget.dart';
import '../permanent/code/highlighter_style.dart';


/// 说明: 一个Widget的知识点对应的界面

class WidgetNodePanel extends StatefulWidget {
  final String text;
  final String subText;
  final String code;
  final Widget show;
  final HighlighterStyle codeStyle;
  final String codeFamily;

  WidgetNodePanel(
      {this.text,
      this.subText,
      this.code,
      this.show,
      this.codeStyle,
      this.codeFamily});

  @override
  _WidgetNodePanelState createState() => _WidgetNodePanelState();
}

class _WidgetNodePanelState extends State<WidgetNodePanel> {
  CrossFadeState _crossFadeState = CrossFadeState.showFirst;

  bool get isFirst => _crossFadeState == CrossFadeState.showFirst;

  Color get themeColor => Theme.of(context).primaryColor;
  bool  show =false ;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          buildNodeTitle(),
          SizedBox(
            height: 1,
          ),
          //_buildCode(context),
          Padding(
            padding: const EdgeInsets.only(top: 0, bottom: 0),
            child:   Visibility(
                visible:show,
                replacement:Text('data'),
                maintainState:true,
                child:widget.show),
          ),

          //_buildNodeInfo(),
          Divider(),
        ],
      ),
    );
  }

  Widget buildNodeTitle() => GestureDetector(
    onTap: _toggleCodePanel,
      child:Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Circle(
              color: themeColor,
              radius: 5,
            ),
          ),
          Expanded(
            child: Text(
              '${widget.text}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          //_buildShareButton(),
          _buildCodeButton()
        ],
      ) ,
  );

  Widget _buildNodeInfo() => Container(
        width: double.infinity,
        child: Panel(
            child: Text(
          '${widget.subText}',
          style: TextStyle(fontSize: 14),
        )),
      );

  Widget _buildCodeButton() => Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child:  Icon(
            TolyIcon.icon_code,
            color: themeColor,
          ),

      );

  Widget _buildShareButton() => FeedbackWidget(
        mode: FeedMode.fade,
        a: 0.4,
        onPressed: _doShare,
        child: Padding(
          padding: const EdgeInsets.only(
            right: 10,
          ),
          child: Icon(
            TolyIcon.icon_share,
            size: 20,
            color: themeColor,
          ),
        ),
      );

  Widget _buildCode(BuildContext context) => AnimatedCrossFade(
        firstCurve: Curves.easeInCirc,
        secondCurve: Curves.easeInToLinear,
        firstChild: Container(),
        secondChild: Container(
          width: MediaQuery.of(context).size.width,
          child: CodeWidget(
            fontFamily: widget.codeFamily,
            code: isFirst?'':widget.code,
            style: widget.codeStyle ??
                HighlighterStyle.fromColors(HighlighterStyle.lightColor),
          ),
        ),
        duration: Duration(milliseconds: 200),
        crossFadeState: _crossFadeState,
      );

  //执行分享
  _doShare() {
    Share.share(widget.code);
  }

  // 折叠代码面板
  _toggleCodePanel() {
    setState(() {
      _crossFadeState =
          !isFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond;
          show =!show;
    });
  }
}
