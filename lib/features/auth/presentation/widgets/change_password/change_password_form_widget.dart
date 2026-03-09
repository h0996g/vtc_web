import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/device_type.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../cubit/auth_cubit.dart';
import '../../cubit/auth_state.dart';

class ChangePasswordFormWidget extends StatefulWidget {
  const ChangePasswordFormWidget({super.key});

  @override
  State<ChangePasswordFormWidget> createState() => _ChangePasswordFormWidgetState();
}

class _ChangePasswordFormWidgetState extends State<ChangePasswordFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordCtrl = TextEditingController();
  final _newPasswordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();

  bool _obscureOld = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _oldPasswordCtrl.dispose();
    _newPasswordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthCubit>().changePassword(
      oldPassword: _oldPasswordCtrl.text,
      newPassword: _newPasswordCtrl.text,
      confirmPassword: _confirmPasswordCtrl.text,
    );
  }

  void _reset() {
    _formKey.currentState?.reset();
    _oldPasswordCtrl.clear();
    _newPasswordCtrl.clear();
    _confirmPasswordCtrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = DeviceTypeQuery.isMobile(context);

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is PasswordChanged) _reset();
      },
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextField(
              label: 'Current Password',
              controller: _oldPasswordCtrl,
              obscureText: _obscureOld,
              prefixIcon: const Icon(Icons.lock_outline, size: 20, color: AppColors.textSecondary),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureOld ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  size: 20,
                  color: AppColors.textSecondary,
                ),
                onPressed: () => setState(() => _obscureOld = !_obscureOld),
              ),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Current password is required';
                return null;
              },
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'New Password',
              controller: _newPasswordCtrl,
              obscureText: _obscureNew,
              prefixIcon: const Icon(Icons.lock_outline, size: 20, color: AppColors.textSecondary),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureNew ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  size: 20,
                  color: AppColors.textSecondary,
                ),
                onPressed: () => setState(() => _obscureNew = !_obscureNew),
              ),
              validator: (v) {
                if (v == null || v.isEmpty) return 'New password is required';
                if (v.length < 6) return 'Minimum 6 characters';
                return null;
              },
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'Confirm New Password',
              controller: _confirmPasswordCtrl,
              obscureText: _obscureConfirm,
              prefixIcon: const Icon(Icons.lock_outline, size: 20, color: AppColors.textSecondary),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirm ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  size: 20,
                  color: AppColors.textSecondary,
                ),
                onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
              ),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Please confirm your new password';
                if (v != _newPasswordCtrl.text) return 'Passwords do not match';
                return null;
              },
            ),
            const SizedBox(height: 28),
            if (isMobile) ...[
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) => AppButton(
                  label: 'Change Password',
                  onPressed: _submit,
                  isLoading: state is AuthLoading,
                  icon: Icons.lock_reset,
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
                      label: 'Change Password',
                      onPressed: _submit,
                      isLoading: state is AuthLoading,
                      icon: Icons.lock_reset,
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
