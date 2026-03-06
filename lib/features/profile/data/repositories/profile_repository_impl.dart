import '../../../auth/data/models/admin_model.dart';
import '../../../auth/domain/entities/admin_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_datasource.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this._dataSource);

  final ProfileRemoteDataSource _dataSource;

  @override
  Future<AdminEntity> getProfile() async {
    final data = await _dataSource.getProfile();
    return AdminModel.fromJson(data);
  }

  @override
  Future<AdminEntity> updateProfile({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? address,
    String? wilaya,
    String? commune,
  }) async {
    final data = await _dataSource.updateProfile(
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      address: address,
      wilaya: wilaya,
      commune: commune,
    );
    return AdminModel.fromJson(data);
  }

  @override
  Future<AdminEntity> updatePhoto(String filePath) async {
    final data = await _dataSource.updatePhoto(filePath);
    return AdminModel.fromJson(data);
  }
}
