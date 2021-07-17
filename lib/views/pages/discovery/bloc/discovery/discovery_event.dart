

import 'package:equatable/equatable.dart';

abstract class DiscoveryEvent extends Equatable {
  const DiscoveryEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class EventGetDiscoveryData extends DiscoveryEvent {
  //final Map<String,dynamic> message;
  EventGetDiscoveryData();

}