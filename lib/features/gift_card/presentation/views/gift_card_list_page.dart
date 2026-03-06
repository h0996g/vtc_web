import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/device_type.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/shimmer_loader.dart';
import '../cubit/gift_card_cubit.dart';
import '../cubit/gift_card_state.dart';
import 'widgets/gift_card_table_widget.dart';
import 'widgets/gift_card_list/stats_row_widget.dart';

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
    final isMobile = DeviceTypeQuery.isMobile(context);

    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 16 : 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isMobile) ...[
            const Text(
              'Gift Cards',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Manage promotional gift cards',
              style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
            ),
            const SizedBox(height: 16),
            AppButton(
              label: 'Create Gift Card',
              onPressed: () => context.push(RouteNames.createGiftCard),
              icon: Icons.add,
              width: double.infinity,
            ),
          ] else
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
                      const Icon(
                        Icons.error_outline,
                        size: 48,
                        color: AppColors.error,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        state.message,
                        style: const TextStyle(color: AppColors.error),
                      ),
                      const SizedBox(height: 16),
                      AppButton(
                        label: 'Retry',
                        onPressed: () =>
                            context.read<GiftCardCubit>().loadGiftCards(),
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
                        Icon(
                          Icons.card_giftcard_outlined,
                          size: 64,
                          color: Color(0xFFD1D5DB),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No gift cards yet',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF9CA3AF),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StatsRowWidget(giftCards: state.giftCards),
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
