import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:universal_html/html.dart' hide Platform;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageProvider = Provider((ref) => LocalStorage());

//Flutter 애플리케이션에서 로컬 스토리지 관련 작업
class LocalStorage {
  // 웹 브라우저 환경인 경우 window.localStorage를 사용하고, 그렇지 않은 경우 (Flutter 앱인 경우) FlutterSecureStorage를 사용
  final _storage = kIsWeb ? window.localStorage : const FlutterSecureStorage();

  Future<String?> read({required String key}) async {
    return _storage is FlutterSecureStorage
        ? await (_storage as FlutterSecureStorage).read(key: key)
        : (_storage as Storage)[key];
  }

  Future delete({required String key}) async {
    return _storage is FlutterSecureStorage
        ? await (_storage as FlutterSecureStorage).delete(key: key)
        : (_storage as Storage).remove(key);
  }

  Future write({required String key, required String value}) async {
    return _storage is FlutterSecureStorage
        ? await (_storage as FlutterSecureStorage).write(key: key, value: value)
        : (_storage as Storage)[key] = value;
  }

  Future deleteAll({required String key, required String value}) async {
    return _storage is FlutterSecureStorage
        ? await (_storage as FlutterSecureStorage).deleteAll()
        : (_storage as Storage).removeWhere((key, value) => false);
  }
}
