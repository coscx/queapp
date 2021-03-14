import 'package:dio/dio.dart';
/*
 * 功能：请求类型
 * 需要传入的键：
 * 传入的值类型：
 * 传入的值含义：
 * 是否必传 ：
 * 作者：郑朝军 on 2019/4/7 23:23
 * 邮箱：1250393285@qq.com
 * 公司：武汉智博创享科技有限公司
 */
enum HttpMethod
{
  GET,
  POST
}

//文件类型
enum FileType
{
  PICTURE,
  AUDIO
}

/*
 * 功能：Http请求操作封装基类
 * 需要传入的键：
 * 传入的值类型：
 * 传入的值含义：
 * 是否必传 ：
 * 作者：郑朝军 on 2019/4/7 23:23
 * 邮箱：1250393285@qq.com
 * 公司：武汉智博创享科技有限公司
 */
abstract class Protocol
{
  /*
   * 图片键前缀
   */
  final  String KEY_PICTURE = "file";

  /*
   * 音频键前缀
   */
  final String KEY_AUDIO = "file";

  /*
   * 服务
   */
  String mService;

  /*
   * method
   */
  String mMethod;

  /*
   * 基本url
   */
  String mUrl;

  String getService()
  {
    return mService;
  }

  Protocol setService(String service)
  {
    this.mService = service;
    return this;
  }

  String getMethod()
  {
    return mMethod;
  }

  Protocol setMethod(String method)
  {
    this.mMethod = method;
    return this;
  }

  Protocol setUrl(String url)
  {
    this.mUrl = url;
    return this;
  }

  /*
   * 外异内同<br/>
   * GET请求<br/>
   */
  Future<Response<dynamic>> get();

  /*
   * 外异内同<br/>
   * POST请求<br/>
   */
  Future<Response<Object>> post();

  /*
   * 同步请求,必须异步调用<br/>
   * GET直接请求url<br/>
   */
  Future<Response<Map<String, dynamic>>> request(HttpMethod httpMethod,
      Map<String, dynamic>requestParams);

  /*
   * 添加地址参数<br/>
   */
  Protocol addUrlParam(String value);

  /*
   * 添加参数<br/>
   */
  Protocol addParam(String name, Object value);

  /*
   * 上传文件
   * @param key [key=需要和服务器保持一致服务器默认为file]
   * @param value [value=MultipartFile.fromFileSync(文件路径)对象 或者 MultipartFile.fromFile(文件路径)]
   */
  Protocol addFiles(dynamic value,{String key:"file"});

  /*
   * 获取基本url与参数的拼接字符串<br/>
   * 只能在网络请求返回之后调用，才能获取准确的参数<br/>
   */
  String getUrl();

  /*
   * 获取参数<br/>
   * 只能在网络请求返回之后调用，才能获取准确的参数<br/>
   */
  Object getParams();
}