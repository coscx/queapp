import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geen/app/res/style/unit_color.dart';
import 'package:flutter_geen/app/utils/color_utils.dart';
import 'package:flutter_geen/repositories/itf/category_repository.dart';
import 'package:flutter_geen/storage/po/category_po.dart';

import 'category_event.dart';
import 'category_state.dart';


class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository repository;

  CategoryBloc({@required this.repository});

  @override
  CategoryState get initialState => CategoryEmptyState(); //初始状态

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is EventLoadCategory) {
      final category = await repository.loadCategories();
      yield category.isEmpty
          ? CategoryEmptyState()
          : CategoryLoadedState(category);
    }

    if (event is EventDeleteCategory) {
      await repository.deleteCategory(event.id);
      add(EventLoadCategory());
    }
    if (event is EventToggleWidget) {
      await repository.toggleCategory(event.categoryId, event.widgetId);
      add(EventLoadCategory());
    }

    if (event is EventAddCategory) {
      CategoryPo categoryPo = CategoryPo(
          name: event.name,
          color: event.color ??
              ColorUtils.colorString(UnitColor.collectColorSupport[0]),
          info: event.info ?? '这里什么都没有...',
          created: DateTime.now(),
          updated: DateTime.now());

      final success = await repository.addCategory(categoryPo);

      if (success) {
        yield AddCategorySuccess();
        add(EventLoadCategory());
      } else {
        yield AddCategoryFailed();
      }
    }

    if (event is EventUpdateCategory) {
      CategoryPo categoryPo = CategoryPo(
          id: event.id,
          name: event.name,
          priority: event.priority ?? 0,
          image: event.image ?? '',
          color: event.color ?? ColorUtils.colorString(UnitColor.collectColorSupport[0]),
          info: event.info ?? '这里什么都没有...',
          updated: DateTime.now());

      final success = await repository.updateCategory(categoryPo);

      if (success) {
//        yield AddCategorySuccess();
        add(EventLoadCategory());
      } else {
//        yield AddCategoryFailed();
      }
    }
  }
}
