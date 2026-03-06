import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import 'widgets/drawer_nav_mobile_widget.dart';

class DashboardShellMobile extends StatelessWidget {
  const DashboardShellMobile({
    super.key,
    required this.child,
    required this.adminName,
    required this.pageTitle,
    required this.currentLocation,
  });

  final Widget child;
  final String adminName;
  final String pageTitle;
  final String currentLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.cardBackground,
        foregroundColor: Colors.white,
        elevation: 0,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, color: AppColors.accent),
        ),
        title: Text(
          pageTitle,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      drawer: DrawerNavMobile(
        currentLocation: currentLocation,
        adminName: adminName,
      ),
      body: child,
    );
  }
}
