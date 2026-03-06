import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../features/auth/presentation/cubit/auth_cubit.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key, required this.adminName, required this.pageTitle});

  final String adminName;
  final String pageTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB))),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Row(
        children: [
          Text(
            pageTitle,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.dark,
            ),
          ),
          const Spacer(),
          // Admin badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 12,
                  backgroundColor: AppColors.primary,
                  child: Icon(Icons.person, size: 14, color: Colors.white),
                ),
                const SizedBox(width: 8),
                Text(
                  adminName,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Logout
          IconButton(
            onPressed: () {
              context.read<AuthCubit>().logout();
              context.go(RouteNames.login);
            },
            icon: const Icon(Icons.logout_outlined, size: 20),
            tooltip: 'Logout',
            style: IconButton.styleFrom(
              foregroundColor: const Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }
}
