import 'dart:convert';

import 'package:encrypt/encrypt.dart';

class Cryptography {
  static String encryptAES(plainText) {
    final key = Key.fromUtf8('my 32 length key................');
    final iv = IV.fromUtf8('my 16 length key');
    final encrypter = Encrypter(AES(key));

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted.base64;
  }

  static String decryptAES(encrypted) {
    final key = Key.fromUtf8('my 32 length key................');
    final iv = IV.fromUtf8('my 16 length key');
    final encrypter = Encrypter(AES(key));

    final decrypted = encrypter.decrypt(encrypted, iv: iv);
    return decrypted;
  }
}
