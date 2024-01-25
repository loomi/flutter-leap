import 'dart:async';
import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'environments.dart';

class Authentication {
  static const _storage = FlutterSecureStorage();
  static const _tokenKey = "authentication_token";

  static Future<bool> authenticated() async {
    final token = await _getToken();
    return token != null;
  }

  static Future<void> logout() async {
    await _storage.delete(key: _tokenKey);
  }

  static Future<void> saveToken(String token) async {
    final encryptedToken = _encrypt(token);
    await _storage.write(key: _tokenKey, value: encryptedToken);
  }

  static Future<String?> getToken() async {
    final encryptedToken = await _storage.read(key: _tokenKey);
    if (encryptedToken == null) {
      return null;
    }
    return _decrypt(encryptedToken);
  }

  static Future<String?> _getToken() async {
    final encryptedToken = await _storage.read(key: _tokenKey);
    if (encryptedToken == null) {
      return null;
    }
    return _decrypt(encryptedToken);
  }

  static String _decrypt(String encrypted) {
    final key = Key.fromUtf8(Environments.authenticationEncryptionKey);
    final iv = IV.fromUtf8(Environments.authenticationIvKey);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final decrypted =
        encrypter.decrypt(Encrypted.fromBase64(encrypted), iv: iv);
    return decrypted;
  }

  static String _encrypt(String value) {
    final key = Key.fromUtf8(Environments.authenticationEncryptionKey);
    final iv = IV.fromUtf8(Environments.authenticationIvKey);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(value, iv: iv);
    return base64.encode(encrypted.bytes);
  }
}
