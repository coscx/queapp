import 'package:equatable/equatable.dart';
import 'package:flt_im_plugin/message.dart';

abstract class UserEvent extends Equatable {

  @override
  List<Object> get props => [];
}

class EventGetUser extends UserEvent {

  EventGetUser();

}
