import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geen/app/api/issues_api.dart';
import 'package:flutter_geen/storage/app_storage.dart';
import 'package:flutter_geen/app/res/cons.dart';
import 'package:flutter_geen/app/res/sp.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'global_event.dart';
import 'global_state.dart';


/// 说明: 全局信息的bloc

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  @override
  GlobalState get initialState => GlobalState();

  final AppStorage storage;

  GlobalBloc(this.storage);

  Future<SharedPreferences> get sp => storage.sp;

  @override
  Stream<GlobalState> mapEventToState(GlobalEvent event) async* {
    // 程序初始化事件处理: 使用AppStorage进行初始化
    if (event is EventInitApp) {
      yield await storage.initApp();
    }

    // 切换字体事件处理 : 固化索引 + 产出新状态
    if (event is EventSwitchFontFamily) {
      int familyIndex = Cons.fontFamilySupport.indexOf(event.family);
      await sp
        ..setInt(SP.fontFamily, familyIndex);
      yield state.copyWith(fontFamily: event.family);
    }

    // 切换主题色事件处理 : 固化索引 + 产出新状态
    if (event is EventSwitchThemeColor) {
      int themeIndex =
      Cons.themeColorSupport.keys.toList().indexOf(event.color);
      await sp
        ..setInt(SP.themeColorIndex, themeIndex);
      yield state.copyWith(themeColor: event.color);
    }

    // 切换背景显示事件处理 : 固化数据 + 产出新状态
    if (event is EventSwitchShowBg) {
      await sp
        ..setBool(SP.showBackground, event.show);
      yield state.copyWith(showBackGround: event.show);
    }

    // 切换背景显示事件处理 : 产出新状态
    if (event is EventSwitchShowOver) {
      yield state.copyWith(showPerformanceOverlay: event.show);
    }

    // 切换code样式事件处理 : 固化索引 + 产出新状态
    if (event is EventSwitchCoderTheme) {
      await sp
        ..setInt(SP.codeStyleIndex, event.codeStyleIndex);
      yield state.copyWith(codeStyleIndex: event.codeStyleIndex);
    }

    // 切换item样式事件处理 : 固化索引 + 产出新状态
    if (event is EventChangeItemStyle) {
      await sp
        ..setInt(SP.itemStyleIndex, event.index);
      yield state.copyWith(itemStyleIndex: event.index);
    }

    // 首页图片审核分页当前第几页
    if (event is EventIndexPhotoPage) {
      var page = event.page;
      page++;
      yield state.copyWith(indexPhotoPage: page);
    }
    // 首页图片审核分页当前第几页
    if (event is EventSearchPhotoPage) {
      var page = event.page;
      page++;
      yield state.copyWith(indexSearchPage: page);
    }
    if (event is EventSetBar1) {
      var page = event.memberId;
      yield state.copyWith(bar1: page);
    }
    if (event is EventSetBar2) {
      var page = event.memberId;
      yield state.copyWith(bar2: page);
    }
    if (event is EventSetBar3) {
      var page = event.memberId;
      yield state.copyWith(bar3: page);
    }
    if (event is EventSetBar4) {
      var page = event.memberId;
      yield state.copyWith(bar4: page);
    }
    // 首页图片审核分页当前第几页
    if (event is EventResetIndexPhotoPage) {
      yield state.copyWith(indexPhotoPage: 1);
    }
    if (event is EventSetIndexSex) {
      var sex = event.sex;
      yield state.copyWith(sex: sex);
    }
    if (event is EventSetMemberId) {
      var memberId = event.memberId;
      yield state.copyWith(memberId: memberId);
    }
    if (event is EventSetCreditId) {
      var creditId = event.creditId;
      yield state.copyWith(creditId: creditId);
    }
    if (event is EventSetIndexMode) {
      var mode = event.mode;
      yield state.copyWith(currentPhotoMode: mode);
    }
    // 首页头部数量
    if (event is EventSetIndexNum) {
      try {
        var result = await IssuesApi.getPhotoNum();
        if (result['code'] == 200) {


        } else {

        }
        List<String> lists=[];
        List<dynamic> list = result['data'];
         list.map((e)  {
           if(e is String){
             lists.add(e.toString());
           }

         }).toList();
        yield state.copyWith(headNum: lists);
      } catch (err) {
        print(err);
      }
    }
  }
}
