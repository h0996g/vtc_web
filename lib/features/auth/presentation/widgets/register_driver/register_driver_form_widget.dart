import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/device_type.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/wilaya_commune_selector_widget.dart';
import '../../cubit/driver_cubit.dart';
import '../../cubit/driver_state.dart';
import 'section_label_widget.dart';
import 'vehicle_type_selector_widget.dart';

class RegisterDriverFormWidget extends StatefulWidget {
  const RegisterDriverFormWidget({super.key});

  @override
  State<RegisterDriverFormWidget> createState() => _RegisterDriverFormWidgetState();
}

class _RegisterDriverFormWidgetState extends State<RegisterDriverFormWidget> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _vehicleModelCtrl = TextEditingController();
  String? _wilaya;
  String? _commune;
  final _vehicleYearCtrl = TextEditingController();
  final _vehiclePlateCtrl = TextEditingController();

  String _vehicleType = 'CAR';
  bool _obscure = true;

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    _vehicleModelCtrl.dispose();
    _vehicleYearCtrl.dispose();
    _vehiclePlateCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<DriverCubit>().registerDriver(
          email: _emailCtrl.text.trim(),
          password: _passwordCtrl.text,
          phoneNumber: _phoneCtrl.text.trim(),
          firstName: _firstNameCtrl.text.trim(),
          lastName: _lastNameCtrl.text.trim(),
          vehicleType: _vehicleType,
          vehicleModel: _vehicleModelCtrl.text.trim(),
          vehicleYear: int.parse(_vehicleYearCtrl.text.trim()),
          vehiclePlate: _vehiclePlateCtrl.text.trim(),
          address: _addressCtrl.text.trim().isEmpty ? null : _addressCtrl.text.trim(),
          wilaya: _wilaya,
          commune: _commune,
        );
  }

  void _reset() {
    _formKey.currentState?.reset();
    _firstNameCtrl.clear();
    _lastNameCtrl.clear();
    _emailCtrl.clear();
    _passwordCtrl.clear();
    _phoneCtrl.clear();
    _addressCtrl.clear();
    _vehicleModelCtrl.clear();
    _vehicleYearCtrl.clear();
    _vehiclePlateCtrl.clear();
    setState(() {
      _wilaya = null;
      _commune = null;
      _vehicleType = 'CAR';
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = DeviceTypeQuery.isMobile(context);

    return BlocListener<DriverCubit, DriverState>(
      listener: (context, state) {
        if (state is DriverRegistered) _reset();
      },
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionLabelWidget('Personal Information'),
            const SizedBox(height: 16),
            if (isMobile) ...[
              AppTextField(
                label: 'First Name',
                controller: _firstNameCtrl,
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: 'Last Name',
                controller: _lastNameCtrl,
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
            ] else
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      label: 'First Name',
                      controller: _firstNameCtrl,
                      validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AppTextField(
                      label: 'Last Name',
                      controller: _lastNameCtrl,
                      validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'Email',
              controller: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: const Icon(Icons.email_outlined, size: 20, color: AppColors.textSecondary),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Email is required';
                if (!v.contains('@')) return 'Enter a valid email';
                return null;
              },
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'Password',
              controller: _passwordCtrl,
              obscureText: _obscure,
              prefixIcon: const Icon(Icons.lock_outline, size: 20, color: AppColors.textSecondary),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  size: 20,
                  color: AppColors.textSecondary,
                ),
                onPressed: () => setState(() => _obscure = !_obscure),
              ),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Password is required';
                if (v.length < 8) return 'Minimum 8 characters';
                return null;
              },
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'Phone Number',
              controller: _phoneCtrl,
              keyboardType: TextInputType.phone,
              prefixIcon: const Icon(Icons.phone_outlined, size: 20, color: AppColors.textSecondary),
              validator: (v) => v == null || v.isEmpty ? 'Phone number is required' : null,
            ),
            const SizedBox(height: 16),
            WilayaCommuneSelector(
              initialWilaya: _wilaya,
              initialCommune: _commune,
              onWilayaChanged: (v) => setState(() => _wilaya = v),
              onCommuneChanged: (v) => setState(() => _commune = v),
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'Address (optional)',
              controller: _addressCtrl,
            ),
            const SizedBox(height: 28),
            const SectionLabelWidget('Vehicle Information'),
            const SizedBox(height: 16),
            VehicleTypeSelectorWidget(
              selected: _vehicleType,
              onChanged: (t) => setState(() => _vehicleType = t),
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'Model',
              controller: _vehicleModelCtrl,
              prefixIcon: const Icon(Icons.directions_car_outlined, size: 20, color: AppColors.textSecondary),
              validator: (v) => v == null || v.isEmpty ? 'Model is required' : null,
            ),
            const SizedBox(height: 16),
            if (isMobile) ...[
              AppTextField(
                label: 'Year',
                controller: _vehicleYearCtrl,
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Year is required';
                  final year = int.tryParse(v);
                  if (year == null || year < 1990 || year > 2030) return 'Enter a valid year';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: 'Plate Number',
                controller: _vehiclePlateCtrl,
                validator: (v) => v == null || v.isEmpty ? 'Plate is required' : null,
              ),
            ] else
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      label: 'Year',
                      controller: _vehicleYearCtrl,
                      keyboardType: TextInputType.number,
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Year is required';
                        final year = int.tryParse(v);
                        if (year == null || year < 1990 || year > 2030) {
                          return 'Enter a valid year';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AppTextField(
                      label: 'Plate Number',
                      controller: _vehiclePlateCtrl,
                      validator: (v) => v == null || v.isEmpty ? 'Plate is required' : null,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 32),
            if (isMobile) ...[
              BlocBuilder<DriverCubit, DriverState>(
                builder: (context, state) => AppButton(
                  label: 'Register Driver',
                  onPressed: _submit,
                  isLoading: state is DriverLoading,
                  icon: Icons.directions_car_outlined,
                  width: double.infinity,
                ),
              ),
              const SizedBox(height: 12),
              AppButton(
                label: 'Cancel',
                onPressed: () => context.pop(),
                isOutlined: true,
                width: double.infinity,
              ),
            ] else
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppButton(
                    label: 'Cancel',
                    onPressed: () => context.pop(),
                    isOutlined: true,
                  ),
                  const SizedBox(width: 12),
                  BlocBuilder<DriverCubit, DriverState>(
                    builder: (context, state) => AppButton(
                      label: 'Register Driver',
                      onPressed: _submit,
                      isLoading: state is DriverLoading,
                      icon: Icons.directions_car_outlined,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
