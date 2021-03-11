import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geen/app/api/issues_api.dart';
import 'package:flutter_geen/app/enums.dart';
import 'package:flutter_geen/app/res/cons.dart';
import 'package:flutter_geen/app/utils/convert.dart';
import 'package:flutter_geen/repositories/itf/widget_repository.dart';
import 'dart:convert';
import 'home_event.dart';
import 'home_state.dart';



class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final WidgetRepository repository;

  HomeBloc({@required this.repository});

  @override
  HomeState get initialState => WidgetsLoading();

  Color get activeHomeColor {

    if (state is WidgetsLoaded) {
      return Colors.grey;
    }
    return Color(Cons.tabColors[0]);
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is EventTabTap) {

      yield* _mapLoadWidgetToState();
    }
    if (event is EventCheckUser) {

      var user=event.user;
      List<dynamic> users =state.props.elementAt(2);
      var status = event.status;
      try {
        var newUsers= users.where((element) =>
        element['memberId'] != user['memberId']
        ).toList();
        String reason;
        String checked;
        String score;
        String type;
       if(status ==1){
         reason="，已拒绝该用户";checked="3";score="-1";type="1";
       }
        if(status ==2){
          reason="，颜值100分";  checked="2";score="100";type="4";
        }
        if(status ==3){
          reason="，颜值80分";  checked="2";score="80";type="3";
        }
        if(status ==4){
          reason="，颜值60分";  checked="2";score="60";type="2";
        }
        if(status ==5){
          reason="，已隐藏该用户";  checked="10";score="-2";type="5";
        }

        var result= await IssuesApi.checkUser(user['memberId'].toString(), checked,type,score);
        if  (result['code']==200){


        } else{

        }



        yield CheckUserSuccess(photos: newUsers,Reason:reason);
      } catch (err) {
        print(err);
        yield WidgetsLoadFailed();
      }

    }

    if (event is EventResetCheckUser) {

      var user=event.user;
      List<dynamic> users =state.props.elementAt(2);
      var status = event.status;
      try {
        var newUsers= users.where((element) =>
        element['memberId'] != user['memberId']
        ).toList();
        String reason;
        String checked;
        String score;
        String type;
        reason="已撤回该用户"; checked="1";score="60";type="6";


      var result= await IssuesApi.checkUser(user['memberId'].toString(), checked,type,score);
      if  (result['code']==200){


      } else{

      }


        yield CheckUserSuccess(photos: newUsers,Reason:reason);
      } catch (err) {
        print(err);
        yield WidgetsLoadFailed();
      }

    }

    if (event is EventDelImg) {

      var img=event.user;
      List<dynamic> oldUsers = state.props.elementAt(2);
      var newUserBond=jsonDecode(jsonEncode(oldUsers));
      var status = event.status;
      try {
        var newUsers= newUserBond.map((item) {
          if(item['memberId'] == img['memberId']){
            List<dynamic>  images = item['imageurl'];
            var items= images.where((element) =>
            element['imgId'] != img['imgId']
            ).toList();
            item['imageurl']=items;
            return item;
          }else{
            return item;
          }

        }).toList();
        var result= await IssuesApi.delPhoto(img['imgId'].toString());
        if  (result['code']==200){


        } else{

        }
        yield DelImgSuccess(photos: newUsers);
      } catch (err) {
        print(err);
        yield WidgetsLoadFailed();
      }

    }
    if (event is EventGetCreditId) {


      try {

        yield DelImgSuccess(photos: state.props.elementAt(2));
      } catch (err) {
        print(err);
        yield WidgetsLoadFailed();
      }

    }
    if (event is EventLoadMore) {
       var data =event.user01;
       var count = state.props.elementAt(1);
      yield WidgetsLoaded(photos: data,count: count);

    }
    if (event is EventFresh) {
      try {

        var result= await IssuesApi.searchErpUser('', '1',event.sex.toString(),event.mode.toString(),event.search,event.showAge,event.maxAge,event.minAge,event.serveType);
        if  (result['message']=="Unauthenticated.") {
          yield Unauthenticated();
        }else{
          if  (result['code']==200){


          } else{

          }
        }

        yield WidgetsLoaded(photos: result['data']['data'],count:result['data']['total'].toString() );

      } catch (err) {
        print(err);
        yield WidgetsLoadFailed();
      }

    }
    if (event is EventSearchErpUser) {
      try {

        var result= await IssuesApi.searchErpUser('', '1',event.sex.toString(),event.mode.toString(),event.search,event.showAge,event.maxAge,event.minAge,event.serveType);
        if  (result['message']=="Unauthenticated.") {
          yield Unauthenticated();
        }else{
          if  (result['code']==200){


          } else{

          }
        }

        yield WidgetsLoaded(photos: result['data']['data'],count:result['data']['total'].toString());

      } catch (err) {
        print(err);
        yield WidgetsLoadFailed();
      }

    }
  }

  Stream<HomeState> _mapLoadWidgetToState() async* {
    yield WidgetsLoading();
    try {

      var result= await IssuesApi.getPhoto('', '1','1','0');
      if  (result['message']=="Unauthenticated.") {
        yield Unauthenticated();
      }else{
        if  (result['code']==200){


        } else{

        }
      }


      yield WidgetsLoaded(photos: result['data']['data'],count:result['data']['total'].toString());

    } catch (err) {
      print(err);
      yield WidgetsLoadFailed();
    }
  }

}
