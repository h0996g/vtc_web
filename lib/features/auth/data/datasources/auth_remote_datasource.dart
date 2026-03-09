import '../../../../core/constants/api_const.dart';
import '../../../../core/network/vtc_dio.dart';

class AuthRemoteDataSource {
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await VtcDio.post(
      path: ApiConst.login,
      data: {'email': email, 'password': password},
    );
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> registerDriver({
    required String email,
    required String password,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required String vehicleType,
    required String vehicleModel,
    required int vehicleYear,
    required String vehiclePlate,
    String? sex,
    String? dateOfBirth,
    String? address,
    String? wilaya,
    String? commune,
  }) async {
    final response = await VtcDio.post(
      path: ApiConst.registerDriver,
      data: {
        'email': email,
        'password': password,
        'phoneNumber': phoneNumber,
        'firstName': firstName,
        'lastName': lastName,
        'vehicle': {
          'type': vehicleType,
          'model': vehicleModel,
          'year': vehicleYear,
          'plate': vehiclePlate,
        },
        if (sex != null) 'sex': sex,
        if (dateOfBirth != null) 'dateOfBirth': dateOfBirth,
        if (address != null) 'address': address,
        if (wilaya != null) 'wilaya': wilaya,
        if (commune != null) 'commune': commune,
      },
    );
    return response.data as Map<String, dynamic>;
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final response = await VtcDio.post(
      path: ApiConst.changePassword,
      data: {
        'oldPassword': oldPassword,
        'newPassword': newPassword,
        'confirmPassword': confirmPassword,
      },
    );
    if (response.statusCode != 200) {
      final data = response.data;
      final message = (data is Map && data['message'] != null)
          ? data['message'].toString()
          : 'Failed to change password';
      throw Exception(message);
    }
  }

  Future<Map<String, dynamic>> registerAdmin({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? phoneNumber,
  }) async {
    final response = await VtcDio.post(
      path: ApiConst.registerAdmin,
      data: {
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
        if (phoneNumber != null) 'phoneNumber': phoneNumber,
      },
    );
    return response.data as Map<String, dynamic>;
  }
}
