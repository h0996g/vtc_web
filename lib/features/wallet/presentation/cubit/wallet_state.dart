import 'package:equatable/equatable.dart';
import '../../domain/entities/wallet_operation_entity.dart';

abstract class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object?> get props => [];
}

class WalletInitial extends WalletState {
  const WalletInitial();
}

class WalletLoading extends WalletState {
  const WalletLoading();
}

class WalletOperationSuccess extends WalletState {
  const WalletOperationSuccess({
    required this.wallet,
    required this.transaction,
  });

  final WalletEntity wallet;
  final TransactionEntity transaction;

  @override
  List<Object?> get props => [wallet, transaction];
}

class WalletError extends WalletState {
  const WalletError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
