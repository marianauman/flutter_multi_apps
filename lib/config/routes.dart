// App Route definitions

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../config/app_config.dart';
import '../features/book_tracker/book_listing/view/book_filters_screen.dart';
import '../features/book_tracker/dashboard/view/book_tracker_dashboard_screen.dart';
import '../features/book_tracker/settings_tab/view/faq_screen.dart';
import '../features/expense_tracker/expense_tracker_home_screen.dart';
import '../features/splash/splash_screen.dart';
import '../main/main_common.dart';
import '../shared/helpers/json_parser.dart';
import '../shared/helpers/web_view/app_web_view_widget.dart';

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
    GoRoute(
      path: Routes.dashboard,
      builder: (BuildContext context, GoRouterState state) {
        switch (appconfig.flavor) {
          case AppFlavor.expenseTracker:
            return const ExpenseTrackerHomeScreen();
          case AppFlavor.bookTracker:
            return const BookTrackerDashboardScreen();
        }
      },
    ),
    GoRoute(
      path: Routes.appWebView,
      builder: (BuildContext context, GoRouterState state) {
        final extra = state.extra as Map<String, dynamic>;
        final appBarTitle = JsonParser.parseString(extra['app_bar_title']);
        final webUrl = JsonParser.parseString(extra['web_url']);
        final isZoomEnabled = JsonParser.parseBool(extra['is_zoom_enabled']);
        return AppWebViewWidget(
          appBarTitle: appBarTitle,
          webUrl: webUrl,
          isZoomEnabled: isZoomEnabled,
        );
      },
    ),
    GoRoute(
      path: Routes.faq,
      builder: (BuildContext context, GoRouterState state) {
        return const FAQScreen();
      },
    ),
    GoRoute(
      path: Routes.bookFilters,
      builder: (BuildContext context, GoRouterState state) {
        return const BookFiltersScreen();
      },
    ),
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
  static final String dashboard = appconfig.dashboardPath;
  static const String appWebView = '/appWebView';
  static const String faq = '/faq';
  static const String bookFilters = '/bookFilters';
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
