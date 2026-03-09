import 'dart:convert';

import '../../domain/entities/admin_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/admin_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._dataSource);

  final AuthRemoteDataSource _dataSource;

  /// Decodes JWT payload without verifying signature.
  Map<String, dynamic> _decodeJwtPayload(String token) {
    final parts = token.split('.');
    if (parts.length != 3) throw Exception('Invalid token');
    final payload = parts[1];
    // Base64url → base64
    final normalized = base64Url.normalize(payload);
    final decoded = utf8.decode(base64Url.decode(normalized));
    return json.decode(decoded) as Map<String, dynamic>;
  }

  @override
  Future<({AdminEntity admin, String accessToken, String refreshToken})> login({
    required String email,
    required String password,
  }) async {
    final data = await _dataSource.login(email: email, password: password);
    final accessToken = data['accessToken'] as String;
    final refreshToken = data['refreshToken'] as String;
    final payload = _decodeJwtPayload(accessToken);
    final admin = AdminModel(
      id: payload['userId'] as String,
      email: email,
      firstName: '',
      lastName: '',
      role: payload['role'] as String,
    );
    return (admin: admin, accessToken: accessToken, refreshToken: refreshToken);
  }

  @override
  Future<({AdminEntity admin, String accessToken, String refreshToken})> registerAdmin({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? phoneNumber,
  }) async {
    final data = await _dataSource.registerAdmin(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
    );
    final admin = AdminModel.fromJson(data['admin'] as Map<String, dynamic>);
    return (
      admin: admin,
      accessToken: data['accessToken'] as String,
      refreshToken: data['refreshToken'] as String,
    );
  }

  @override
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    await _dataSource.changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
  }
}
