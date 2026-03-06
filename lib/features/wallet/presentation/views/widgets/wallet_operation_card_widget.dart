import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../cubit/wallet_cubit.dart';
import '../../cubit/wallet_state.dart';

class WalletOperationCardWidget extends StatelessWidget {
  const WalletOperationCardWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.formKey,
    required this.userCtrl,
    required this.amountCtrl,
    required this.refCtrl,
    required this.isCredit,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final GlobalKey<FormState> formKey;
  final TextEditingController userCtrl;
  final TextEditingController amountCtrl;
  final TextEditingController refCtrl;
  final bool isCredit;

  void _submit(BuildContext context) {
    if (!formKey.currentState!.validate()) return;
    final userId = userCtrl.text.trim();
    final amount = int.parse(amountCtrl.text);
    final reference = refCtrl.text.trim().isEmpty ? null : refCtrl.text.trim();
    if (isCredit) {
      context.read<WalletCubit>().creditWallet(
            userId: userId,
            amount: amount,
            reference: reference,
          );
    } else {
      context.read<WalletCubit>().debitWallet(
            userId: userId,
            amount: amount,
            reference: reference,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.accent),
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: iconColor, size: 22),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            AppTextField(
              label: 'User ID',
              controller: userCtrl,
              prefixIcon: const Icon(Icons.person_outline, size: 20),
              validator: (v) =>
                  v == null || v.isEmpty ? 'User ID is required' : null,
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'Amount (DA)',
              controller: amountCtrl,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              prefixIcon: const Icon(Icons.payments_outlined, size: 20),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Amount is required';
                final n = int.tryParse(v);
                if (n == null || n <= 0) return 'Enter a valid positive amount';
                return null;
              },
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'Reference (optional)',
              controller: refCtrl,
              prefixIcon: const Icon(Icons.notes_outlined, size: 20),
            ),
            const SizedBox(height: 24),
            BlocBuilder<WalletCubit, WalletState>(
              builder: (context, state) => AppButton(
                label: isCredit ? 'Credit Wallet' : 'Debit Wallet',
                onPressed: () => _submit(context),
                isLoading: state is WalletLoading,
                width: double.infinity,
                icon: isCredit ? Icons.add : Icons.remove,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
