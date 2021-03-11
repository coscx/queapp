

import 'package:equatable/equatable.dart';
import 'package:flutter_geen/model/widget_model.dart';

abstract class SearchState extends Equatable{//基态
  const SearchState();
  @override
  List<Object> get props => [];
}

class SearchStateNoSearch extends SearchState {}//无搜索状态

class SearchStateEmpty extends SearchState {}//结果为空

class SearchStateLoading extends SearchState {}//加载中
class SearchStateError extends SearchState {}//异常

class SearchStateSuccess extends SearchState {//有结果
  final List<dynamic>  photos ;
  final String word ;
  const SearchStateSuccess(this.photos,this.word);
  @override
  List<Object> get props => [ photos,word];

  @override
  String toString() {
    return 'WidgetsLoaded{widgets: }';
  }
}
class CheckUserSuccesses extends SearchState {
  final List<WidgetModel> widgets;
  final List<dynamic>  photos ;
  final String Reason;
  const CheckUserSuccesses(
      { this.widgets = const [],this.photos,this.Reason});

  @override
  List<Object> get props => [ widgets,photos];

  @override
  String toString() {
    return 'WidgetsLoaded{widgets: $widgets}';
  }
}

class DelImgSuccesses extends SearchState {
  final List<WidgetModel> widgets;

  final List<dynamic>  photos ;


  const DelImgSuccesses(
      { this.widgets = const [],this.photos});

  @override
  List<Object> get props => [ widgets,photos];

  @override
  String toString() {
    return 'WidgetsLoaded{widgets: $widgets}';
  }
}