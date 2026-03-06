import 'package:dio/dio.dart';
import '../../../../core/constants/api_const.dart';
import '../../../../core/network/vtc_dio.dart';

class ProfileRemoteDataSource {
  Future<Map<String, dynamic>> getProfile() async {
    final response = await VtcDio.get(path: ApiConst.profile);
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> updateProfile({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? address,
    String? wilaya,
    String? commune,
  }) async {
    final response = await VtcDio.put(
      path: ApiConst.profile,
      data: {
        if (firstName != null) 'firstName': firstName,
        if (lastName != null) 'lastName': lastName,
        if (phoneNumber != null) 'phoneNumber': phoneNumber,
        if (address != null) 'address': address,
        if (wilaya != null) 'wilaya': wilaya,
        if (commune != null) 'commune': commune,
      },
    );
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> updatePhoto(String filePath) async {
    final formData = FormData.fromMap({
      'photo': await MultipartFile.fromFile(filePath),
    });
    final response = await VtcDio.put(
      path: ApiConst.profilePhoto,
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );
    return response.data as Map<String, dynamic>;
  }
}
