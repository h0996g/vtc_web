import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../cubit/gift_card_cubit.dart';
import '../cubit/gift_card_state.dart';

class CreateGiftCardPage extends StatefulWidget {
  const CreateGiftCardPage({super.key});

  @override
  State<CreateGiftCardPage> createState() => _CreateGiftCardPageState();
}

class _CreateGiftCardPageState extends State<CreateGiftCardPage> {
  final _formKey = GlobalKey<FormState>();
  final _amountCtrl = TextEditingController();
  final _codeCtrl = TextEditingController();

  @override
  void dispose() {
    _amountCtrl.dispose();
    _codeCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final amount = int.parse(_amountCtrl.text.replaceAll(',', ''));
    final code = _codeCtrl.text.trim().isEmpty ? null : _codeCtrl.text.trim();
    context.read<GiftCardCubit>().createGiftCard(amount: amount, code: code);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GiftCardCubit, GiftCardState>(
      listener: (context, state) {
        if (state is GiftCardCreated) context.pop();
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.cardBackground,
                    side: const BorderSide(color: AppColors.accent),
                  ),
                ),
                const SizedBox(width: 16),
                const Text(
                  'Create Gift Card',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Container(
              constraints: const BoxConstraints(maxWidth: 500),
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.accent),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextField(
                      label: 'Amount (DA)',
                      controller: _amountCtrl,
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
                      label: 'Custom Code (optional)',
                      controller: _codeCtrl,
                      hint: 'e.g. PROMO-EID25',
                      prefixIcon: const Icon(Icons.qr_code_outlined, size: 20),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Leave empty to auto-generate a code (GIFT-XXXXXXXX)',
                      style: TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
                    ),
                    const SizedBox(height: 28),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AppButton(
                          label: 'Cancel',
                          onPressed: () => context.pop(),
                          isOutlined: true,
                        ),
                        const SizedBox(width: 12),
                        BlocBuilder<GiftCardCubit, GiftCardState>(
                          builder: (context, state) => AppButton(
                            label: 'Create',
                            onPressed: _submit,
                            isLoading: state is GiftCardCreating,
                            icon: Icons.add,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
