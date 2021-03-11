import 'package:equatable/equatable.dart';
import 'package:flt_im_plugin/message.dart';




abstract class TimeEvent extends Equatable {

  @override
  List<Object> get props => [];
}

class EventGetTimeLine extends TimeEvent {
  final String MemberId;
  EventGetTimeLine(this.MemberId);

}
