import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../core/auth/auth_functions.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../../profile/domain/repositories/profile_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository, this._profileRepository)
      : super(const AuthInitial());

  final AuthRepository _authRepository;
  final ProfileRepository _profileRepository;

  /// Called on app start — restores session if a valid token exists.
  Future<void> checkAuthStatus() async {
    final admin = await AuthFunctions.restoreSession(
      profileRepository: _profileRepository,
    );
    if (admin != null) {
      emit(AuthAuthenticated(admin));
    } else {
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> login({required String email, required String password}) async {
    emit(const AuthLoading());
    try {
      final admin = await AuthFunctions.login(
        authRepository: _authRepository,
        profileRepository: _profileRepository,
        email: email,
        password: password,
      );
      emit(AuthAuthenticated(admin));
      Fluttertoast.showToast(
        msg: 'Welcome back, ${admin.firstName}!',
        backgroundColor: const Color(0xFF10B981),
        textColor: Colors.white,
      );
    } catch (e) {
      final message = e.toString().replaceFirst('Exception: ', '');
      emit(AuthError(message));
      Fluttertoast.showToast(
        msg: message,
        backgroundColor: const Color(0xFFEF4444),
        textColor: Colors.white,
      );
    }
  }

  Future<void> registerAdmin({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? phoneNumber,
  }) async {
    emit(const AuthLoading());
    try {
      final result = await _authRepository.registerAdmin(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
      );
      emit(AdminRegistered(result.admin));
      Fluttertoast.showToast(
        msg: 'Admin ${result.admin.fullName} created successfully!',
        backgroundColor: const Color(0xFF10B981),
        textColor: Colors.white,
      );
    } catch (e) {
      final message = e.toString().replaceFirst('Exception: ', '');
      emit(AuthError(message));
      Fluttertoast.showToast(
        msg: message,
        backgroundColor: const Color(0xFFEF4444),
        textColor: Colors.white,
      );
    }
  }

  Future<void> logout() async {
    await AuthFunctions.logout();
    emit(const AuthUnauthenticated());
  }
}
