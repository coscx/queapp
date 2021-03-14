import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_geen/app/zpubhttp/constant/HttpKeyValueConstant.dart';
import 'package:flutter_geen/app/zpubhttp/constant/UrlConstant.dart';
import 'package:flutter_geen/app/zpubhttp/http/Protocol.dart';
import 'package:flutter_geen/app/zpubhttp/method/TokenMethod.dart';
import 'package:flutter_geen/app/zpubhttp/uitl/CxTextUtil.dart';
import 'package:flutter_geen/app/zpubhttp/uitl/HttpLog.dart';

/*
 * 功能：Http请求操作封装类
 * 需要传入的键：
 * 传入的值类型：
 * 传入的值含义：
 * 是否必传 ：
 * 作者：郑朝军 on 2019/4/7 23:23
 * 邮箱：1250393285@qq.com
 * 公司：武汉智博创享科技有限公司
 */
class HttpProtocol extends Protocol
{
  static Dio mHttp;

  Map<String, Object> mParams = new LinkedHashMap<String, Object>();

  HttpMethod mHttpMethod;

  FormData mFormData;

  bool mEncrypt = UrlConstant.ENCRYPT;

  HttpProtocol()
  {
    mUrl = UrlConstant.BASE_URL;
  }

  HttpProtocol setService(String service)
  {
    super.setService(service);
    if (service == ("auth") || service == ("user") || service == ("file"))
    {
      mUrl += ("/" + service);
    }
    else
    {
      mUrl += service;
    }
    return this;
  }

  HttpProtocol setEncrypt(bool encrypt)
  {
    this.mEncrypt = encrypt;
    return this;
  }

  HttpProtocol setMethod(String method)
  {
    super.setMethod(method);
    mUrl += ("/" + method);
    return this;
  }

  HttpProtocol addUrlParam(String value)
  {
    mUrl += ("/" + value);
    return this;
  }

  HttpProtocol addParam(String key, Object value)
  {
    if (value is bool)
    {
      value = value as bool ? 1 : 0;
    }
    if (value != null)
    {
      mParams[key] = value;
    }
    return this;
  }

  HttpProtocol addMap(Map<String, Object> value)
  {
    if(value != null && value.isNotEmpty)
    {
      mParams.addAll(value);
    }
    return this;
  }

  Future<HttpProtocol> addFilesAwit(dynamic value, {String key:"file"})
  async {
    if (value is String)
    {
      mFormData = new FormData.fromMap({key: await MultipartFile.fromFile(value)});
    }
    else if(value is File)
    {
      mFormData = new FormData.fromMap({key: await MultipartFile.fromFile(value.path)});
    }
    else if(value is List)
    {
      List multipartFile = new List();
      for(int i = 0; i < value.length;i++)
      {
        multipartFile.add(await MultipartFile.fromFile(value[i]));
      }
      mFormData = new FormData.fromMap({key: multipartFile});
    }
    return this;
  }

  HttpProtocol addFilesSync(dynamic value, {String key:"file"})
  {
    if (value is String)
    {
      mFormData = new FormData.fromMap({key: MultipartFile.fromFileSync(value)});
    }
    else if(value is File)
    {
      mFormData = new FormData.fromMap({key: MultipartFile.fromFileSync(value.path)});
    }
    else if(value is List)
    {
      List multipartFile = new List();
      for(int i = 0; i < value.length;i++)
      {
        multipartFile.add( MultipartFile.fromFileSync(value[i]));
      }
      mFormData = new FormData.fromMap({key: multipartFile});
    }
    return this;
  }

  HttpProtocol addFiles(dynamic value, {String key:"file"})
  {
    mFormData = new FormData.fromMap({key: value});
    return this;
  }

  HttpProtocol addPagerParam(int page)
  {
    mParams[HttpKeyValueConstant.PARAM_PAGER_NO] = page;
    mParams[HttpKeyValueConstant.PARAM_PAGER_SIZE] = HttpKeyValueConstant.VALUE_PAGER_SIZE;
    mParams[HttpKeyValueConstant.PARAM_PAGER_INIT] = (page == 1 ? 0 : 1);
    return this;
  }

  HttpProtocol addMaxPagerParam()
  {
    mParams[HttpKeyValueConstant.PARAM_PAGER_NO] = 1;
    mParams[HttpKeyValueConstant.PARAM_PAGER_SIZE] = HttpKeyValueConstant.VALUE_MAX_PAGER_SIZE;
    mParams[HttpKeyValueConstant.PARAM_PAGER_INIT] = 0;
    return this;
  }

  void addSignedParams()
  {
    mParams[HttpKeyValueConstant.PARAM_SESSIONID] = CxTextUtil.isEmpty(HttpKeyValueConstant.VALUE_TOKEN) ?
    TokenMethod.getTokenFromProperty() : HttpKeyValueConstant.VALUE_TOKEN;
    HttpKeyValueConstant.VALUE_COUNT = HttpKeyValueConstant.VALUE_COUNT + 1;
    mParams[HttpKeyValueConstant.PARAM_COUNT] = HttpKeyValueConstant.VALUE_COUNT;
  }

  /*
   * GET请求<br/>
   */
  Future<Response<dynamic>> get()
  {
    mHttpMethod = HttpMethod.GET;
    return requestGet();
  }

  /*
   * POST请求<br/>
   */
  Future<Response<Object>> post()
  {
    mHttpMethod = HttpMethod.POST;
    return requestPost();
  }

  /*
   * 请求<br/>
   */
  Future<Response<Map<String, dynamic>>> request(HttpMethod httpMethod,
      Map<String, dynamic> requestParams) async
  {
    Dio http = createDefaultHttpClient();
    try {
      Response<Map<String, dynamic>> response;
      if (httpMethod == HttpMethod.GET)
      {
        response = await http.get(mUrl, queryParameters: requestParams);
      }
      else if (httpMethod == HttpMethod.POST)
      {
        response = await http.post(mUrl, queryParameters: requestParams);
      }
      return response;
    }
    catch (e)
    {
      outputException(e);
    }
    return null;
  }

  Future<Response<dynamic>> requestGet() async
  {
    Dio http = createDefaultHttpClient();
    try
    {
      HttpLog.ln();
      HttpLog.e("http", 'url：$mUrl');
      Response<dynamic> response = await http.get(
          mUrl, queryParameters: prepareRequestParams());
      int statusCode = response.statusCode;
      HttpLog.d("http", 'requestParams：${response.request.queryParameters}');
      HttpLog.e("http", "status:${statusCode.toString()}");
      HttpLog.e("http", response.data);
      HttpLog.ln();
      return response;
    }
    catch (e)
    {
      outputException(e);
    }
    return null;
  }

  Map<String, dynamic> prepareRequestParams()
  {
    addSignedParams();
    Map<String, dynamic> requestParams = addParams();
    addHeader();
    return requestParams;
  }

  Map<String, dynamic> addParams()
  {
    if (mHttpMethod == HttpMethod.GET)
    {
      return mParams;
    }
    else if (mHttpMethod == HttpMethod.POST)
    {
      Map<String, dynamic>headers = mHttp.options.headers;
      if (mParams.containsKey(HttpKeyValueConstant.PARAM_PAGER_NO))
      {
        headers[HttpKeyValueConstant.PARAM_PAGER_NO] =
        mParams[HttpKeyValueConstant.PARAM_PAGER_NO];
      }
      if (mParams.containsKey(HttpKeyValueConstant.PARAM_PAGER_SIZE))
      {
        headers[HttpKeyValueConstant.PARAM_PAGER_SIZE] =
        mParams[HttpKeyValueConstant.PARAM_PAGER_SIZE];
      }
      return mParams;
    }
    return mParams;
  }

  void addHeader()
  {
    Map<String, dynamic> headers = mHttp.options.headers;
    String token = HttpKeyValueConstant.VALUE_TOKEN;
    if (CxTextUtil.isEmpty(token))
    {
      token = TokenMethod.getTokenFromProperty();
      HttpKeyValueConstant.VALUE_TOKEN = token;
    }
    if (!CxTextUtil.isEmpty(token))
    {
      headers[HttpKeyValueConstant.PARAM_TOKEN] = HttpKeyValueConstant.VALUE_TOKEN;
    }
  }

  Dio createDefaultHttpClient()
  {
    if (mHttp == null)
    {
      mHttp = new Dio(new BaseOptions(
        baseUrl: UrlConstant.BASE_URL,
        connectTimeout: 5000,
        receiveTimeout: 30000,
        headers: {
          "api": "1.0",
        },
//        contentType: ContentType.json,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ));
    }
    if (mService == "file")
    {
      mHttp.options.receiveTimeout = 15 * 12 * 1000;
    }
    else
    {
      mHttp.options.receiveTimeout = 20 * 1000;
    }

    return mHttp;
  }

  /*
   * 输出网络错误详情<br/>
   */
  Future<Response<Object>> requestPost() async
  {
    Dio http = createDefaultHttpClient();
    try
    {
      HttpLog.ln();
      HttpLog.e("http", 'url：$mUrl');
      Map<String, dynamic>  map = prepareRequestParams();

      if(mEncrypt)
      {
        String code = "await FlutterDes.encrypt(map)";
        map[HttpKeyValueConstant.PARAM_CODE] = code;
      }

      Response<Object> response = await http.post(
          mUrl, queryParameters: map,data: mFormData);

      int statusCode = response.statusCode;
      HttpLog.d("http", 'requestParams：${response.request.queryParameters}');
      HttpLog.e("http", "status:${statusCode.toString()}");
      HttpLog.e("http", response.data);
      HttpLog.ln();
      return response;
    }
    catch (e)
    {
      outputException(e);
    }
    return null;
  }

  void outputException(e)
  {
    HttpLog.e("http", e);
  }

  /*
   * 获取基本url与参数的拼接字符串<br/>
   * 只能在网络请求返回之后调用，才能获取准确的参数<br/>
   */
  String getUrl()
  {
    if (mParams.isEmpty)
    {
      return mUrl;
    }
    else
    {
      StringBuffer sb = new StringBuffer(mUrl + "?");
      mParams.forEach((key, value) =>
      {
        sb..write(key + "=" + value + "&")
      });

      sb..write(HttpKeyValueConstant.PARAM_TOKEN + "=" + HttpKeyValueConstant.VALUE_TOKEN);

      return sb.toString();
    }
  }

  /*
   * 获取参数<br/>
   * 只能在网络请求返回之后调用，才能获取准确的参数<br/>
   */
  Object getParams()
  {
    return mParams;
  }

  /*
   * 清除静态数据<br/>
   */
  static void clearStaticData()
  {
  }

  /*
   * 测试阶段<br/>
   */
  Future<Response<Object>> requestDownload() async
  {
    Dio http = createDefaultHttpClient();
    try
    {
      HttpLog.ln();
      HttpLog.e("http", 'url：$mUrl');
      Map<String, dynamic>  map = prepareRequestParams();

      if(mEncrypt)
      {
        String code = "await FlutterDes.encrypt(map)";
        map[HttpKeyValueConstant.PARAM_CODE] = code;
      }

      Response<Object> response = await http.download(mUrl,'', queryParameters: map);

      int statusCode = response.statusCode;
      HttpLog.d("http", 'requestParams：${response.request.queryParameters}');
      HttpLog.e("http", "status:${statusCode.toString()}");
      HttpLog.e("http", response.data);
      HttpLog.ln();
      return response;
    }
    catch (e)
    {
      outputException(e);
    }
    return null;
  }
}
