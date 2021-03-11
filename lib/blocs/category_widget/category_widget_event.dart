import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';



abstract class CategoryWidgetEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class EventLoadCategoryWidget extends CategoryWidgetEvent{
  final int categoryId;

  EventLoadCategoryWidget(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}

class EventToggleCategoryWidget extends CategoryWidgetEvent{
  final int categoryId;
  final int widgetId;

  EventToggleCategoryWidget(this.categoryId,this.widgetId);

  @override
  List<Object> get props => [categoryId,widgetId];
}
