import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/device_type.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../cubit/auth_cubit.dart';
import '../../cubit/auth_state.dart';

class RegisterAdminFormWidget extends StatefulWidget {
  const RegisterAdminFormWidget({super.key});

  @override
  State<RegisterAdminFormWidget> createState() => _RegisterAdminFormWidgetState();
}

class _RegisterAdminFormWidgetState extends State<RegisterAdminFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthCubit>().registerAdmin(
          email: _emailCtrl.text.trim(),
          password: _passwordCtrl.text,
          firstName: _firstNameCtrl.text.trim(),
          lastName: _lastNameCtrl.text.trim(),
          phoneNumber: _phoneCtrl.text.trim().isEmpty ? null : _phoneCtrl.text.trim(),
        );
  }

  void reset() {
    _formKey.currentState?.reset();
    _emailCtrl.clear();
    _passwordCtrl.clear();
    _firstNameCtrl.clear();
    _lastNameCtrl.clear();
    _phoneCtrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = DeviceTypeQuery.isMobile(context);

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AdminRegistered) reset();
      },
      child: Form(
        key: _formKey,
        child: Column(
          children: [
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
                if (v.length < 6) return 'Minimum 6 characters';
                return null;
              },
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'Phone Number (optional)',
              controller: _phoneCtrl,
              keyboardType: TextInputType.phone,
              prefixIcon: const Icon(Icons.phone_outlined, size: 20, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 28),
            if (isMobile) ...[
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) => AppButton(
                  label: 'Create Admin',
                  onPressed: _submit,
                  isLoading: state is AuthLoading,
                  icon: Icons.person_add_outlined,
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
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) => AppButton(
                      label: 'Create Admin',
                      onPressed: _submit,
                      isLoading: state is AuthLoading,
                      icon: Icons.person_add_outlined,
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
