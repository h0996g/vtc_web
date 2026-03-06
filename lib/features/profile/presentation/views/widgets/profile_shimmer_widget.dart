import 'package:flutter/material.dart';
import '../../../../../core/widgets/shimmer_loader.dart';

class ProfileShimmerWidget extends StatelessWidget {
  const ProfileShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Avatar card shimmer
        Container(
          constraints: const BoxConstraints(maxWidth: 660),
          child: const ShimmerLoader(height: 120),
        ),
        const SizedBox(height: 24),
        // Form card shimmer
        Container(
          constraints: const BoxConstraints(maxWidth: 660),
          child: Column(
            children: [
              const ShimmerLoader(height: 28, width: 180),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Expanded(child: ShimmerLoader(height: 56)),
                  SizedBox(width: 16),
                  Expanded(child: ShimmerLoader(height: 56)),
                ],
              ),
              const SizedBox(height: 16),
              const ShimmerLoader(height: 56),
              const SizedBox(height: 16),
              const Row(
                children: [
                  Expanded(child: ShimmerLoader(height: 56)),
                  SizedBox(width: 16),
                  Expanded(child: ShimmerLoader(height: 56)),
                ],
              ),
              const SizedBox(height: 16),
              const ShimmerLoader(height: 56),
            ],
          ),
        ),
      ],
    );
  }
}
