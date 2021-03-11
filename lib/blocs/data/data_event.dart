import 'package:equatable/equatable.dart';
import 'package:flt_im_plugin/message.dart';

abstract class DataEvent extends Equatable {

  @override
  List<Object> get props => [];
}

class EventGetData extends DataEvent {

  EventGetData();

}
