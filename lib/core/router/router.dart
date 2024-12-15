import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:micit/core/router/route_names.dart';

import '../../features/home_feature/presentation/home_screen/home_screen.dart';
import '../../features/login_feature/presentation/login_screen/login_screen.dart';
import '../../features/splash_feature/splash_screen/splash_screen.dart';
import '../../main.dart';
import '../helper/helper.dart';
import 'error_screen.dart';

final GoRouter router = GoRouter(
  navigatorKey: navigatorKey,
  observers: [
    FlutterSmartDialog.observer,
  ],
  errorBuilder: (context, state) => ErrorScreen(
    error: state.error ?? GoException('General error message'),
  ),
  routes: [
    GoRoute(
      path: AppRouteName.splashScreenRoute,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRouteName.loginScreenRoute,
      redirect: (context, state) =>
          Helper.isLoggedIn ? AppRouteName.homeScreenRoute : null,
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: AppRouteName.homeScreenRoute,
      redirect: (context, state) =>
          Helper.isLoggedIn ? null : AppRouteName.loginScreenRoute,
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
