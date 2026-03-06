import 'package:equatable/equatable.dart';

class GiftCardEntity extends Equatable {
  const GiftCardEntity({
    required this.id,
    required this.code,
    required this.amount,
    required this.isUsed,
    this.usedBy,
    this.usedAt,
  });

  final String id;
  final String code;
  final int amount;
  final bool isUsed;
  final String? usedBy;
  final DateTime? usedAt;

  @override
  List<Object?> get props => [id, code, amount, isUsed, usedBy, usedAt];
}
