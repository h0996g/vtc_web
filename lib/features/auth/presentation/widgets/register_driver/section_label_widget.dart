import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';

class SectionLabelWidget extends StatelessWidget {
  const SectionLabelWidget(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 18,
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppColors.secondary,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}
