import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.isUsed});

  final bool isUsed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isUsed
            ? AppColors.error.withValues(alpha: 0.1)
            : AppColors.success.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isUsed ? 'Used' : 'Available',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: isUsed ? AppColors.error : AppColors.success,
        ),
      ),
    );
  }
}
