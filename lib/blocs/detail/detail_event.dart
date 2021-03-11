import 'package:equatable/equatable.dart';
import 'package:flutter_geen/model/widget_model.dart';
import 'package:city_pickers/modal/result.dart';

/// 说明: 详情事件

abstract class DetailEvent extends Equatable {
  const DetailEvent();
  @override
  List<Object> get props => [];
}


class FetchWidgetDetail extends DetailEvent {
  final Map<String,dynamic> photo;
  const FetchWidgetDetail(this.photo);

  @override
  List<Object> get props => [photo];

  @override
  String toString() {
    return 'FetchWidgetDetail{widgetModel: }';
  }
}

class EditDetailEvent extends DetailEvent {
  final String key;
  final int value;
  const EditDetailEvent(this.key,this.value);
  @override
  List<Object> get props => [key,value];

  @override
  String toString() {
    return 'FetchWidgetDetail{widgetModel: }';
  }
}
class EditDetailEventAddress extends DetailEvent {
  final int type;
  final Result result;
  const EditDetailEventAddress(this.result,this.type);
  @override
  List<Object> get props => [result,type];

  @override
  String toString() {
    return 'FetchWidgetDetail{widgetModel: }';
  }
}
class EditDetailEventString extends DetailEvent {
  final String key;
  final String value;
  const EditDetailEventString(this.key,this.value);
  @override
  List<Object> get props => [key,value];

  @override
  String toString() {
    return 'FetchWidgetDetail{widgetModel: }';
  }
}
class ResetDetailState extends DetailEvent {

}
class UploadImgSuccessEvent extends DetailEvent {
  final Map<String,dynamic> photo;
  final String value;
  const UploadImgSuccessEvent(this.photo,this.value);

  @override
  List<Object> get props => [photo,value];

  @override
  String toString() {
    return 'FetchWidgetDetail{widgetModel: }';
  }
}
class AddConnectEvent extends DetailEvent {
  final int connect_type;
  final int connect_status;
  final String connect_time;
  final String subscribe_time;
  final String connect_message;
  final Map<String,dynamic> photo;
  const AddConnectEvent(this.photo,this.connect_message,this.connect_status,this.connect_time,this.connect_type,this.subscribe_time);

  @override
  List<Object> get props => [photo,connect_message,connect_status,connect_time,connect_type,subscribe_time];

  @override
  String toString() {
    return 'FetchWidgetDetail{widgetModel: }';
  }
}
class AddAppointEvent extends DetailEvent {
  final String other_uuid ;
  final String appointment_time ;
  final String appointment_address ;
  final String remark;
  final String address_lng ;
  final String address_lat ;
  final Map<String,dynamic> photo;
  final String other_name;
  const AddAppointEvent(this.photo,this.other_uuid,this.appointment_time,this.appointment_address,this.remark,this.address_lng,this.address_lat,this.other_name);

  @override
  List<Object> get props => [photo,other_uuid,appointment_time,appointment_address,remark,address_lng,address_lat,other_name];

  @override
  String toString() {
    return 'FetchWidgetDetail{widgetModel: }';
  }
}
class FreshDetailState extends DetailEvent {
  final Map<String,dynamic> photo;
  const FreshDetailState(this.photo);

  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'FetchWidgetDetail{widgetModel: }';
  }
}


class EventDelDetailImg extends DetailEvent {
  final Map<String,dynamic> img;
  final Map<String,dynamic> user;
  EventDelDetailImg(this.img,this.user);

}