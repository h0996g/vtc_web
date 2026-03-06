import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/auth_card_widget.dart';
import '../widgets/register_driver/register_driver_form_widget.dart';

class RegisterDriverPage extends StatelessWidget {
  const RegisterDriverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Register Driver',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Create a new driver account with vehicle details',
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 32),
          const AuthCardWidget(
            maxWidth: 660,
            child: RegisterDriverFormWidget(),
          ),
        ],
      ),
    );
  }
}
