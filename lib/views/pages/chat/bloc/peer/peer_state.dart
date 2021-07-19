import 'package:equatable/equatable.dart';
import 'package:flt_im_plugin/message.dart';


/// 说明: 主页状态类

abstract class PeerState extends Equatable {
  const PeerState();

  @override
  List<Object> get props => [];
}

class PeerInital extends PeerState {
  const PeerInital();

  @override
  List<Object> get props => [];
}

class PeerMessageSuccess extends PeerState {

  final List<Message> messageList;
  final String currentConvId;

  const PeerMessageSuccess(this.messageList,this.currentConvId);
  @override
  List<Object> get props => [messageList,currentConvId];
}
class LoadMorePeerMessageSuccess extends PeerState {

  final List<Message> messageList;
  final bool noMore;
  const LoadMorePeerMessageSuccess(this.messageList,this.noMore);
  @override
  List<Object> get props => [messageList,noMore];
}
class GetPeerFailed extends PeerState {
  const GetPeerFailed();

  @override
  List<Object> get props => [];
}