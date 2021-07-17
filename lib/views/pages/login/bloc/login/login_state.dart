import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geen/app/enums.dart';
import 'package:flutter_geen/model/widget_model.dart';

/// 说明: 主页状态类

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}
class LoginInital extends LoginState {
  const LoginInital();

  @override
  List<Object> get props => [];
}
class LoginLoading extends LoginState {
  const LoginLoading();

  @override
  List<Object> get props => [];
}

class LoginSuccess extends LoginState {


  const LoginSuccess();

  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'WidgetsLoaded{widgets:}';
  }
}

class LoginFailed extends LoginState {

  String reason;
  LoginFailed({this.reason});

  @override
  List<Object> get props => [];
}
