import 'package:equatable/equatable.dart';
import 'package:flt_im_plugin/message.dart';

abstract class BigDataEvent extends Equatable {

  @override
  List<Object> get props => [];
}

class EventGetBigData extends BigDataEvent {

  EventGetBigData();

}
