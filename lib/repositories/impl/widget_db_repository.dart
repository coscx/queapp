
import 'package:flutter_geen/storage/app_storage.dart';
import 'package:flutter_geen/app/enums.dart';
import 'package:flutter_geen/storage/dao/node_dao.dart';

import 'package:flutter_geen/storage/po/widget_po.dart';
import 'package:flutter_geen/storage/dao/widget_dao.dart';
import 'package:flutter_geen/model/node_model.dart';
import 'package:flutter_geen/model/widget_model.dart';
import 'package:flutter_geen/repositories/itf/widget_repository.dart';

/// 说明 : Widget数据仓库

class WidgetDbRepository implements WidgetRepository {
  final AppStorage storage;

  WidgetDao _widgetDao;
  NodeDao _nodeDao;

  WidgetDbRepository(this.storage) {
    _widgetDao = WidgetDao(storage);
    _nodeDao = NodeDao(storage);
  }

  @override
  Future<List<WidgetModel>> loadWidgets(WidgetFamily family) async {
    List<Map<String, dynamic>> data = await _widgetDao.queryByFamily(family);
    List<WidgetPo> widgets = data.map((e) => WidgetPo.fromJson(e)).toList();
    return widgets.map(WidgetModel.fromPo).toList();
  }

  @override
  Future<List<WidgetModel>> loadCollectWidgets() async {
    List<Map<String, dynamic>> data = await _widgetDao.queryCollect();
    List<WidgetPo> widgets = data.map((e) => WidgetPo.fromJson(e)).toList();
    List<WidgetModel> list = widgets.map(WidgetModel.fromPo).toList();
    return list;
  }

  @override
  Future<List<WidgetModel>> searchWidgets(SearchArgs args) async {
    List<Map<String, dynamic>> data = await _widgetDao.search(args);
    List<WidgetPo> widgets = data.map((e) => WidgetPo.fromJson(e)).toList();
    return widgets.map(WidgetModel.fromPo).toList();
  }

  @override
  Future<List<NodeModel>> loadNode(WidgetModel widgetModel) async {
    List<Map<String, dynamic>> data = await _nodeDao.queryById(widgetModel.id);
    List<NodeModel> nodes = data.map((e) => NodeModel.fromJson(e)).toList();
    return nodes;
  }

  @override
  Future<List<WidgetModel>> loadWidget(List<int> id) async {
    List<Map<String, dynamic>> data = await _widgetDao.queryByIds(id);
    List<WidgetPo> widgets = data.map((e) => WidgetPo.fromJson(e)).toList();
    if (widgets.length > 0) return widgets.map(WidgetModel.fromPo).toList();
    return null;
  }

  @override
  Future<void> toggleCollect(
    int id,
  ) {
    return _widgetDao.toggleCollect(id);
  }


  @override
  Future<bool> collected(int id) async{
    return  await _widgetDao.collected(id);
  }
}
