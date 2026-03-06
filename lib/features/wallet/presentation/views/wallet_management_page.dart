import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/wallet_cubit.dart';
import '../cubit/wallet_state.dart';
import 'widgets/wallet_operation_card_widget.dart';

class WalletManagementPage extends StatefulWidget {
  const WalletManagementPage({super.key});

  @override
  State<WalletManagementPage> createState() => _WalletManagementPageState();
}

class _WalletManagementPageState extends State<WalletManagementPage> {
  final _creditFormKey = GlobalKey<FormState>();
  final _debitFormKey = GlobalKey<FormState>();

  final _creditUserCtrl = TextEditingController();
  final _creditAmountCtrl = TextEditingController();
  final _creditRefCtrl = TextEditingController();

  final _debitUserCtrl = TextEditingController();
  final _debitAmountCtrl = TextEditingController();
  final _debitRefCtrl = TextEditingController();

  @override
  void dispose() {
    _creditUserCtrl.dispose();
    _creditAmountCtrl.dispose();
    _creditRefCtrl.dispose();
    _debitUserCtrl.dispose();
    _debitAmountCtrl.dispose();
    _debitRefCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WalletCubit, WalletState>(
      listener: (context, state) {
        if (state is WalletOperationSuccess) {
          _creditFormKey.currentState?.reset();
          _debitFormKey.currentState?.reset();
          _creditUserCtrl.clear();
          _creditAmountCtrl.clear();
          _creditRefCtrl.clear();
          _debitUserCtrl.clear();
          _debitAmountCtrl.clear();
          _debitRefCtrl.clear();
          context.read<WalletCubit>().reset();
        }
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Wallet Management',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Credit or debit user wallets manually',
              style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
            ),
            const SizedBox(height: 32),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: WalletOperationCardWidget(
                    title: 'Credit Wallet',
                    subtitle: 'Add funds to a user account',
                    icon: Icons.add_circle_outline,
                    iconColor: AppColors.success,
                    formKey: _creditFormKey,
                    userCtrl: _creditUserCtrl,
                    amountCtrl: _creditAmountCtrl,
                    refCtrl: _creditRefCtrl,
                    isCredit: true,
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: WalletOperationCardWidget(
                    title: 'Debit Wallet',
                    subtitle: 'Remove funds from a user account',
                    icon: Icons.remove_circle_outline,
                    iconColor: AppColors.error,
                    formKey: _debitFormKey,
                    userCtrl: _debitUserCtrl,
                    amountCtrl: _debitAmountCtrl,
                    refCtrl: _debitRefCtrl,
                    isCredit: false,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
