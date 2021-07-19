import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_geen/net/dio_utils.dart';
import 'package:flutter_geen/net/http_api.dart';
import 'package:flutter_geen/repositories/impl/net_work_repository.dart';
import 'package:flutter_geen/views/pages/discovery/bloc/discovery_bloc_exp.dart';

import 'discovery_event.dart';
import 'discovery_state.dart';


class DiscoveryBloc extends Bloc<DiscoveryEvent, DiscoveryState> {
  DiscoveryBloc() : super(DiscoveryInitial());

  @override
  Stream<DiscoveryState> mapEventToState(
    DiscoveryEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is EventGetDiscoveryData) {
      Map<dynamic, dynamic> user;
      var dio =NetWorkRepository();

      FormData formData = FormData.fromMap({
        "codes": "await MultipartFile.fromFile(path, filename: name)"
      });
      await dio.requestNetwork<Map<dynamic, dynamic>>(Method.post,
          url: HttpApi.login,
          params: formData,
          onSuccess: (data){
            user = (data);
            print(user['msg']);
            //sprintf("s%",data);
          }, onError: (code,data){
            //sprintf("s%",data);
            print(code);
            print(data);
          }
      );
      yield DisMessageSuccess(user);

    }
  }

  @override
  // TODO: implement initialState
  DiscoveryState get initialState => DiscoveryInitial();
}
