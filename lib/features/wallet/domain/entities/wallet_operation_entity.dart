import 'package:equatable/equatable.dart';

class WalletEntity extends Equatable {
  const WalletEntity({
    required this.id,
    required this.userId,
    required this.balance,
  });

  final String id;
  final String userId;
  final int balance;

  @override
  List<Object?> get props => [id, userId, balance];
}

class TransactionEntity extends Equatable {
  const TransactionEntity({
    required this.id,
    required this.type,
    required this.amount,
    required this.createdAt,
    this.reference,
  });

  final String id;
  final String type;
  final int amount;
  final DateTime createdAt;
  final String? reference;

  @override
  List<Object?> get props => [id, type, amount, createdAt, reference];
}
