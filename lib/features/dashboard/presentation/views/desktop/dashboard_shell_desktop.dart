import 'package:flutter/material.dart';
import 'widgets/sidebar_nav_widget.dart';
import 'widgets/top_bar_widget.dart';

class DashboardShellDesktop extends StatelessWidget {
  const DashboardShellDesktop({
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
      body: Row(
        children: [
          SidebarNav(currentLocation: currentLocation),
          Expanded(
            child: Column(
              children: [
                TopBar(adminName: adminName, pageTitle: pageTitle),
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
