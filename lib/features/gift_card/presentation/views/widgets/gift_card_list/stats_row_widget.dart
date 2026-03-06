import 'package:flutter/material.dart';
import '../../../../../../core/theme/app_colors.dart';

class StatsRowWidget extends StatelessWidget {
  const StatsRowWidget({super.key, required this.giftCards});

  final List giftCards;

  @override
  Widget build(BuildContext context) {
    final total = giftCards.length;
    final used = giftCards.where((c) => c.isUsed).length;
    final available = total - used;

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        StatCardWidget(
          label: 'Total',
          value: '$total',
          icon: Icons.card_giftcard_outlined,
        ),
        StatCardWidget(
          label: 'Available',
          value: '$available',
          icon: Icons.check_circle_outline,
          color: AppColors.success,
        ),
        StatCardWidget(
          label: 'Used',
          value: '$used',
          icon: Icons.cancel_outlined,
          color: AppColors.error,
        ),
      ],
    );
  }
}

class StatCardWidget extends StatelessWidget {
  const StatCardWidget({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.color = AppColors.secondary,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.accent),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
