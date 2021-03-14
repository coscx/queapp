import 'package:dio/dio.dart';
import 'package:flutter_geen/app/zpubhttp/constant/HttpKeyValueConstant.dart';
import 'package:flutter_geen/app/zpubhttp/constant/MessageConstant.dart';
import 'package:flutter_geen/app/zpubhttp/constant/WhatConstant.dart';
import 'package:flutter_geen/app/zpubhttp/method/TokenMethod.dart';
import 'dart:convert';

import 'package:flutter_geen/app/zpubhttp/uitl/CxTextUtil.dart';
import 'package:flutter_geen/app/zpubhttp/uitl/MapKeyConstant.dart';

import 'HttpListener.dart';
/*
 * 功能：接口服务基类：数据的聚合与分发<br/>
 * 网络返回后，数据分发到窗口层<br/>
 * 网络连接开始后，自动执行进度条的显示<br/>
 * 网络连接回调后，自动执行进度条的隐藏<br/>
 * 需要传入的键：
 * 传入的值类型：
 * 传入的值含义：
 * 是否必传 ：
 * 作者：郑朝军 on 2019/4/7 23:23
 * 邮箱：1250393285@qq.com
 * 公司：武汉智博创享科技有限公司
 */
class BaseService
{
  /*
   * 分发消息到窗口层<br/>
   * 自动控制ProgressBar的显示与隐藏<br/>
   */
  static void sendMessage(final String method, final dynamic data,
      final int what, final HttpListener listener, {bool progressBar = true})
  {
    if (data != MessageConstant.MSG_EMPTY)
    {
      switch (what)
      {
        case WhatConstant.WHAT_NET_DATA_SUCCESS:
          listener.onNetWorkSucceed(method, data);
          break;
        case WhatConstant.WHAT_NET_DATA_FAIL:
          listener.onNetWorkFaild(method, data);
          break;
        case WhatConstant.WHAT_DB_DATA_SUCCESS:
          listener.onDbSucceed(method, data);
          break;
        case WhatConstant.WHAT_DB_DATA_FAIL:
          listener.onDbFaild(method, data);
          break;
        case WhatConstant.WHAT_OTHER_DATA_SUCCESS:
          listener.onOtherSucceed(method, data);
          break;
        case WhatConstant.WHAT_OTHER_DATA_FAIL:
          listener.onOtherFaild(method, data);
          break;
        case WhatConstant.WHAT_EXCEPITON:
          listener.onException(method, data);
          break;
        case WhatConstant.WHAT_CANCEL:
          listener.onCancel(method);
          break;
      }
    }
    if (progressBar)
    {

    }
  }


  /*
   * 判断网络返回的JsonObject数据是否无效<br/>
   * 并自动进行失败处理<br/>
   */
  static bool isDataInvalid(final String method, Map<String, dynamic> jo,
      HttpListener listener)
  {
    if (jo == null)
    {
      sendMessage(method, MessageConstant.MSG_CLIENT_FAILED,
          WhatConstant.WHAT_NET_DATA_FAIL, listener);
      return true;
    }
    else if ("106" == jo["code"])
    {
      sendMessage(method, MessageConstant.MSG_LOGIN_INVALID_AUTO,
          WhatConstant.WHAT_NET_DATA_FAIL, listener);
      return true;
    }
    else if ("304" == jo["code"])
    {
      sendMessage(method, MessageConstant.MSG_NEED_LOGIN,
          WhatConstant.WHAT_NET_DATA_FAIL, listener);
      return true;
    }
    else if ("-1" == (jo["ret"]))
    {
      String error = jo["error"];
      sendMessage(
          method,
          CxTextUtil.isEmpty(error) ? MessageConstant.MSG_SERVER_ENMPTY : error,
          WhatConstant.WHAT_NET_DATA_FAIL,
          listener);
      return true;
    }
    else if (1 == jo["ret"])
    {
      if (CxTextUtil.isEmpty(jo["errcode"]))
      {
        sendMessage(
            method, jo["msg"], WhatConstant.WHAT_NET_DATA_FAIL, listener);
      }
      else
      {
        sendMessage(
            method, jo["errcode"], WhatConstant.WHAT_NET_DATA_FAIL, listener);
      }
      return true;
    }
    return false;
  }

  /*
   * 提取Response返回数据<br/>
   */
  static Map<String, dynamic> responseDataOld(Response response)
  {
    Map<String, dynamic> jo = null;
    if (response == null)
    {
      return null;
    }
    if (response.data is List)
    {
      List list = response.data;
      if (list.isEmpty)
      {
        jo = {"ret": "-1"};
        return jo;
      }
      jo = list[0];
      if (jo.isEmpty)
      {
        jo = {"ret": "-1"};
        return jo;
      }
    }
    else if (response.data is String)
    {
      if (CxTextUtil.isEmpty(response.data))
      {
        jo = {"ret": "-1"};
        return jo;
      }
    }
    else
    {
      jo = response.data;
    }
    setToken(jo);
    return jo;
  }

  static Map<String, dynamic> responseData(Response response, {bool resetToken: true})
  {
    response.data = json.decode(response.data);
    Map<String, dynamic> jo = null;
    if (response == null)
    {
      return null;
    }
    if (response.data is List)
    {
      List list = response.data;
      if (list.isEmpty)
      {
        jo = {"ret": "-1"};
        return jo;
      }
      else if (list.length == 1)
      {
        jo = list[0];
        if (jo.isEmpty)
        {
          jo = {"ret": "-1"};
          return jo;
        }
      }
      else if (list.length > 1)
      {
        jo = {"data": list};
      }
    }
    else if (response.data is String)
    {
      if (CxTextUtil.isEmpty(response.data))
      {
        jo = {"ret": "-1"};
        return jo;
      }
    }
    else
    {
      jo = response.data;
    }
    setToken(jo, resetToken: resetToken);
    return jo;
  }

  /*
   * 设置token
   */
  static setToken(Map<String, dynamic> jo, {bool resetToken: true})
  {
    String token = jo[HttpKeyValueConstant.PARAM_SESSIONID];
    if (!CxTextUtil.isEmpty(token) && resetToken)
    {
      TokenMethod.setToken(token);
    }
  }

  /*
   * 设置jo数组
   */
  static setJoList(Map<String, dynamic> jo)
  {
    if (jo[MapKeyConstant.MAP_KEY_DATA] == null)
    {
      List list = [];
      list.add(jo);
      jo[MapKeyConstant.MAP_KEY_DATA] = list;
    }
  }
}
