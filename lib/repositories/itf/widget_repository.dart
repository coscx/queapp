

import 'package:flutter_geen/app/enums.dart';
import 'package:flutter_geen/storage/dao/widget_dao.dart';
import 'package:flutter_geen/model/node_model.dart';
import 'package:flutter_geen/model/widget_model.dart';


abstract class WidgetRepository {

  Future<List<WidgetModel>> loadWidgets(WidgetFamily family);

  Future<List<WidgetModel>> loadWidget(List<int> ids);

  Future<List<WidgetModel>> searchWidgets(SearchArgs args);
  Future<List<NodeModel>> loadNode(WidgetModel widgetModel);

  Future<void> toggleCollect(int id);

  Future<List<WidgetModel>> loadCollectWidgets();

  Future<bool> collected(int id);
}