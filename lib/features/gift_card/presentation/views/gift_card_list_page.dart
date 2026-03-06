import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/shimmer_loader.dart';
import '../cubit/gift_card_cubit.dart';
import '../cubit/gift_card_state.dart';
import '../widgets/gift_card_table.dart';

class GiftCardListPage extends StatefulWidget {
  const GiftCardListPage({super.key});

  @override
  State<GiftCardListPage> createState() => _GiftCardListPageState();
}

class _GiftCardListPageState extends State<GiftCardListPage> {
  @override
  void initState() {
    super.initState();
    context.read<GiftCardCubit>().loadGiftCards();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Gift Cards',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Manage promotional gift cards',
                    style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
                  ),
                ],
              ),
              AppButton(
                label: 'Create Gift Card',
                onPressed: () => context.push(RouteNames.createGiftCard),
                icon: Icons.add,
              ),
            ],
          ),
          const SizedBox(height: 32),
          BlocBuilder<GiftCardCubit, GiftCardState>(
            builder: (context, state) {
              if (state is GiftCardLoading) {
                return const ShimmerTableLoader();
              }
              if (state is GiftCardError) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.error_outline, size: 48, color: AppColors.error),
                      const SizedBox(height: 12),
                      Text(state.message, style: const TextStyle(color: AppColors.error)),
                      const SizedBox(height: 16),
                      AppButton(
                        label: 'Retry',
                        onPressed: () => context.read<GiftCardCubit>().loadGiftCards(),
                        isOutlined: true,
                      ),
                    ],
                  ),
                );
              }
              if (state is GiftCardLoaded) {
                if (state.giftCards.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.card_giftcard_outlined, size: 64, color: Color(0xFFD1D5DB)),
                        SizedBox(height: 16),
                        Text(
                          'No gift cards yet',
                          style: TextStyle(fontSize: 16, color: Color(0xFF9CA3AF)),
                        ),
                      ],
                    ),
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _StatsRow(giftCards: state.giftCards),
                    const SizedBox(height: 24),
                    GiftCardTable(giftCards: state.giftCards),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.giftCards});

  final List giftCards;

  @override
  Widget build(BuildContext context) {
    final total = giftCards.length;
    final used = giftCards.where((c) => c.isUsed).length;
    final available = total - used;

    return Row(
      children: [
        _StatCard(label: 'Total', value: '$total', icon: Icons.card_giftcard_outlined),
        const SizedBox(width: 16),
        _StatCard(label: 'Available', value: '$available', icon: Icons.check_circle_outline, color: AppColors.success),
        const SizedBox(width: 16),
        _StatCard(label: 'Used', value: '$used', icon: Icons.cancel_outlined, color: AppColors.error),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
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
                style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
