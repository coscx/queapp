import 'package:equatable/equatable.dart';
import 'package:flt_im_plugin/conversion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geen/app/enums.dart';
import 'package:flutter_geen/model/widget_model.dart';

/// 说明: 主页状态类

abstract class ChatState {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInital extends ChatState {
  const ChatInital();

  @override
  List<Object> get props => [];
}

class ChatMessageSuccess extends ChatState {
  const ChatMessageSuccess(this.message);
  final List<Conversion> message;
  @override
  List<Object> get props => [message];
}

class GetChatFailed extends ChatState {
  const GetChatFailed();

  @override
  List<Object> get props => [];
}