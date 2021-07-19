import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_geen/views/pages/resource/colors.dart';

class ObjectUtil {
  static bool isNotEmpty(Object object) {
    return !isEmpty(object);
  }

  static bool isEmpty(Object object) {
    if (object == null) return true;
    if (object is String && object.isEmpty) {
      return true;
    } else if (object is List && object.isEmpty) {
      return true;
    } else if (object is Map && object.isEmpty) {
      return true;
    }
    return false;
  }

  /*
  * 随机取一个颜色
  */
  static Color getRandomColor(){
    return themeColorMap.values.toList()[Random.secure().nextInt(themeColorMap.length)];
  }

  /*
  *  获取app的AppBar、ToolBar颜色
  */
  static Color getThemeColor({String color: "red"}) {

  }

  /*
  *  生成与app主题相近的亮颜色
  */
  static Color getThemeLightColor() {
    String res = "";
    Color color;
    switch (res) {
      case 'null':
        color = Colors.red[50];
        break;
      case 'pink':
        color = Colors.pink[50];
        break;
      case 'purple':
        color = Colors.purple[50];
        break;
      case 'deepPurple':
        color = Colors.deepPurple[50];
        break;
      case 'indigo':
        color = Colors.indigo[50];
        break;
      case 'blue':
        color = Colors.blue[50];
        break;
      case 'lightBlue':
        color = Colors.lightBlue[50];
        break;
      case 'cyan':
        color = Colors.cyan[50];
        break;
      case 'teal':
        color = Colors.teal[50];
        break;
      case 'green':
        color = Colors.green[50];
        break;
      case 'lightGreen':
        color = Colors.lightGreen[50];
        break;
      case 'lime':
        color = Colors.lime[50];
        break;
      case 'yellow':
        color = Colors.yellow[50];
        break;
      case 'amber':
        color = Colors.amber[50];
        break;
      case 'orange':
        color = Colors.orange[50];
        break;
      case 'red':
        color = Colors.red[50];
        break;
      case 'deepOrange':
        color = Colors.deepOrange[50];
        break;
      case 'brown':
        color = Colors.brown[50];
        break;
      case 'blueGrey':
        color = Colors.blueGrey[50];
        break;
      default:
        color = Colors.red[50];
    }
    return color;
  }

  /*
  *  获取app的主题颜色
  */
  static Color getThemeSwatchColor({String color: "red"}) {

  }

  /*
  * 退出登录调用
  */
  static void doExit(BuildContext context) {

  }



  static bool isNetUri(String uri) {
    if (uri.isNotEmpty &&
        (uri.startsWith('http://') || uri.startsWith('https://'))) {
      return true;
    }
    return false;
  }

  static Map<String, dynamic> buildMessage() {


  }



  static var clickTime = 0;

  static bool isFastClick(){
    var current = new DateTime.now().millisecondsSinceEpoch;
    if(current - clickTime > 1500){
      clickTime = current;
      return false;
    }
    clickTime = current;
    return true;
  }
}
