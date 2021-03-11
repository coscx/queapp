import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geen/app/api/issues_api.dart';
import 'package:flutter_geen/model/widget_model.dart';
import 'package:flutter_geen/repositories/itf/widget_repository.dart';
import 'dart:convert';
import 'detail_event.dart';
import 'detail_state.dart';
import 'package:flutter_geen/storage/dao/local_storage.dart';


class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final WidgetRepository repository;

  DetailBloc({@required this.repository});

  @override
  DetailState get initialState => DetailLoading();

  @override
  Stream<DetailState> mapEventToState(DetailEvent event) async* {
    if (event is FetchWidgetDetail) {
      yield* _mapLoadWidgetToState(event.photo);
    }
    if(event is ResetDetailState){
      yield DetailLoading();
    }
    if(event is FreshDetailState){
      var result= await IssuesApi.getUserDetail(event.photo['uuid'].toString());
      if  (result['code']==200){

      } else{

      }

      var resultConnectList= await IssuesApi.getConnectList(event.photo['uuid'].toString(),"1");
      if  (resultConnectList['code']==200){

      } else{

      }

      var appointList= await IssuesApi.getAppointmentList(event.photo['uuid'].toString(),"1");
      if  (appointList['code']==200){

      } else{

      }

      if(result['data'].isEmpty){
        yield DetailEmpty();
      }else{
        yield DetailWithData(userdetails: result['data'],connectList: resultConnectList['data'],appointList:appointList['data']);
      }
    }
    if(event is EditDetailEventAddress){
      Map<String ,dynamic> userdetails=state.props.elementAt(0);
      Map<String ,dynamic> connectList=state.props.elementAt(1);
      Map<String ,dynamic> appointList=state.props.elementAt(2);
      //Map<String ,dynamic>  info = userdetails['info'];
      //if (event.value is int)
      Map<String ,dynamic> result = Map.from(userdetails);
      if(event.type==1){
        result['info']['np_province_code']=event.result.provinceId;
        result['info']['np_province_name']=event.result.provinceName;
        result['info']['np_city_code']=event.result.cityId;
        result['info']['np_city_name']=event.result.cityName;
        result['info']['np_area_code']=event.result.areaId;
        result['info']['np_area_name']=event.result.areaName;
        result['info']['native_place']=event.result.provinceName+event.result.cityName+event.result.areaName;

      }else{
        result['info']['lp_province_code']=event.result.provinceId;
        result['info']['lp_province_name']=event.result.provinceName;
        result['info']['lp_city_code']=event.result.cityId;
        result['info']['lp_city_name']=event.result.cityName;
        result['info']['lp_area_code']=event.result.areaId;
        result['info']['lp_area_name']=event.result.areaName;
        result['info']['location_place']=event.result.provinceName+event.result.cityName+event.result.areaName;
      }

      yield DetailWithData(userdetails: result,connectList: connectList,appointList:appointList);

    }
    if(event is EditDetailEvent){
         Map<String ,dynamic> userdetails=state.props.elementAt(0);
         Map<String ,dynamic> connectList=state.props.elementAt(1);
         Map<String ,dynamic> appointList=state.props.elementAt(2);
         //Map<String ,dynamic>  info = userdetails['info'];
         //if (event.value is int)
         Map<String ,dynamic> result = Map.from(userdetails);
         result['info'][event.key] =event.value;
        yield DetailWithData(userdetails: result,connectList: connectList,appointList:appointList);

    }
    if(event is AddConnectEvent){
      Map<String ,dynamic> userdetails=state.props.elementAt(0);
      Map<String ,dynamic> connectList=state.props.elementAt(1);
      Map<String ,dynamic> appointList=state.props.elementAt(2);
      Map<String ,dynamic> result = Map.from(connectList);
      List<dynamic> res = result['data'];
      Map<String ,dynamic> connect ={};
      var name = await LocalStorage.get("name");
      var userName =name.toString();
      if(userName == "" || userName == null || userName == "null"){
        userName="";
      }
      connect['id'] = 0;
      connect['username'] = userName;
      connect['connect_type'] = event.connect_type;
      connect['connect_status'] = event.connect_status;
      connect['connect_time'] = event.connect_time;
      connect['subscribe_time'] = event.subscribe_time;
      connect['connect_message'] = event.connect_message;
      connect['customer_uuid'] = event.photo['uuid'];
      res=res.reversed.toList();
      res.add(connect);
      result['data']=res.reversed.toList();

      var resultConnectList= await IssuesApi.addConnect(event.photo['uuid'],connect);

      yield DetailWithData(userdetails: userdetails,connectList: result,appointList:appointList);

    }
    if(event is AddAppointEvent){
      Map<String ,dynamic> userdetails=state.props.elementAt(0);
      Map<String ,dynamic> connectList=state.props.elementAt(1);
      Map<String ,dynamic> appointList=state.props.elementAt(2);
      Map<String ,dynamic> result = Map.from(appointList);
      List<dynamic> res = result['data'];
      Map<String ,dynamic> connect ={};
      var name = await LocalStorage.get("name");
      var userName =name.toString();
      if(userName == "" || userName == null || userName == "null"){
        userName="";
      }
      connect['id'] = 0;
      connect['username'] = userName;
      connect['other_name'] =event.other_name;
      connect['other_uuid'] = event.other_uuid;
      connect['appointment_time'] = event.appointment_time;
      connect['appointment_address'] = event.appointment_address;
      connect['remark'] = event.remark;
      connect['address_lat'] = event.address_lat;
      connect['address_lng'] = event.address_lng;
      connect['customer_uuid'] = event.photo['uuid'];
      res=res.reversed.toList();
      res.add(connect);
      result['data']=res.reversed.toList();

      var resultConnectList= await IssuesApi.addAppoint(event.photo['uuid'],connect);

      yield DetailWithData(userdetails: userdetails,connectList: connectList,appointList:result);

    }
    if(event is UploadImgSuccessEvent){
      String imgUrl="https://queqiaoerp.oss-cn-shanghai.aliyuncs.com/"+event.value;
      Map<String ,dynamic> userdetails=state.props.elementAt(0);
      Map<String ,dynamic> connectList=state.props.elementAt(1);
      Map<String ,dynamic> appointList=state.props.elementAt(2);
      Map<String ,dynamic> result = Map.from(userdetails);
      //List<Map<String ,dynamic>>   ss = userdetails['pics'];
      Map<String ,dynamic> img ={};
      img["file_url"] =imgUrl;
      img["id"] = 0;
      img["customer_id"] = 0;
      userdetails['pics'].add(img);

      yield DetailWithData(userdetails: result,connectList: connectList,appointList:appointList);

    }

    if(event is EditDetailEventString){
      Map<String ,dynamic> userdetails=state.props.elementAt(0);
      Map<String ,dynamic> connectList=state.props.elementAt(1);
      Map<String ,dynamic> appointList=state.props.elementAt(2);
      //Map<String ,dynamic>  info = userdetails['info'];
      //if (event.value is int)
      Map<String ,dynamic> result = Map.from(userdetails);
      result['info'][event.key] =event.value;
      yield DetailWithData(userdetails: result,connectList: connectList,appointList:appointList);

    }
    if(event is EventDelDetailImg){
      var result1= await IssuesApi.delPhoto(event.img['id'].toString());
      if  (result1['code']==200){
            Map<String ,dynamic> userdetails=state.props.elementAt(0);
            Map<String ,dynamic> connectList=state.props.elementAt(1);
            Map<String ,dynamic> appointList=state.props.elementAt(2);
            List<dynamic> res = userdetails['pics'];
            var imgR=  res.map((e) {
              if (e['id']==event.img['id']){

              }else{
                return e;
              }

            }).toList();
            if (imgR == null){

            }
            userdetails['pics']=imgR;
            yield DetailWithData(userdetails: userdetails,connectList: connectList,appointList:appointList);

      } else{
        Map<String ,dynamic> userdetails=state.props.elementAt(0);
        Map<String ,dynamic> connectList=state.props.elementAt(1);
        Map<String ,dynamic> appointList=state.props.elementAt(3);
        yield DelSuccessData(userdetails: userdetails,connectList: connectList,appointList:appointList,reason:result1['message']);
      }


    }

  }

  Stream<DetailState> _mapLoadWidgetToState(
      Map<String,dynamic> photo) async* {
    yield DetailLoading();
    try {

      var result= await IssuesApi.getUserDetail(photo['uuid'].toString());
      if  (result['code']==200){

      } else{

      }

      var resultConnectList= await IssuesApi.getConnectList(photo['uuid'].toString(),"1");
      if  (resultConnectList['code']==200){

      } else{

      }

      var appointList= await IssuesApi.getAppointmentList(photo['uuid'].toString(),"1");
      if  (appointList['code']==200){

      } else{

      }

      if(result['data'].isEmpty){
        yield DetailEmpty();
      }else{
        yield DetailWithData(userdetails: result['data'],connectList: resultConnectList['data'],appointList:appointList['data']);
      }

    } catch (e) {
      yield DetailFailed();
    }
  }
}
