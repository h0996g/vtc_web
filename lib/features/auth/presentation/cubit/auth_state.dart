import 'package:equatable/equatable.dart';
import '../../domain/entities/admin_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthAuthenticated extends AuthState {
  const AuthAuthenticated(this.admin);

  final AdminEntity admin;

  @override
  List<Object?> get props => [admin];
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

class AuthError extends AuthState {
  const AuthError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class AdminRegistered extends AuthState {
  const AdminRegistered(this.admin);

  final AdminEntity admin;

  @override
  List<Object?> get props => [admin];
}

class PasswordChanged extends AuthState {
  const PasswordChanged();
}
