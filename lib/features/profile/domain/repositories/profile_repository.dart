import '../../../auth/domain/entities/admin_entity.dart';

abstract class ProfileRepository {
  Future<AdminEntity> getProfile();

  Future<AdminEntity> updateProfile({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? address,
    String? wilaya,
    String? commune,
  });

  Future<AdminEntity> updatePhoto(String filePath);
}
