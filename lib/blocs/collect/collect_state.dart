import 'package:equatable/equatable.dart';
import 'package:flutter_geen/model/widget_model.dart';


class CollectState extends Equatable {
  final List<WidgetModel> widgets;

  CollectState({this.widgets});

  @override
  // TODO: implement props
  List<Object> get props => [widgets];
}
