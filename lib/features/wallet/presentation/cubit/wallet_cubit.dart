import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../domain/repositories/wallet_repository.dart';
import 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletCubit(this._repository) : super(const WalletInitial());

  final WalletRepository _repository;

  Future<void> creditWallet({
    required String userId,
    required int amount,
    String? reference,
  }) async {
    emit(const WalletLoading());
    try {
      final result = await _repository.creditWallet(
        userId: userId,
        amount: amount,
        reference: reference,
      );
      emit(WalletOperationSuccess(
        wallet: result.wallet,
        transaction: result.transaction,
      ));
      Fluttertoast.showToast(
        msg: 'Wallet credited +$amount DA. New balance: ${result.wallet.balance} DA',
        backgroundColor: const Color(0xFF10B981),
        textColor: Colors.white,
      );
    } catch (e) {
      final message = e.toString().replaceFirst('Exception: ', '');
      emit(WalletError(message));
      Fluttertoast.showToast(
        msg: message,
        backgroundColor: const Color(0xFFEF4444),
        textColor: Colors.white,
      );
    }
  }

  Future<void> debitWallet({
    required String userId,
    required int amount,
    String? reference,
  }) async {
    emit(const WalletLoading());
    try {
      final result = await _repository.debitWallet(
        userId: userId,
        amount: amount,
        reference: reference,
      );
      emit(WalletOperationSuccess(
        wallet: result.wallet,
        transaction: result.transaction,
      ));
      Fluttertoast.showToast(
        msg: 'Wallet debited -$amount DA. New balance: ${result.wallet.balance} DA',
        backgroundColor: const Color(0xFF3D5AFE),
        textColor: Colors.white,
      );
    } catch (e) {
      final message = e.toString().replaceFirst('Exception: ', '');
      emit(WalletError(message));
      Fluttertoast.showToast(
        msg: message,
        backgroundColor: const Color(0xFFEF4444),
        textColor: Colors.white,
      );
    }
  }

  void reset() => emit(const WalletInitial());
}
