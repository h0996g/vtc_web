import '../../../../core/constants/api_const.dart';
import '../../../../core/network/vtc_dio.dart';

class WalletRemoteDataSource {
  Future<Map<String, dynamic>> creditWallet({
    required String userId,
    required int amount,
    String? reference,
  }) async {
    final response = await VtcDio.post(
      path: ApiConst.creditWallet,
      data: {
        'userId': userId,
        'amount': amount,
        if (reference != null) 'reference': reference,
      },
    );
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> debitWallet({
    required String userId,
    required int amount,
    String? reference,
  }) async {
    final response = await VtcDio.post(
      path: ApiConst.debitWallet,
      data: {
        'userId': userId,
        'amount': amount,
        if (reference != null) 'reference': reference,
      },
    );
    return response.data as Map<String, dynamic>;
  }
}
