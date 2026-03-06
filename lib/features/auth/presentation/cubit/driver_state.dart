import 'package:equatable/equatable.dart';

abstract class DriverState extends Equatable {
  const DriverState();

  @override
  List<Object?> get props => [];
}

class DriverInitial extends DriverState {
  const DriverInitial();
}

class DriverLoading extends DriverState {
  const DriverLoading();
}

class DriverRegistered extends DriverState {
  const DriverRegistered();
}

class DriverError extends DriverState {
  const DriverError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
