import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geen/app/res/cons.dart';
import 'package:flutter_geen/blocs/bloc_exp.dart';
import 'package:flutter_geen/components/permanent/code/code_widget.dart';
import 'package:flutter_geen/components/permanent/code/highlighter_style.dart';
import 'package:flutter_geen/components/permanent/feedback_widget.dart';
import 'package:flutter_geen/components/permanent/circle.dart';


/// 说明:

class CodeStyleSettingPage extends StatelessWidget {
  final code = """
const String _kCounty = 'China';

class Hello {
  final String name;//言语
  final String county;//国家
  final int age;//年龄

  Hello({
    this.name = "QueQiao Team",
    this.age = 26,
    this.county = _kCounty
  });
}""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('代码高亮样式'),
      ),
      body: BlocBuilder<GlobalBloc, GlobalState>(
          builder: (_, state) => _buildFontCell(context,
              Cons.codeThemeSupport.keys.toList(), state.codeStyleIndex)),
    );
  }

  Widget _buildFontCell(
      BuildContext context, List<HighlighterStyle> styles, int index) {
    return ListView.builder(
      itemCount: styles.length,
      itemBuilder: (_ctx, i) =>  FeedbackWidget(
        a: 0.95,
        duration: Duration(milliseconds: 200),
      onPressed: (){
        BlocProvider.of<GlobalBloc>(context).add(EventSwitchCoderTheme(i));
      },
      child: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
         Card(
              margin: EdgeInsets.all(10),
              child: CodeWidget(
                code: code,
                style: styles[i],
              ),
          ),

          Positioned(
            right: 20,
            bottom: 20,
            child: Text(Cons.codeThemeSupport.values.toList()[i],style: TextStyle(
              fontSize: 14,
              color: styles[i].stringStyle.color,
              shadows: [Shadow(
                color: Colors.white,
                offset: Offset(.5,.5),
                blurRadius: 1
              ),]
            ),),
          ),

          if(index == i)
          Positioned(
            right: 20,
            top: 20,
            child: Circle(radius: 10,
              color: Theme.of(context).primaryColor,
              child: Icon(Icons.check,color:Colors.white,size: 15,),),
          )
        ],
      ),
    ));
  }
}
