import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';

class SidebarNav extends StatelessWidget {
  const SidebarNav({super.key, required this.currentLocation});

  final String currentLocation;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      color: AppColors.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.directions_car, color: AppColors.primary, size: 20),
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

          // Nav items
          _NavItem(
            icon: Icons.card_giftcard_outlined,
            label: 'Gift Cards',
            route: RouteNames.giftCards,
            isActive: currentLocation.startsWith('/dashboard/gift-cards'),
          ),
          _NavItem(
            icon: Icons.account_balance_wallet_outlined,
            label: 'Wallet',
            route: RouteNames.wallet,
            isActive: currentLocation == RouteNames.wallet,
          ),
          _NavItem(
            icon: Icons.person_add_outlined,
            label: 'Create Admin',
            route: RouteNames.createAdmin,
            isActive: currentLocation == RouteNames.createAdmin,
          ),
          _NavItem(
            icon: Icons.drive_eta_outlined,
            label: 'Register Driver',
            route: RouteNames.createDriver,
            isActive: currentLocation == RouteNames.createDriver,
          ),

          const Spacer(),

          const Divider(color: Color(0xFF2D3154), height: 1),
          _NavItem(
            icon: Icons.person_outline,
            label: 'My Profile',
            route: RouteNames.profile,
            isActive: currentLocation == RouteNames.profile,
          ),
          const SizedBox(height: 8),

          // Bottom divider
          const Divider(color: Color(0xFF2D3154), height: 1),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'VTC Dashboard v1.0',
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
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
      child: InkWell(
        onTap: () => context.go(route),
        borderRadius: BorderRadius.circular(8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
          decoration: BoxDecoration(
            color: isActive ? AppColors.secondary.withValues(alpha: 0.12) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: isActive ? AppColors.secondary : AppColors.textSecondary,
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  color: isActive ? Colors.white : AppColors.textSecondary,
                ),
              ),
              if (isActive) ...[
                const Spacer(),
                Container(
                  width: 4,
                  height: 4,
                  decoration: const BoxDecoration(
                    color: AppColors.secondary,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
