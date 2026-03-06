import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/app_const.dart';

class SecureStorageService {
  static const _storage = FlutterSecureStorage(
    webOptions: WebOptions(dbName: 'vtc_admin', publicKey: 'vtc_admin_key'),
  );

  static Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(key: AppConst.accessTokenKey, value: accessToken);
    await _storage.write(key: AppConst.refreshTokenKey, value: refreshToken);
  }

  static Future<String?> getAccessToken() =>
      _storage.read(key: AppConst.accessTokenKey);

  static Future<String?> getRefreshToken() =>
      _storage.read(key: AppConst.refreshTokenKey);

  static Future<void> saveAdminInfo({
    required String id,
    required String email,
    required String name,
  }) async {
    await _storage.write(key: AppConst.adminIdKey, value: id);
    await _storage.write(key: AppConst.adminEmailKey, value: email);
    await _storage.write(key: AppConst.adminNameKey, value: name);
  }

  static Future<String?> getAdminName() =>
      _storage.read(key: AppConst.adminNameKey);

  static Future<String?> getAdminEmail() =>
      _storage.read(key: AppConst.adminEmailKey);

  static Future<void> clearAll() => _storage.deleteAll();

  static Future<bool> isLoggedIn() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }
}
