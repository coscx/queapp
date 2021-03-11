import 'package:equatable/equatable.dart';
import 'package:flt_im_plugin/message.dart';
import 'package:flutter_geen/model/time_line_model_entity.dart';


/// 说明: 主页状态类

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitals extends UserState {
  const UserInitals();

  @override
  List<Object> get props => [];
}

class GetUserSuccess extends UserState {
  final Map<String,dynamic> user;
  const GetUserSuccess(this.user);
  @override
  List<Object> get props => [user];
}