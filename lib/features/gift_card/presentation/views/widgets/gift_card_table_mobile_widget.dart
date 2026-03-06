import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/status_badge.dart';
import '../../../domain/entities/gift_card_entity.dart';

class GiftCardTableMobile extends StatelessWidget {
  const GiftCardTableMobile({super.key, required this.giftCards});

  final List<GiftCardEntity> giftCards;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: giftCards.map((card) => _GiftCardCard(card: card)).toList(),
    );
  }
}

class _GiftCardCard extends StatelessWidget {
  const _GiftCardCard({required this.card});

  final GiftCardEntity card;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.accent),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                card.code,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: AppColors.secondary,
                ),
              ),
              StatusBadge(isUsed: card.isUsed),
            ],
          ),
          const SizedBox(height: 10),
          _InfoRow(
            label: 'Amount',
            value: '${NumberFormat('#,###').format(card.amount)} DA',
          ),
          if (card.usedBy != null) ...[
            const SizedBox(height: 6),
            _InfoRow(label: 'Used by', value: card.usedBy!),
          ],
          if (card.usedAt != null) ...[
            const SizedBox(height: 6),
            _InfoRow(
              label: 'Used at',
              value: DateFormat('dd MMM yyyy').format(card.usedAt!),
            ),
          ],
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 13, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
