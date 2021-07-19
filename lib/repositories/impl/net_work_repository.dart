
import 'package:dio/src/cancel_token.dart';
import 'package:dio/src/options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_geen/net/dio_utils.dart';
import 'package:flutter_geen/repositories/itf/net_repository.dart';

/// 说明 :网络代理

class NetWorkRepository implements NetRepository {
  CancelToken _cancelToken;

  NetWorkRepository() {
    _cancelToken = CancelToken();
  }
  @override
  void cancelRequest() {
    /// 销毁时，将请求取消
    if (!_cancelToken.isCancelled){
      _cancelToken.cancel();
    }
  }
  @override
  /// 返回Future 适用于刷新，加载更多
  Future requestNetwork<T>(Method method, {@required String url, bool isShow : true, bool isClose: true, Function(T t) onSuccess,
    Function(List<T> list) onSuccessList, Function(int code, String msg) onError, dynamic params,
    Map<String, dynamic> queryParameters, CancelToken cancelToken, Options options, bool isList : false}) async {
    //if (isShow) view.showProgress();
    await DioUtils.instance.requestNetwork<T>(method, url,
        params: params,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken?? _cancelToken,
        onSuccess: (data){
          //if (isClose) view.closeProgress();
          if (onSuccess != null) {
            onSuccess(data);
          }
        },
        onSuccessList: (data){
         // if (isClose) view.closeProgress();
          if (onSuccessList != null) {
            onSuccessList(data);
          }
        },
        onError: (code, msg){
          _onError(code, msg, onError);
        }
    );
  }

  @override

  void asyncRequestNetwork<T>(Method method, {@required String url, bool isShow : true, bool isClose: true, Function(T t) onSuccess, Function(List<T> list) onSuccessList, Function(int code, String msg) onError,
    dynamic params, Map<String, dynamic> queryParameters, CancelToken cancelToken, Options options, bool isList : false}){
    //if (isShow) view.showProgress();
    DioUtils.instance.asyncRequestNetwork<T>(method, url,
        params: params,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken?? _cancelToken,
        isList: isList,
        onSuccess: (data){
          //if (isClose) view.closeProgress();
          if (onSuccess != null) {
            onSuccess(data);
          }
        },
        onSuccessList: (data){
          //if (isClose) view.closeProgress();
          if (onSuccessList != null) {
            onSuccessList(data);
          }
        },
        onError: (code, msg){
          _onError(code, msg, onError);
        }
    );
  }
  _onError(int code, String msg, Function(int code, String msg) onError){
    /// 异常时直接关闭加载圈，不受isClose影响
    //view.closeProgress();
    // if (code != ExceptionHandle.cancel_error){
    //   view.showToast(msg);
    // }
    // /// 页面如果dispose，则不回调onError
    if (onError != null ) {
      onError(code, msg);
    }
  }

}
