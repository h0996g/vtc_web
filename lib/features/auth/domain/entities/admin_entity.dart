import 'package:equatable/equatable.dart';

class AdminEntity extends Equatable {
  const AdminEntity({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.role,
    this.phoneNumber,
    this.photo,
    this.sex,
    this.dateOfBirth,
    this.address,
    this.wilaya,
    this.commune,
  });

  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String role;
  final String? phoneNumber;
  final String? photo;
  final String? sex;
  final String? dateOfBirth;
  final String? address;
  final String? wilaya;
  final String? commune;

  String get fullName => '$firstName $lastName'.trim();

  @override
  List<Object?> get props => [
        id, email, firstName, lastName, role,
        phoneNumber, photo, sex, dateOfBirth, address, wilaya, commune,
      ];
}
