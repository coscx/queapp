import 'dart:convert';
import 'dart:math';

import 'package:flt_im_plugin/flt_im_plugin.dart';
import 'package:flt_im_plugin/message.dart';
import 'package:flt_im_plugin/value_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geen/app/api/issues_api.dart';
import 'package:flutter_geen/app/res/cons.dart';
import 'package:flutter_geen/model/time_line_model_entity.dart';
import 'time_event.dart';
import 'time_state.dart';
import 'package:flutter_geen/generated/json/time_line_model_entity_helper.dart';


class TimeBloc extends Bloc<TimeEvent, TimeState> {


  TimeBloc();

  @override
  TimeState get initialState => PeerInitals();

  Color get activeHomeColor {
    return Color(Cons.tabColors[0]);
  }

  @override
  Stream<TimeState> mapEventToState(TimeEvent event) async* {
    if (event is PeerInitals) {



    }
    if (event is EventGetTimeLine) {

      try {
        TimeLineModelEntity timeline= TimeLineModelEntity() ;
        var result= await IssuesApi.getTimeLine(event.MemberId??"1");
        if  (result['code']==200){

          timeLineModelEntityFromJson(timeline,result);
          print(timeline);

        } else{

        }

        yield GetTimeLineSuccess(timeline);

      } catch (err) {
        print(err);

      }

    }



  }


}
