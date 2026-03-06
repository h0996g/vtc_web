import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import 'driver_state.dart';

class DriverCubit extends Cubit<DriverState> {
  DriverCubit(this._dataSource) : super(const DriverInitial());

  final AuthRemoteDataSource _dataSource;

  Future<void> registerDriver({
    required String email,
    required String password,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required String vehicleType,
    required String vehicleModel,
    required int vehicleYear,
    required String vehiclePlate,
    String? sex,
    String? dateOfBirth,
    String? address,
    String? wilaya,
    String? commune,
  }) async {
    emit(const DriverLoading());
    try {
      await _dataSource.registerDriver(
        email: email,
        password: password,
        phoneNumber: phoneNumber,
        firstName: firstName,
        lastName: lastName,
        vehicleType: vehicleType,
        vehicleModel: vehicleModel,
        vehicleYear: vehicleYear,
        vehiclePlate: vehiclePlate,
        sex: sex,
        dateOfBirth: dateOfBirth,
        address: address,
        wilaya: wilaya,
        commune: commune,
      );
      emit(const DriverRegistered());
      Fluttertoast.showToast(
        msg: 'Driver $firstName $lastName registered successfully!',
        backgroundColor: const Color(0xFF10B981),
        textColor: const Color(0xFFFFFFFF),
      );
    } catch (e) {
      final message = e.toString().replaceFirst('Exception: ', '');
      emit(DriverError(message));
      Fluttertoast.showToast(
        msg: message,
        backgroundColor: const Color(0xFFEF4444),
        textColor: const Color(0xFFFFFFFF),
      );
    }
  }
}
