import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:flt_im_plugin/message.dart';




abstract class PeerEvent extends Equatable {

  @override
  List<Object> get props => [];
}


class EventFirstLoadMessage extends PeerEvent {
  final String currentUID;
  final String peerUID;
  EventFirstLoadMessage(this.currentUID,this.peerUID);

}
class EventDeleteMessage extends PeerEvent {
  final String currentUID;
  EventDeleteMessage(this.currentUID);
}
class EventLoadMoreMessage extends PeerEvent {

}

class EventReceiveNewMessage extends PeerEvent {
  final Map<String,dynamic> message;
  EventReceiveNewMessage(this.message);

}
class EventReceiveNewMessageAck extends PeerEvent {
  final Map<String,dynamic> message;
  EventReceiveNewMessageAck(this.message);

}
class EventSendNewMessage extends PeerEvent {

  final String currentUID;
  final String peerUID;
  final String content;
  EventSendNewMessage(this.currentUID,this.peerUID,this.content,);

}

class EventSendNewImageMessage extends PeerEvent {

  final String currentUID;
  final String peerUID;
  final Uint8List content;
  EventSendNewImageMessage(this.currentUID,this.peerUID,this.content,);

}
class EventSendNewVoiceMessage extends PeerEvent {

  final String currentUID;
  final String peerUID;
  final String path;
  final int second;
  EventSendNewVoiceMessage(this.currentUID,this.peerUID,this.path,this.second);

}