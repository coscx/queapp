import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geen/app/enums.dart';
import 'package:flutter_geen/model/widget_model.dart';

/// 说明: 主页状态类

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class WidgetsLoading extends HomeState {
  const WidgetsLoading();

  @override
  List<Object> get props => [];
}

class WidgetsLoaded extends HomeState {
  final List<dynamic>  photos ;
  final String  count ;
  const WidgetsLoaded(
      {this.photos,this.count});

  @override
  List<Object> get props => [photos,count];

  @override
  String toString() {
    return 'WidgetsLoaded{widgets: $photos}';
  }
}
class WidgetsLoadmore extends HomeState {
  final List<WidgetModel> widgets;
  final WidgetFamily activeFamily;
  final List<dynamic>  photos ;

  const WidgetsLoadmore(
      {this.activeFamily, this.widgets = const [],this.photos});

  @override
  List<Object> get props => [activeFamily, widgets,photos];

  @override
  String toString() {
    return 'WidgetsLoaded{widgets: $widgets}';
  }
}
class WidgetsLoadFailed extends HomeState {
  const WidgetsLoadFailed();

  @override
  List<Object> get props => [];
}
class Unauthenticated extends HomeState {
  const Unauthenticated();

  @override
  List<Object> get props => [];
}

class CheckUserSuccess extends HomeState {
  final List<WidgetModel> widgets;
  final WidgetFamily activeFamily;
  final List<dynamic>  photos ;
  final String Reason;
  const CheckUserSuccess(
      {this.activeFamily, this.widgets = const [],this.photos,this.Reason});

  @override
  List<Object> get props => [activeFamily, widgets,photos];

  @override
  String toString() {
    return 'WidgetsLoaded{widgets: $widgets}';
  }
}

class DelImgSuccess extends HomeState {
  final List<WidgetModel> widgets;
  final WidgetFamily activeFamily;
  final List<dynamic>  photos ;
  final int photoCurrentPage ;

  const DelImgSuccess(
      {this.activeFamily, this.widgets = const [],this.photos,this.photoCurrentPage});

  @override
  List<Object> get props => [activeFamily, widgets,photos];

  @override
  String toString() {
    return 'WidgetsLoaded{widgets: $widgets}';
  }
}

class GetCreditIdSuccess extends HomeState {
  final List<WidgetModel> widgets;
  final WidgetFamily activeFamily;
  final List<dynamic>  photos ;
  final int photoCurrentPage ;

  const GetCreditIdSuccess(
      {this.activeFamily, this.widgets = const [],this.photos,this.photoCurrentPage});

  @override
  List<Object> get props => [activeFamily, widgets,photos];

  @override
  String toString() {
    return 'WidgetsLoaded{widgets: $widgets}';
  }
}