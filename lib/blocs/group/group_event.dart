import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:flt_im_plugin/message.dart';




abstract class GroupEvent extends Equatable {

  @override
  List<Object> get props => [];
}


class EventGroupFirstLoadMessage extends GroupEvent {
  final String currentUID;
  final String GroupUID;
  EventGroupFirstLoadMessage(this.currentUID,this.GroupUID);

}

class EventGroupLoadMoreMessage extends GroupEvent {

}

class EventGroupReceiveNewMessage extends GroupEvent {
  final Map<String,dynamic> message;
  EventGroupReceiveNewMessage(this.message);

}
class EventGroupReceiveNewMessageAck extends GroupEvent {
  final Map<String,dynamic> message;
  EventGroupReceiveNewMessageAck(this.message);

}
class EventGroupSendNewMessage extends GroupEvent {

  final String currentUID;
  final String GroupUID;
  final String content;
  EventGroupSendNewMessage(this.currentUID,this.GroupUID,this.content,);

}

class EventGroupSendNewImageMessage extends GroupEvent {

  final String currentUID;
  final String GroupUID;
  final Uint8List content;
  EventGroupSendNewImageMessage(this.currentUID,this.GroupUID,this.content,);

}
class EventGroupSendNewVoiceMessage extends GroupEvent {

  final String currentUID;
  final String peerUID;
  final String path;
  final int second;
  EventGroupSendNewVoiceMessage(this.currentUID,this.peerUID,this.path,this.second);

}