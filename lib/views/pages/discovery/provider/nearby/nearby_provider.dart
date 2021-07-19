import 'package:dio/dio.dart';
import 'package:flt_im_plugin/value_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_geen/net/dio_utils.dart';
import 'package:flutter_geen/net/http_api.dart';
import 'package:flutter_geen/repositories/impl/net_work_repository.dart';

class NearByProvider extends ChangeNotifier {


  String tfSender;

  NearByProvider(Map params) {
    tfSender = ValueUtil.toStr(params['currentUID']);
    loadConversions();
  }

  loadConversions() async {
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
          tfSender = user['msg'];
          //sprintf("s%",data);
        }, onError: (code,data){
          //sprintf("s%",data);
          print(code);
          print(data);
        }
    );
    notifyListeners();
  }


}
