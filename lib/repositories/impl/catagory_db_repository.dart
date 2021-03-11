import 'package:flutter_geen/model/category_model.dart';
import 'package:flutter_geen/model/widget_model.dart';
import 'package:flutter_geen/repositories/itf/category_repository.dart';
import 'package:flutter_geen/storage/app_storage.dart';
import 'package:flutter_geen/storage/dao/category_dao.dart';
import 'package:flutter_geen/storage/po/category_po.dart';
import 'package:flutter_geen/storage/po/widget_po.dart';


/// 说明:

class CategoryDbRepository implements CategoryRepository {
  final AppStorage storage;

  CategoryDao _categoryDao;

  CategoryDbRepository(this.storage) {
    _categoryDao = CategoryDao(storage);
  }

  @override
  Future<bool> addCategory(CategoryPo categoryPo) async {
    int success = await _categoryDao.insert(categoryPo);
    return success != -1;
  }

  @override
  Future<bool> check(int categoryId, int widgetId) async {
    return await _categoryDao.existWidgetInCollect(categoryId, widgetId);
  }

  @override
  Future<void> deleteCategory(int id) async {
    await _categoryDao.deleteCollect(id);
  }

  @override
  Future<List<CategoryModel>> loadCategories() async {
    List<Map<String, dynamic>> data = await _categoryDao.queryAll();
    List<CategoryPo> collects = data.map((e) => CategoryPo.fromJson(e)).toList();
    return collects.map(CategoryModel.fromPo).toList();
  }

  @override
  Future<List<WidgetModel>> loadCategoryWidgets({int categoryId = 0}) async {
    List<Map<String, dynamic>> rawData = await _categoryDao.loadCollectWidgets(categoryId);
    List<WidgetPo> widgets = rawData.map((e) => WidgetPo.fromJson(e)).toList();
    return widgets.map(WidgetModel.fromPo).toList();
  }

  @override
  Future<void> toggleCategory(int categoryId, int widgetId) async {
    return await _categoryDao.toggleCollect( categoryId,  widgetId);
  }

  @override
  Future<List<int>> getCategoryByWidget(int widgetId) async {
    return await _categoryDao.categoryWidgetIds(widgetId);
  }

  @override
  Future<bool> updateCategory(CategoryPo categoryPo) async{
    int success = await _categoryDao.update(categoryPo);
    return success != -1;
  }

//
//  @override
//  Future<List<WidgetModel>> loadCollectWidgets({int collectId = 0}) async {
//
//
//
//  }
//
//  @override
//  Future<bool> checkCollected(int collectId, int widgetId) async {
//
//  }
}
