import 'package:equatable/equatable.dart';
import 'package:flutter_geen/model/widget_model.dart';



abstract class CollectEvent extends Equatable {}


//class EventSetCollect extends CollectEvent {
//  final bool collect;
//
//  EventSetCollect({this.collect});
//
//  @override
//  // TODO: implement props
//  List<Object> get props => [collect];
//}

class EventSetCollectData extends CollectEvent {
  List<Object> get props => [];
}


class ToggleCollectEvent extends CollectEvent {
  final int id;

  ToggleCollectEvent({this.id});

  @override
  // TODO: implement props
  List<Object> get props => [id];
}

class LoadCollectEvent extends CollectEvent{
  @override
  List<Object> get props => [];

}

