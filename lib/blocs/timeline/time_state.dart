import 'package:equatable/equatable.dart';
import 'package:flt_im_plugin/message.dart';
import 'package:flutter_geen/model/time_line_model_entity.dart';


/// 说明: 主页状态类

abstract class TimeState extends Equatable {
  const TimeState();

  @override
  List<Object> get props => [];
}

class PeerInitals extends TimeState {
  const PeerInitals();

  @override
  List<Object> get props => [];
}

class GetTimeLineSuccess extends TimeState {

  final TimeLineModelEntity timeLine;

  const GetTimeLineSuccess(this.timeLine);
  @override
  List<Object> get props => [timeLine];
}