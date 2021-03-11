

import 'package:flutter/material.dart';
import 'package:flutter_geen/app/api/issues_api.dart';
import 'package:flutter_geen/app/utils/convert.dart';
import 'package:flutter_geen/repositories/itf/widget_repository.dart';

import 'search_event.dart';
import 'search_state.dart';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:convert';
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final WidgetRepository repository;

  SearchBloc({@required this.repository});
  @override
  SearchState get initialState => SearchStateNoSearch();//初始状态


  @override
  Stream<SearchState> transformEvents(
      Stream<SearchEvent> events,
      Stream<SearchState> Function(SearchEvent event) next,) {
    return super.transformEvents(events
        .debounceTime(Duration(milliseconds: 500),),
      next,
    );
  }

  @override
  Stream<SearchState> mapEventToState(SearchEvent event,) async* {


    if (event is EventCheckUsers) {

      var user=event.user;
      List<dynamic> users =state.props.elementAt(1);
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
        yield CheckUserSuccesses(widgets: state.props.elementAt(0),photos: newUsers,Reason:reason);
      } catch (err) {
        print(err);

      }

    }

    if (event is EventResetCheckUsers) {

      var user=event.user;
      List<dynamic> users =state.props.elementAt(1);
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


        yield CheckUserSuccesses(widgets: state.props.elementAt(0),photos: newUsers,Reason:reason);
      } catch (err) {
        print(err);

      }

    }

    if (event is EventDelImgs) {

      var img=event.user;
      List<dynamic> oldUsers = state.props.elementAt(1);
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
        yield DelImgSuccesses(widgets: state.props.elementAt(0),photos: newUsers);
      } catch (err) {
        print(err);

      }

    }


    if (event is EventLoadMoreUser) {
      String word =state.props.elementAt(1);
      var data =event.user010;
      yield   SearchStateSuccess(data,word);

    }
    if (event is EventClearPage) {

      yield   SearchStateSuccess([],'');

    }
    if (event is EventTextChanged) {

      if (event.args.name.isEmpty&&event.args.stars.every((e)=>e==-1)) {
        yield SearchStateNoSearch();
      } else {
        yield SearchStateLoading();
        try {
          String word =event.args.name;
          var key=event.args.name;
          if (key==null){
            key="";
          }
          if(key==""){
            //yield SearchStateNoSearch();
            //return;
          }
          var result= await IssuesApi.searchPhoto(event.args.name, '1');
          if  (result['code']==200){


          } else{

          }
          if(result['data']['data'].length==0){
            yield SearchStateEmpty();
          }else{
            yield   SearchStateSuccess(result['data']['data'],word);
          }

          print('mapEventToState');
        } catch (error) {
          print(error);
          yield  SearchStateError();
        }
      }
    }




  }
}