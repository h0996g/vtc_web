import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../cubit/driver_cubit.dart';
import '../cubit/driver_state.dart';

class RegisterDriverPage extends StatefulWidget {
  const RegisterDriverPage({super.key});

  @override
  State<RegisterDriverPage> createState() => _RegisterDriverPageState();
}

class _RegisterDriverPageState extends State<RegisterDriverPage> {
  final _formKey = GlobalKey<FormState>();

  // Personal info
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _wilayaCtrl = TextEditingController();
  final _communeCtrl = TextEditingController();

  // Vehicle info
  final _vehicleModelCtrl = TextEditingController();
  final _vehicleYearCtrl = TextEditingController();
  final _vehiclePlateCtrl = TextEditingController();

  String _vehicleType = 'CAR';
  bool _obscure = true;

  static const _vehicleTypes = ['CAR', 'VAN', 'TRUCK', 'MOTORCYCLE'];

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    _wilayaCtrl.dispose();
    _communeCtrl.dispose();
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
          wilaya: _wilayaCtrl.text.trim().isEmpty ? null : _wilayaCtrl.text.trim(),
          commune: _communeCtrl.text.trim().isEmpty ? null : _communeCtrl.text.trim(),
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
    _wilayaCtrl.clear();
    _communeCtrl.clear();
    _vehicleModelCtrl.clear();
    _vehicleYearCtrl.clear();
    _vehiclePlateCtrl.clear();
    setState(() => _vehicleType = 'CAR');
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DriverCubit, DriverState>(
      listener: (context, state) {
        if (state is DriverRegistered) _reset();
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Register Driver',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.dark,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Create a new driver account with vehicle details',
              style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
            ),
            const SizedBox(height: 32),
            Container(
              constraints: const BoxConstraints(maxWidth: 660),
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SectionLabel('Personal Information'),
                    const SizedBox(height: 16),
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
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                          size: 20,
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
                      validator: (v) => v == null || v.isEmpty ? 'Phone number is required' : null,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: AppTextField(
                            label: 'Wilaya (optional)',
                            controller: _wilayaCtrl,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: AppTextField(
                            label: 'Commune (optional)',
                            controller: _communeCtrl,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      label: 'Address (optional)',
                      controller: _addressCtrl,
                    ),
                    const SizedBox(height: 28),
                    _SectionLabel('Vehicle Information'),
                    const SizedBox(height: 16),
                    // Vehicle type selector
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Vehicle Type',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF374151),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: _vehicleTypes.map((type) {
                            final selected = _vehicleType == type;
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: ChoiceChip(
                                label: Text(type),
                                selected: selected,
                                onSelected: (_) => setState(() => _vehicleType = type),
                                selectedColor: AppColors.primary,
                                labelStyle: TextStyle(
                                  color: selected ? Colors.white : const Color(0xFF374151),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                ),
                                backgroundColor: const Color(0xFFF3F4F6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  side: BorderSide(
                                    color: selected ? AppColors.primary : const Color(0xFFE5E7EB),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      label: 'Model',
                      controller: _vehicleModelCtrl,
                      validator: (v) => v == null || v.isEmpty ? 'Model is required' : null,
                    ),
                    const SizedBox(height: 16),
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
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: AppColors.dark,
      ),
    );
  }
}
