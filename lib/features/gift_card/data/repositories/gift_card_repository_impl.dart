import '../../domain/entities/gift_card_entity.dart';
import '../../domain/repositories/gift_card_repository.dart';
import '../datasources/gift_card_remote_datasource.dart';
import '../models/gift_card_model.dart';

class GiftCardRepositoryImpl implements GiftCardRepository {
  GiftCardRepositoryImpl(this._dataSource);

  final GiftCardRemoteDataSource _dataSource;

  @override
  Future<List<GiftCardEntity>> getGiftCards() async {
    final data = await _dataSource.getGiftCards();
    return data
        .map((e) => GiftCardModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<GiftCardEntity> getGiftCardByCode(String code) async {
    final data = await _dataSource.getGiftCardByCode(code);
    return GiftCardModel.fromJson(data);
  }

  @override
  Future<GiftCardEntity> createGiftCard({required int amount, String? code}) async {
    final data = await _dataSource.createGiftCard(amount: amount, code: code);
    return GiftCardModel.fromJson(data);
  }
}
