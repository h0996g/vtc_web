import '../entities/admin_entity.dart';

abstract class AuthRepository {
  Future<({AdminEntity admin, String accessToken, String refreshToken})> login({
    required String email,
    required String password,
  });

  Future<({AdminEntity admin, String accessToken, String refreshToken})> registerAdmin({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? phoneNumber,
  });
}
