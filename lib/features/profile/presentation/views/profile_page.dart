import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../auth/domain/entities/admin_entity.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import 'widgets/profile_avatar_card_widget.dart';
import 'widgets/profile_error_card_widget.dart';
import 'widgets/profile_form_card_widget.dart';
import 'widgets/profile_shimmer_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _wilayaCtrl = TextEditingController();
  final _communeCtrl = TextEditingController();

  bool _editing = false;

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().loadProfile();
  }

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    _wilayaCtrl.dispose();
    _communeCtrl.dispose();
    super.dispose();
  }

  void _populate(AdminEntity admin) {
    _firstNameCtrl.text = admin.firstName;
    _lastNameCtrl.text = admin.lastName;
    _phoneCtrl.text = admin.phoneNumber ?? '';
    _addressCtrl.text = admin.address ?? '';
    _wilayaCtrl.text = admin.wilaya ?? '';
    _communeCtrl.text = admin.commune ?? '';
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<ProfileCubit>().updateProfile(
      firstName: _firstNameCtrl.text.trim(),
      lastName: _lastNameCtrl.text.trim(),
      phoneNumber:
          _phoneCtrl.text.trim().isEmpty ? null : _phoneCtrl.text.trim(),
      address:
          _addressCtrl.text.trim().isEmpty ? null : _addressCtrl.text.trim(),
      wilaya:
          _wilayaCtrl.text.trim().isEmpty ? null : _wilayaCtrl.text.trim(),
      commune:
          _communeCtrl.text.trim().isEmpty ? null : _communeCtrl.text.trim(),
    );
    setState(() => _editing = false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoaded && _editing == false) {
          _populate(state.admin);
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'My Profile',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'View and update your account information',
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 32),
              if (state is ProfileLoading)
                const ProfileShimmerWidget()
              else if (state is ProfileError)
                ProfileErrorCardWidget(
                  message: state.message,
                  onRetry: () => context.read<ProfileCubit>().loadProfile(),
                )
              else
                _buildContent(context, state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, ProfileState state) {
    final admin = switch (state) {
      ProfileLoaded s => s.admin,
      ProfileUpdating s => s.admin,
      _ => null,
    };

    if (admin == null) return const SizedBox.shrink();

    final isUpdating = state is ProfileUpdating;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileAvatarCardWidget(admin: admin),
        const SizedBox(height: 24),
        ProfileFormCardWidget(
          admin: admin,
          formKey: _formKey,
          firstNameCtrl: _firstNameCtrl,
          lastNameCtrl: _lastNameCtrl,
          phoneCtrl: _phoneCtrl,
          addressCtrl: _addressCtrl,
          wilayaCtrl: _wilayaCtrl,
          communeCtrl: _communeCtrl,
          editing: _editing,
          isUpdating: isUpdating,
          onEditTap: () => setState(() => _editing = true),
          onCancel: () {
            _populate(admin);
            setState(() => _editing = false);
          },
          onSave: _submit,
        ),
      ],
    );
  }
}
