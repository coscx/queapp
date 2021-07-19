import 'dart:convert';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart';

const _KEY = "GuGuAPP\$*@AesKey";
const _IV = "0000000000000000";
const public_key ='''
-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwJojRka0TnDlFjphoafw
CcREgwtr+LZeOdo0NSyKJ6+kRZQ5i1nhGPUN+P2vCrZE5PbOJidlx85juTjC3Hej
1ukkXGMwGjBMelzfYITbxcdB8V/vUDqH8lIUG+AMO8sonIceyr6TDBlxbLKNPd50
NurmcRs17FCZui3SKSdJcAoe5eceUrD2vC3qAY01YItW+dYg6UhG3Q254iA4DxFY
hmcNVhihcqDtOI/X8uTpX85ZLPlwSFvwB8wQhH8dbOT1BeoZyRznwWGzsk9aaCXW
bkuo8XxGFZDxjNelZrJbMC2WBFvp9s4k8eCnVEnCGhRJce8hOF1H95ikYjq2+O5q
HQIDAQAB
-----END PUBLIC KEY-----
''';
class EncryptUtils {

  static String encodeBase64(String data) {
    return base64Encode(utf8.encode(data));
  }


  static String decodeBase64(String data) {
    return String.fromCharCodes(base64Decode(data));
  }


  static String encodeMd5(String plainText) {
    return (plainText);
  }

  //AES加密
  static aesEncrypt(plainText) {
    try {
      final key = Key.fromUtf8(_KEY);
      final iv = IV.fromUtf8(_IV);
      final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
      final encrypted = encrypter.encrypt(plainText, iv: iv);
      return encrypted.base64;
    } catch (err) {
      print("aes encode error:$err");
      return plainText;
    }
  }

  //AES解密
  static dynamic aesDecrypt(encrypted) {
    try {
      final key = Key.fromUtf8(_KEY);
      final iv = IV.fromUtf8(_IV);
      final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
      final decrypted = encrypter.decrypt64(encrypted, iv: iv);
      return decrypted;
    } catch (err) {
      print("aes decode error:$err");
      return encrypted;
    }
  }

  static Future<String> encodeRSAString(String content) async{
    var publicKey = RSAKeyParser().parse(public_key);
    final encrypter = Encrypter(RSA(publicKey: publicKey));

    List<int> sourceBytes = utf8.encode(content);
    int inputLen = sourceBytes.length;
    int maxLen = 117;
    List<int> totalBytes = List();
    for (var i = 0; i < inputLen; i += maxLen) {
      int endLen = inputLen - i;
      List<int> item;
      if (endLen > maxLen) {
        item = sourceBytes.sublist(i, i + maxLen);
      }
      else {
        item = sourceBytes.sublist(i, i + endLen);
      }
      totalBytes.addAll(encrypter.encryptBytes(item).bytes);
    }
    return base64.encode(totalBytes);
//       return await encrypter.encrypt(content).base64.toUpperCase();
  }

  static Future<String> decodeRSAString(String content) async{
    var publicKey =  RSAKeyParser().parse(public_key);
    final encrypter = Encrypter(RSA(publicKey: publicKey));

    Uint8List sourceBytes = base64.decode(content);
    int inputLen = sourceBytes.length;
    int maxLen = 128;
    List<int> totalBytes = List();
    for (var i = 0; i < inputLen; i += maxLen) {
      int endLen = inputLen - i;
      Uint8List item;
      if (endLen > maxLen) {
        item = sourceBytes.sublist(i, i + maxLen);
      } else {
        item = sourceBytes.sublist(i, i + endLen);
      }
      totalBytes.addAll(encrypter.decryptBytes(Encrypted(item)));
    }
    return utf8.decode(totalBytes);
//        return await encrypter.decrypt(Encrypted.fromBase64(content));
  }

}