import 'package:flutter/foundation.dart';

class ValueUtil {
  static int toInt(dynamic value) {
    if (value is String) {
      if (value.length > 0) {
        return int.parse(value);
      } else {
        return 0;
      }
    } else if (value is num) {
      return value.toInt();
    } else {
      return 0;
    }
  }

  static double toDouble(dynamic value) {
    if (value is String) {
      if (value.length > 0) {
        return double.parse(value);
      } else {
        return 0.0;
      }
    } else if (value is num) {
      return value.toDouble();
    } else {
      return 0.0;
    }
  }

  static String toStr(dynamic value, {String def = ''}) {
    if (value is String) {
      return value;
    } else if (value is num) {
      return value.toString();
    } else {
      return def;
    }
  }

  static List toArr(dynamic value) {
    if (value is List) {
      return value;
    } else {
      return [];
    }
  }

  static List toList(dynamic value) {
    return ValueUtil.toArr(value);
  }

  static List toPhotos(dynamic value) {
    if (value is String) {
      return [value];
    } else if (value is List) {
      return value;
    } else {
      return [];
    }
  }

  static Map toMap(dynamic value) {
    if (value is Map) {
      return value;
    } else {
      return {};
    }
  }

  static num toNum(dynamic value) {
    if (value is num) {
      return value;
    } else if (value is String) {
      if (value.contains(".")) {
        return double.parse(value);
      } else {
        return int.parse(value);
      }
    } else {
      return -666;
    }
  }

  static bool toBool(dynamic value) {
    if (value is bool) {
      return value;
    } else if (value is String) {
      if (value.length == 0) return false;
      return toNum(value) > 0;
    } else if (value is num) {
      return value > 0;
    } else {
      return false;
    }
  }

  /// 将 object 转化为数组，object 可能为字符串, 也可能是数组
  static List publishValueList(dynamic object) {
    if (object == null) {
      return [];
    }
    if (object is String) {
      if (object.length > 0) {
        return object.split(',');
      } else {
        return [];
      }
    } else {
      List objs = ValueUtil.toArr(object);
      if (objs.length > 0) {
        return objs.map((obj) => ValueUtil.toStr(obj)).toList();
      } else {
        return [];
      }
    }
  }

  /// 移除url 的 域名和协议
  static String removeUrlSchemeHost(String url) {
    if (url == null) {
      return null;
    }
    if (url.startsWith('http')) {
      var uri = Uri.parse(url);
      var prefix = '${uri.scheme}://${uri.host}';
      if (uri.hasPort) {
        prefix = '${uri.scheme}://${uri.host}:${uri.port}';
      }
      String uPath = url.replaceFirst(prefix, '');
      return uPath;
    } else {
      return url;
    }
  }

  /// 将一个 json 转化为对象，转换结果可以为空
  static convertToNullableObject<T>(dynamic object, {@required T Function(Map json) convert}) {
    if (object == null) {
      return null;
    } else {
      Map map = ValueUtil.toMap(object);
      if (map.length == 0) {
        return null;
      }
      return convert(map);
    }
  }

  static List<String> listRemoveEmpty(List<String> list) {
    List<String> result = [];

    for (String ele in list) {
      if (ele != null && ele.length > 0) {
        result.add(ele);
      }
    }
    return result;
  }
}
