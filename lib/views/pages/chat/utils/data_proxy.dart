/*
* 数据传输代理
*/
import 'package:flutter/widgets.dart';


class DataProxy {
  static final DataProxy _dataProxy = new DataProxy._init();
  BuildContext _context;


  static DataProxy build() {
    return _dataProxy;
  }

  DataProxy._init();



  /*
  * 启动与原生的交互
  */
  void connect(BuildContext context) {
    _context = context;

  }

/*
  * 断开与原生的交互
  */
  void unConnect() {

  }

  void _onEvent(Object event) {
    if (event == null || !(event is Map)) {
      return;
    }
    Map res = event;
    if (res.containsKey('string')) {
      if (res.containsValue('onConnected')) {
        //已连接
      } else if (res.containsValue('user_removed')) {
        //显示帐号已经被移除

      } else if (res.containsValue('user_login_another_device')) {
        //显示帐号在其他设备登录

      } else if (res.containsValue('disconnected_to_service')) {
        //连接不到聊天服务器
//        DialogUtil.buildToast('连接不到聊天服务器');
      } else if (res.containsValue('no_net')) {
        //当前网络不可用，请检查网络设置

      } else if (res.containsValue('onDestroy')) {
        //APP执行onDestroy
        unConnect();
      }
    } else if (res.containsKey('json')) {


    }
  }

  void _onError(Object error) {

  }
}
