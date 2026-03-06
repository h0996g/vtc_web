import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/router/route_names.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../auth/presentation/cubit/auth_cubit.dart';

class DrawerNavMobile extends StatelessWidget {
  const DrawerNavMobile({
    super.key,
    required this.currentLocation,
    required this.adminName,
  });

  final String currentLocation;
  final String adminName;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primary,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.directions_car,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'VTC Admin',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),

            // Admin badge
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircleAvatar(
                      radius: 12,
                      backgroundColor: AppColors.secondary,
                      child: Icon(Icons.person, size: 14, color: AppColors.primary),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      adminName,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            const Divider(color: Color(0xFF2D3154), height: 1),
            const SizedBox(height: 8),

            // Nav items
            _DrawerNavItem(
              icon: Icons.card_giftcard_outlined,
              label: 'Gift Cards',
              route: RouteNames.giftCards,
              isActive: currentLocation.startsWith('/dashboard/gift-cards'),
            ),
            _DrawerNavItem(
              icon: Icons.account_balance_wallet_outlined,
              label: 'Wallet',
              route: RouteNames.wallet,
              isActive: currentLocation == RouteNames.wallet,
            ),
            _DrawerNavItem(
              icon: Icons.person_add_outlined,
              label: 'Create Admin',
              route: RouteNames.createAdmin,
              isActive: currentLocation == RouteNames.createAdmin,
            ),
            _DrawerNavItem(
              icon: Icons.drive_eta_outlined,
              label: 'Register Driver',
              route: RouteNames.createDriver,
              isActive: currentLocation == RouteNames.createDriver,
            ),

            const Spacer(),

            const Divider(color: Color(0xFF2D3154), height: 1),
            _DrawerNavItem(
              icon: Icons.person_outline,
              label: 'My Profile',
              route: RouteNames.profile,
              isActive: currentLocation == RouteNames.profile,
            ),

            // Logout
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              child: ListTile(
                leading: const Icon(Icons.logout_outlined, color: Color(0xFF6B7280), size: 20),
                title: const Text(
                  'Logout',
                  style: TextStyle(color: Color(0xFF6B7280), fontSize: 14),
                ),
                onTap: () {
                  context.read<AuthCubit>().logout();
                  context.go(RouteNames.login);
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),

            const SizedBox(height: 8),
            const Divider(color: Color(0xFF2D3154), height: 1),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'VTC Dashboard v1.0',
                style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _DrawerNavItem extends StatelessWidget {
  const _DrawerNavItem({
    required this.icon,
    required this.label,
    required this.route,
    required this.isActive,
  });

  final IconData icon;
  final String label;
  final String route;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: ListTile(
        leading: Icon(
          icon,
          size: 20,
          color: isActive ? AppColors.secondary : AppColors.textSecondary,
        ),
        title: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            color: isActive ? Colors.white : AppColors.textSecondary,
          ),
        ),
        tileColor: isActive ? AppColors.secondary.withValues(alpha: 0.12) : Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onTap: () {
          Navigator.of(context).pop(); // close drawer
          context.go(route);
        },
      ),
    );
  }
}
