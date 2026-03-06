import '../../domain/entities/wallet_operation_entity.dart';

class WalletModel extends WalletEntity {
  const WalletModel({
    required super.id,
    required super.userId,
    required super.balance,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
        id: json['id'] as String,
        userId: json['userId'] as String,
        balance: (json['balance'] as num).toInt(),
      );
}

class TransactionModel extends TransactionEntity {
  const TransactionModel({
    required super.id,
    required super.type,
    required super.amount,
    required super.createdAt,
    super.reference,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
        id: json['id'] as String,
        type: json['type'] as String,
        amount: (json['amount'] as num).toInt(),
        createdAt: DateTime.parse(json['createdAt'] as String),
        reference: json['reference'] as String?,
      );
}
