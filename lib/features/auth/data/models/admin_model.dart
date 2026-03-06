import '../../domain/entities/admin_entity.dart';

class AdminModel extends AdminEntity {
  const AdminModel({
    required super.id,
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.role,
    super.phoneNumber,
    super.photo,
    super.sex,
    super.dateOfBirth,
    super.address,
    super.wilaya,
    super.commune,
  });

  factory AdminModel.fromJson(Map<String, dynamic> json) => AdminModel(
        id: json['id'] as String,
        email: json['email'] as String,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        role: json['role'] as String,
        phoneNumber: json['phoneNumber'] as String?,
        photo: json['photo'] as String?,
        sex: json['sex'] as String?,
        dateOfBirth: json['dateOfBirth'] as String?,
        address: json['address'] as String?,
        wilaya: json['wilaya'] as String?,
        commune: json['commune'] as String?,
      );
}
