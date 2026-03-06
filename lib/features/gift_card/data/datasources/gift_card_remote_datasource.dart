import '../../../../core/constants/api_const.dart';
import '../../../../core/network/vtc_dio.dart';

class GiftCardRemoteDataSource {
  Future<List<dynamic>> getGiftCards() async {
    final response = await VtcDio.get(path: ApiConst.giftCards);
    return response.data as List<dynamic>;
  }

  Future<Map<String, dynamic>> getGiftCardByCode(String code) async {
    final response = await VtcDio.get(path: ApiConst.giftCardByCode(code));
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> createGiftCard({
    required int amount,
    String? code,
  }) async {
    final response = await VtcDio.post(
      path: ApiConst.giftCards,
      data: {
        'amount': amount,
        if (code != null) 'code': code,
      },
    );
    return response.data as Map<String, dynamic>;
  }
}
