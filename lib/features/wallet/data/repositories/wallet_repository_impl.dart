import '../../domain/entities/wallet_operation_entity.dart';
import '../../domain/repositories/wallet_repository.dart';
import '../datasources/wallet_remote_datasource.dart';
import '../models/wallet_operation_model.dart';

class WalletRepositoryImpl implements WalletRepository {
  WalletRepositoryImpl(this._dataSource);

  final WalletRemoteDataSource _dataSource;

  @override
  Future<({WalletEntity wallet, TransactionEntity transaction})> creditWallet({
    required String userId,
    required int amount,
    String? reference,
  }) async {
    final data = await _dataSource.creditWallet(
      userId: userId,
      amount: amount,
      reference: reference,
    );
    return (
      wallet: WalletModel.fromJson(data['wallet'] as Map<String, dynamic>),
      transaction: TransactionModel.fromJson(data['transaction'] as Map<String, dynamic>),
    );
  }

  @override
  Future<({WalletEntity wallet, TransactionEntity transaction})> debitWallet({
    required String userId,
    required int amount,
    String? reference,
  }) async {
    final data = await _dataSource.debitWallet(
      userId: userId,
      amount: amount,
      reference: reference,
    );
    return (
      wallet: WalletModel.fromJson(data['wallet'] as Map<String, dynamic>),
      transaction: TransactionModel.fromJson(data['transaction'] as Map<String, dynamic>),
    );
  }
}
