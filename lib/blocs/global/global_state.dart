import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// 说明: 全局状态类
///
class GlobalState extends Equatable {
  /// [fontFamily] 文字字体
  final String fontFamily;

  /// [themeColor] 主题色
  final MaterialColor themeColor;

  /// [showBackGround] 是否显示主页背景图
  final bool showBackGround;

  /// [codeStyleIndex] 代码样式 索引
  final int codeStyleIndex;

  /// [itemStyleIndex] 主页item样式 索引
  final int itemStyleIndex;

  /// [showPerformanceOverlay] 是否显示性能浮层
  final bool showPerformanceOverlay;

  /// [indexPhotoPage] 首页照片审核图
  final int indexPhotoPage;
  final int indexSearchPage;
  final int currentPhotoMode;
  /// [headNum] 首页照片审核图
  final List<String> headNum;
  final int sex;
  final String memberId;
  final int bar1;
  final int bar2;
  final int bar3;
  final int bar4;
  final String creditId;

  const GlobalState({
    this.fontFamily = 'ComicNeue',
    this.themeColor = Colors.blue,
    this.showBackGround = false,
    this.codeStyleIndex = 0,
    this.itemStyleIndex = 0,
    this.showPerformanceOverlay = false,
    this.indexPhotoPage =1,
    this.indexSearchPage = 1,
    this.headNum,
    this.sex=1,
    this.currentPhotoMode=0,
    this.memberId="0",
    this.bar1 =0,
    this.bar2 =0,
    this.bar3 =0,
    this.bar4 =0,
    this.creditId ="",
  });

  @override
  List<Object> get props => [
        fontFamily,
        themeColor,
        showBackGround,
        codeStyleIndex,
        itemStyleIndex,
        showPerformanceOverlay,
        indexPhotoPage,
        indexSearchPage,
        headNum,
        sex,
        currentPhotoMode,
        memberId,
        bar1,
        bar2,
        bar3,
        bar4,
        creditId
      ];

  GlobalState copyWith({
    double height,
    String fontFamily,
    MaterialColor themeColor,
    bool showBackGround,
    int codeStyleIndex,
    int itemStyleIndex,
    bool showPerformanceOverlay,
    int  indexPhotoPage,
    int  indexSearchPage,
    List<String> headNum,
    int sex,
    int currentPhotoMode,
    String memberId,
    int bar1,
    int bar2,
    int bar3,
    int bar4,
    String  creditId,
  }) =>
      GlobalState(
        fontFamily: fontFamily ?? this.fontFamily,
        themeColor: themeColor ?? this.themeColor,
        showBackGround: showBackGround ?? this.showBackGround,
        codeStyleIndex: codeStyleIndex ?? this.codeStyleIndex,
        itemStyleIndex: itemStyleIndex ?? this.itemStyleIndex,
        showPerformanceOverlay: showPerformanceOverlay ?? this.showPerformanceOverlay,
        indexPhotoPage:  indexPhotoPage ?? this.indexPhotoPage,
          indexSearchPage : indexSearchPage ?? this.indexSearchPage ,
          headNum:headNum??this.headNum,
          sex:sex??this.sex,
          currentPhotoMode:currentPhotoMode??this.currentPhotoMode,
          memberId: memberId?? this.memberId,
          bar1:bar1??this.bar1,
          bar2:bar2??this.bar2,
          bar3:bar3??this.bar3,
          bar4:bar4??this.bar4,
          creditId:creditId??this.creditId

      );

  @override
  String toString() {
    return 'GlobalState{fontFamily: $fontFamily, themeColor: $themeColor, showBackGround: $showBackGround, codeStyleIndex: $codeStyleIndex, itemStyleIndex: $itemStyleIndex, showPerformanceOverlay: $showPerformanceOverlay, indexPhotoPage: $indexPhotoPage, headNum: $headNum, sex: $sex,currentPhotoMode:$currentPhotoMode,memberId:$memberId}';
  }
}
