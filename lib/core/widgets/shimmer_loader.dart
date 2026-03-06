import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../theme/app_colors.dart';

class ShimmerLoader extends StatelessWidget {
  const ShimmerLoader({super.key, this.height = 60, this.width = double.infinity});

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.accent,
      highlightColor: AppColors.cardBackground,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: AppColors.accent,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

class ShimmerTableLoader extends StatelessWidget {
  const ShimmerTableLoader({super.key, this.rows = 6});

  final int rows;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        rows,
        (i) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: ShimmerLoader(height: 52),
        ),
      ),
    );
  }
}
