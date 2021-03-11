import 'package:equatable/equatable.dart';
import 'package:flutter_geen/model/category_model.dart';
import 'package:flutter_geen/model/widget_model.dart';


class CategoryState extends Equatable{
  @override
  List<Object> get props => [];

}

class CategoryLoadedState extends CategoryState {
  final List<CategoryModel> categories;

  CategoryLoadedState(this.categories);
  List<Object> get props => [categories];

}

class CategoryEmptyState extends CategoryState{
  List<Object> get props => [];
}


class AddCategorySuccess extends CategoryState{

}


class AddCategoryFailed extends CategoryState{

}
