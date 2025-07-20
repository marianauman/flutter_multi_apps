// App Route definitions

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/splash/splash_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: navigatorKey,
  routes: <RouteBase>[
    GoRoute(
      path: Routes.splash,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),
    // GoRoute(
    //   path: appconfig.homeScreenPath,
    //   builder: (BuildContext context, GoRouterState state) {
    //     switch (appconfig.flavor) {
    //       case AppFlavor.orderTaking:
    //         return isTablet(context)
    //             ? const OrderTakingHomeScreenTab()
    //             : const OrderTakingHomeScreen();
    //       case AppFlavor.leadCapture:
    //         return isTablet(context)
    //             ? const TabLeadCaptureHomeScreen()
    //             : const LeadCaptureHomeScreen();
    //       default:
    //         return isTablet(context)
    //             ? const HomeScreenTab()
    //             : const HomeScreen();
    //     }
    //   },
    // ),
    GoRoute(
      path: Routes.dummyRoute,
      builder: (BuildContext context, GoRouterState state) {
        return Container(color: Theme.of(context).colorScheme.surface);
      },
    ),
  ],
);

class Routes {
  static const String splash = '/';
  // static const String login = '/login';
  static const String dummyRoute = '/dummyRoute';
}

class NavigationService {
  static Future<dynamic> push(String route, {Object? extra}) async {
    return await context.push(route, extra: extra);
  }

  static void pop([dynamic result]) {
    context.pop(result);
  }

  static void go(String route, {Object? extra}) {
    context.go(route, extra: extra);
  }

  static void pushReplacement(String route, {Object? extra}) {
    context.pushReplacement(route, extra: extra);
  }

  static void pushAndRemoveUntil(String route, {Object? extra}) {
    context.go(Routes.dummyRoute);
    Future.delayed(const Duration(milliseconds: 10), () {
      if (context.mounted) {
        context.pushReplacement(route, extra: extra);
      }
    });
  }

  static BuildContext get context => navigatorKey.currentContext!;
}
