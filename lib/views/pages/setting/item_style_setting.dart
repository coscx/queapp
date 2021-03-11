import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geen/blocs/bloc_exp.dart';
import 'package:flutter_geen/components/permanent/feedback_widget.dart';
import 'package:flutter_geen/components/permanent/circle.dart';
import 'package:flutter_geen/views/items/home_item_support.dart';



/// 说明: item样式切换支持

class ItemStyleSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('item样式设置'),
      ),
      body: BlocBuilder<GlobalBloc, GlobalState>(builder: (_, state) {
        return _buildFontCell(context, state.itemStyleIndex);
      }),
    );
  }

  get items=> HomeItemSupport.itemSimples();

  Widget _buildFontCell(BuildContext context, int index) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (_, i) => FeedbackWidget(
                a: 0.95,
                duration: Duration(milliseconds: 200),
                onPressed: () {
                  BlocProvider.of<GlobalBloc>(context)
                      .add(EventChangeItemStyle(i));
                },
                child: Stack(
                  children: <Widget>[
                    items[i],
                    if (index == i)
                      Positioned(
                        left: 25,
                        top: 15,
                        child: Circle(
                          color: Theme.of(context).primaryColor,
                          radius: 10,
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                      )
                  ],
                )));
  }
}
