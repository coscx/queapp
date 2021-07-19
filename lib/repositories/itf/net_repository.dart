import 'package:dio/dio.dart';
import 'package:flutter_geen/net/dio_utils.dart';



abstract class NetRepository {
  cancelRequest();
  /// 返回Future 适用于刷新，加载更多
  Future requestNetwork<T>(Method method, { String url, bool isShow : true, bool isClose: true, Function(T t) onSuccess,
    Function(List<T> list) onSuccessList, Function(int code, String msg) onError, dynamic params,
    Map<String, dynamic> queryParameters, CancelToken cancelToken, Options options, bool isList : false});

  void asyncRequestNetwork<T>(Method method, { String url, bool isShow : true, bool isClose: true, Function(T t) onSuccess, Function(List<T> list) onSuccessList, Function(int code, String msg) onError,
    dynamic params, Map<String, dynamic> queryParameters, CancelToken cancelToken, Options options, bool isList : false});
}