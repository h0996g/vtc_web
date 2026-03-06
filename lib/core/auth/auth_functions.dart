import '../network/vtc_dio.dart';
import '../storage/secure_storage_service.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/auth/domain/entities/admin_entity.dart';

/// Central place for login / logout side-effects.
/// Call these from AuthCubit so every entry-point stays consistent.
class AuthFunctions {
  /// Performs login:
  /// 1. Calls auth API → receives tokens
  /// 2. Persists tokens to secure storage
  /// 3. Updates Dio with the new token
  /// 4. Fetches full profile and persists display name
  /// Returns the full [AdminEntity] from the profile endpoint.
  static Future<AdminEntity> login({
    required AuthRepository authRepository,
    required ProfileRepository profileRepository,
    required String email,
    required String password,
  }) async {
    // 1. Authenticate
    final result = await authRepository.login(email: email, password: password);

    // 2. Persist tokens
    await SecureStorageService.saveTokens(
      accessToken: result.accessToken,
      refreshToken: result.refreshToken,
    );

    // 3. Initialise Dio with the new token
    VtcDio.updateToken(result.accessToken);

    // 4. Fetch full profile
    final admin = await profileRepository.getProfile();

    // 5. Persist display info for TopBar / shell
    await SecureStorageService.saveAdminInfo(
      id: admin.id,
      email: admin.email,
      name: admin.fullName,
    );

    return admin;
  }

  /// Performs logout:
  /// 1. Clears all secure storage
  /// 2. Removes Dio auth header
  static Future<void> logout() async {
    await SecureStorageService.clearAll();
    VtcDio.removeToken();
  }

  /// Called on app start when a token already exists in storage.
  /// Refreshes Dio and fetches fresh profile data.
  /// Returns null if the stored token is invalid / expired.
  static Future<AdminEntity?> restoreSession({
    required ProfileRepository profileRepository,
  }) async {
    final token = await SecureStorageService.getAccessToken();
    if (token == null || token.isEmpty) return null;
    VtcDio.updateToken(token);
    try {
      final admin = await profileRepository.getProfile();
      await SecureStorageService.saveAdminInfo(
        id: admin.id,
        email: admin.email,
        name: admin.fullName,
      );
      return admin;
    } catch (_) {
      await logout();
      return null;
    }
  }
}
