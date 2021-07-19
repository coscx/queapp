import 'package:encrypt/encrypt.dart';

class encrypt {

 static String  aes_enc(String text){
    return text;
    final key = Key.fromUtf8("AAAABBBBCCCCDDDD");
    final iv = IV.fromUtf8("1243567887654321");
    final encrypter = Encrypter(AES(key));
    final encrypted = encrypter.encrypt(text, iv: iv);
    //final decrypted = encrypter.decrypt(encrypted, iv: iv);
    return encrypted.base64;
  }
 static String  aes_dec(String text){
   return text;
   final key = Key.fromUtf8("AAAABBBBCCCCDDDD");
   final iv = IV.fromUtf8("1243567887654321");
   final encrypter = Encrypter(AES(key));
   try{
     final decrypted = encrypter.decrypt64(text, iv: iv);
     return decrypted;
   } catch (err) {
      //print(err);
    }

   return text;
 }
}