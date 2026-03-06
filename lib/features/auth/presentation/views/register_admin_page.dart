import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/auth_card_widget.dart';
import '../widgets/register_admin/register_admin_form_widget.dart';

class RegisterAdminPage extends StatelessWidget {
  const RegisterAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Create Admin Account',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Add a new administrator to the system',
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 32),
          const AuthCardWidget(
            maxWidth: 600,
            child: RegisterAdminFormWidget(),
          ),
        ],
      ),
    );
  }
}
