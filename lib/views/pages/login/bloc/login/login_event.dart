import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geen/app/enums.dart';
import 'package:flutter_geen/storage/po/widget_po.dart';
import 'package:flutter_geen/model/widget_model.dart';



abstract class LoginEvent extends Equatable {

  @override
  List<Object> get props => [];
}

class EventLogin extends LoginEvent {
  final String username;
  final String password;
  EventLogin({this.username,this.password});
}
class EventWxLogin extends LoginEvent {
  final String code;
  EventWxLogin({this.code});
}
class EventLoginFailed extends LoginEvent {

}
