import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/auth_card_widget.dart';
import '../widgets/change_password/change_password_form_widget.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Change Password',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Update your administrator account password',
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 32),
          const AuthCardWidget(
            maxWidth: 500,
            child: ChangePasswordFormWidget(),
          ),
        ],
      ),
    );
  }
}
