import 'package:flutter/material.dart';
import 'package:flutter_geen/views/pages/dynamic/widget/dynamic_item_widget.dart';

class DynamicPageProvider extends ChangeNotifier {

  /// 动态的下标
  int _index = 0;
  int get index => _index;

  /// 动态图片列表
  List<String> _dynamicImageList = [];
  List<String> get dynamicImageList => _dynamicImageList;

  void setIndex(int index) {
    _index = index;
    notifyListeners();
  }

  // 设置动态图片
  void setDynamicImageList(List<String> List) {
    _dynamicImageList = List;
    notifyListeners();
  }


}