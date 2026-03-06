import '../entities/gift_card_entity.dart';

abstract class GiftCardRepository {
  Future<List<GiftCardEntity>> getGiftCards();
  Future<GiftCardEntity> getGiftCardByCode(String code);
  Future<GiftCardEntity> createGiftCard({required int amount, String? code});
}
