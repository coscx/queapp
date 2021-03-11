

import 'package:equatable/equatable.dart';
import 'package:flutter_geen/model/github/issue.dart';


/// 说明:

abstract class PointCommentEvent extends Equatable {}

class EventLoadPointComment extends PointCommentEvent {
  final Issue point;

  EventLoadPointComment(this.point);

  @override
  List<Object> get props => [point];
}
