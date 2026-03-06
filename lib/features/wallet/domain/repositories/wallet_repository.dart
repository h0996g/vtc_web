import '../entities/wallet_operation_entity.dart';

abstract class WalletRepository {
  Future<({WalletEntity wallet, TransactionEntity transaction})> creditWallet({
    required String userId,
    required int amount,
    String? reference,
  });

  Future<({WalletEntity wallet, TransactionEntity transaction})> debitWallet({
    required String userId,
    required int amount,
    String? reference,
  });
}
