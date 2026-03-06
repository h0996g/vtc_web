import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/views/login_page.dart';
import '../../features/auth/presentation/views/register_admin_page.dart';
import '../../features/auth/presentation/views/register_driver_page.dart';
import '../../features/auth/presentation/cubit/driver_cubit.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../di/injection_container.dart';
import '../../features/dashboard/presentation/views/dashboard_shell.dart';
import '../../features/gift_card/presentation/views/create_gift_card_page.dart';
import '../../features/gift_card/presentation/views/gift_card_list_page.dart';
import '../../features/profile/presentation/cubit/profile_cubit.dart';
import '../../features/profile/presentation/views/profile_page.dart';
import '../../features/wallet/presentation/views/wallet_management_page.dart';
import '../storage/secure_storage_service.dart';
import 'route_names.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RouteNames.login,
    redirect: (context, state) async {
      final isLoggedIn = await SecureStorageService.isLoggedIn();
      final isLoginPage = state.matchedLocation == RouteNames.login;
      if (!isLoggedIn && !isLoginPage) return RouteNames.login;
      if (isLoggedIn && isLoginPage) return RouteNames.giftCards;
      return null;
    },
    routes: [
      GoRoute(
        path: RouteNames.login,
        builder: (context, state) => const LoginPage(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => DashboardShell(child: child),
        routes: [
          GoRoute(
            path: RouteNames.giftCards,
            builder: (context, state) => const GiftCardListPage(),
          ),
          GoRoute(
            path: RouteNames.createGiftCard,
            builder: (context, state) => const CreateGiftCardPage(),
          ),
          GoRoute(
            path: RouteNames.wallet,
            builder: (context, state) => const WalletManagementPage(),
          ),
          GoRoute(
            path: RouteNames.createAdmin,
            builder: (context, state) => const RegisterAdminPage(),
          ),
          GoRoute(
            path: RouteNames.createDriver,
            builder: (context, state) => BlocProvider(
              create: (_) => DriverCubit(sl<AuthRemoteDataSource>()),
              child: const RegisterDriverPage(),
            ),
          ),
          GoRoute(
            path: RouteNames.profile,
            builder: (context, state) => BlocProvider(
              create: (_) => sl<ProfileCubit>(),
              child: const ProfilePage(),
            ),
          ),
        ],
      ),
    ],
  );
}
