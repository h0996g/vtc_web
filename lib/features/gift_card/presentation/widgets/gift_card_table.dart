import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../domain/entities/gift_card_entity.dart';

class GiftCardTable extends StatelessWidget {
  const GiftCardTable({super.key, required this.giftCards});

  final List<GiftCardEntity> giftCards;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(const Color(0xFFF9FAFB)),
          headingTextStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF6B7280),
          ),
          dataTextStyle: const TextStyle(fontSize: 13, color: AppColors.dark),
          columnSpacing: 24,
          horizontalMargin: 20,
          columns: const [
            DataColumn(label: Text('CODE')),
            DataColumn(label: Text('AMOUNT'), numeric: true),
            DataColumn(label: Text('STATUS')),
            DataColumn(label: Text('USED BY')),
            DataColumn(label: Text('USED AT')),
          ],
          rows: giftCards.map((card) {
            return DataRow(
              cells: [
                DataCell(
                  Text(
                    card.code,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                DataCell(
                  Text(
                    '${NumberFormat('#,###').format(card.amount)} DA',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                DataCell(StatusBadge(isUsed: card.isUsed)),
                DataCell(Text(card.usedBy ?? '—')),
                DataCell(
                  Text(
                    card.usedAt != null
                        ? DateFormat('dd MMM yyyy').format(card.usedAt!)
                        : '—',
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
