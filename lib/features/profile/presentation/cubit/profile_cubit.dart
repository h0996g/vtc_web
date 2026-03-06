import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../domain/repositories/profile_repository.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._repository) : super(const ProfileInitial());

  final ProfileRepository _repository;

  Future<void> loadProfile() async {
    emit(const ProfileLoading());
    try {
      final admin = await _repository.getProfile();
      emit(ProfileLoaded(admin));
    } catch (e) {
      emit(ProfileError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> updateProfile({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? address,
    String? wilaya,
    String? commune,
  }) async {
    final current = state;
    if (current is ProfileLoaded) emit(ProfileUpdating(current.admin));
    try {
      final admin = await _repository.updateProfile(
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        address: address,
        wilaya: wilaya,
        commune: commune,
      );
      emit(ProfileLoaded(admin));
      Fluttertoast.showToast(
        msg: 'Profile updated successfully',
        backgroundColor: const Color(0xFF10B981),
        textColor: Colors.white,
      );
    } catch (e) {
      final message = e.toString().replaceFirst('Exception: ', '');
      if (current is ProfileLoaded) emit(ProfileLoaded(current.admin));
      Fluttertoast.showToast(
        msg: message,
        backgroundColor: const Color(0xFFEF4444),
        textColor: Colors.white,
      );
    }
  }

  Future<void> updatePhoto(String filePath) async {
    final current = state;
    if (current is ProfileLoaded) emit(ProfileUpdating(current.admin));
    try {
      final admin = await _repository.updatePhoto(filePath);
      emit(ProfileLoaded(admin));
      Fluttertoast.showToast(
        msg: 'Photo updated successfully',
        backgroundColor: const Color(0xFF10B981),
        textColor: Colors.white,
      );
    } catch (e) {
      final message = e.toString().replaceFirst('Exception: ', '');
      if (current is ProfileLoaded) emit(ProfileLoaded(current.admin));
      Fluttertoast.showToast(
        msg: message,
        backgroundColor: const Color(0xFFEF4444),
        textColor: Colors.white,
      );
    }
  }
}
