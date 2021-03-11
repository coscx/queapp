import 'package:equatable/equatable.dart';
import 'package:flt_im_plugin/message.dart';


/// 说明: 主页状态类

abstract class GroupState extends Equatable {
  const GroupState();

  @override
  List<Object> get props => [];
}

class GroupInital extends GroupState {
  const GroupInital();

  @override
  List<Object> get props => [];
}

class GroupMessageSuccess extends GroupState {

  final List<Message> messageList;
  final String currentConvId;

  const GroupMessageSuccess(this.messageList,this.currentConvId);
  @override
  List<Object> get props => [messageList,currentConvId];
}
class LoadMoreGroupMessageSuccess extends GroupState {

  final List<Message> messageList;
  final bool noMore;
  const LoadMoreGroupMessageSuccess(this.messageList,this.noMore);
  @override
  List<Object> get props => [messageList,noMore];
}
class GetGroupFailed extends GroupState {
  const GetGroupFailed();

  @override
  List<Object> get props => [];
}