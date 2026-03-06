import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/storage/secure_storage_service.dart';
import '../../../../core/utils/responsive_widget.dart';
import '../../../../features/gift_card/presentation/cubit/gift_card_cubit.dart';
import '../../../../features/wallet/presentation/cubit/wallet_cubit.dart';
import 'desktop/dashboard_shell_desktop.dart';
import 'mobile/dashboard_shell_mobile.dart';

class DashboardShell extends StatefulWidget {
  const DashboardShell({super.key, required this.child});

  final Widget child;

  @override
  State<DashboardShell> createState() => _DashboardShellState();
}

class _DashboardShellState extends State<DashboardShell> {
  String _adminName = 'Admin';

  @override
  void initState() {
    super.initState();
    _loadAdminName();
  }

  Future<void> _loadAdminName() async {
    final name = await SecureStorageService.getAdminName();
    if (mounted && name != null) setState(() => _adminName = name);
  }

  String _getPageTitle(String location) {
    if (location.startsWith('/dashboard/gift-cards')) return 'Gift Cards';
    if (location == RouteNames.wallet) return 'Wallet Management';
    if (location == RouteNames.createAdmin) return 'Create Admin';
    if (location == RouteNames.createDriver) return 'Register Driver';
    if (location == RouteNames.profile) return 'My Profile';
    return 'Dashboard';
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final title = _getPageTitle(location);

    return MultiBlocProvider(
      providers: [
        BlocProvider<GiftCardCubit>(create: (_) => sl<GiftCardCubit>()),
        BlocProvider<WalletCubit>(create: (_) => sl<WalletCubit>()),
      ],
      child: ResponsiveWidget(
        mobile: DashboardShellMobile(
          adminName: _adminName,
          pageTitle: title,
          currentLocation: location,
          child: widget.child,
        ),
        desktop: DashboardShellDesktop(
          adminName: _adminName,
          pageTitle: title,
          currentLocation: location,
          child: widget.child,
        ),
      ),
    );
  }
}
