import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../domain/repositories/gift_card_repository.dart';
import 'gift_card_state.dart';

class GiftCardCubit extends Cubit<GiftCardState> {
  GiftCardCubit(this._repository) : super(const GiftCardInitial());

  final GiftCardRepository _repository;

  Future<void> loadGiftCards() async {
    emit(const GiftCardLoading());
    try {
      final cards = await _repository.getGiftCards();
      emit(GiftCardLoaded(cards));
    } catch (e) {
      final message = e.toString().replaceFirst('Exception: ', '');
      emit(GiftCardError(message));
      Fluttertoast.showToast(
        msg: message,
        backgroundColor: const Color(0xFFEF4444),
        textColor: Colors.white,
      );
    }
  }

  Future<void> createGiftCard({required int amount, String? code}) async {
    emit(const GiftCardCreating());
    try {
      final card = await _repository.createGiftCard(amount: amount, code: code);
      Fluttertoast.showToast(
        msg: 'Gift card ${card.code} created!',
        backgroundColor: const Color(0xFF10B981),
        textColor: Colors.white,
      );
      emit(GiftCardCreated(card));
      await loadGiftCards();
    } catch (e) {
      final message = e.toString().replaceFirst('Exception: ', '');
      emit(GiftCardError(message));
      Fluttertoast.showToast(
        msg: message,
        backgroundColor: const Color(0xFFEF4444),
        textColor: Colors.white,
      );
    }
  }
}
