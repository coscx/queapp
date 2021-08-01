import 'dart:math';
class GetRand {
  /// dart  生成固定随机数
 static String getRandString(){
    String alphabet = '1234567890qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM';
    int strLength = 16; /// 生成的字符串固定长度
    String left = '';
    for (var i = 0; i < strLength; i++) {
//    right = right + (min + (Random().nextInt(max - min))).toString();
      left = left + alphabet[Random().nextInt(alphabet.length)];
    }
    return(left);
  }
}

