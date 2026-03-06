import '../../domain/entities/gift_card_entity.dart';

class GiftCardModel extends GiftCardEntity {
  const GiftCardModel({
    required super.id,
    required super.code,
    required super.amount,
    required super.isUsed,
    super.usedBy,
    super.usedAt,
  });

  factory GiftCardModel.fromJson(Map<String, dynamic> json) => GiftCardModel(
        id: json['id'] as String,
        code: json['code'] as String,
        amount: (json['amount'] as num).toInt(),
        isUsed: json['isUsed'] as bool,
        usedBy: json['usedBy'] as String?,
        usedAt: json['usedAt'] != null
            ? DateTime.parse(json['usedAt'] as String)
            : null,
      );
}
