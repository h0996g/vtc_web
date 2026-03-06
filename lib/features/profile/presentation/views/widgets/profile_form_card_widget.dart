import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/device_type.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../auth/domain/entities/admin_entity.dart';

class ProfileFormCardWidget extends StatelessWidget {
  const ProfileFormCardWidget({
    super.key,
    required this.admin,
    required this.formKey,
    required this.firstNameCtrl,
    required this.lastNameCtrl,
    required this.phoneCtrl,
    required this.addressCtrl,
    required this.wilayaCtrl,
    required this.communeCtrl,
    required this.editing,
    required this.isUpdating,
    required this.onEditTap,
    required this.onCancel,
    required this.onSave,
  });

  final AdminEntity admin;
  final GlobalKey<FormState> formKey;
  final TextEditingController firstNameCtrl;
  final TextEditingController lastNameCtrl;
  final TextEditingController phoneCtrl;
  final TextEditingController addressCtrl;
  final TextEditingController wilayaCtrl;
  final TextEditingController communeCtrl;
  final bool editing;
  final bool isUpdating;
  final VoidCallback onEditTap;
  final VoidCallback onCancel;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    final isMobile = DeviceTypeQuery.isMobile(context);

    return Container(
      constraints: const BoxConstraints(maxWidth: 660),
      padding: EdgeInsets.all(isMobile ? 20 : 32),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Personal Information',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                if (!editing)
                  TextButton.icon(
                    onPressed: onEditTap,
                    icon: const Icon(
                      Icons.edit_outlined,
                      size: 16,
                      color: AppColors.secondary,
                    ),
                    label: const Text(
                      'Edit',
                      style: TextStyle(color: AppColors.secondary),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            if (isMobile) ...[
              AppTextField(
                label: 'First Name',
                controller: firstNameCtrl,
                readOnly: !editing,
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: 'Last Name',
                controller: lastNameCtrl,
                readOnly: !editing,
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
            ] else
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      label: 'First Name',
                      controller: firstNameCtrl,
                      readOnly: !editing,
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Required' : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AppTextField(
                      label: 'Last Name',
                      controller: lastNameCtrl,
                      readOnly: !editing,
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Required' : null,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'Phone Number',
              controller: phoneCtrl,
              readOnly: !editing,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            if (isMobile) ...[
              AppTextField(
                label: 'Wilaya',
                controller: wilayaCtrl,
                readOnly: !editing,
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: 'Commune',
                controller: communeCtrl,
                readOnly: !editing,
              ),
            ] else
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      label: 'Wilaya',
                      controller: wilayaCtrl,
                      readOnly: !editing,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AppTextField(
                      label: 'Commune',
                      controller: communeCtrl,
                      readOnly: !editing,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'Address',
              controller: addressCtrl,
              readOnly: !editing,
            ),
            if (editing) ...[
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppButton(
                    label: 'Cancel',
                    isOutlined: true,
                    onPressed: onCancel,
                  ),
                  const SizedBox(width: 12),
                  AppButton(
                    label: 'Save Changes',
                    onPressed: onSave,
                    isLoading: isUpdating,
                    icon: Icons.check_outlined,
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
