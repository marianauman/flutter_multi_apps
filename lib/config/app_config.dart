// App Base Configuration to load the flavor specifics

import 'dart:ui';
import '../core/constants/color_constants.dart';

enum AppFlavor {
  bookTracker,
  expenseTracker,
}

class AppConfiguration {
  final AppFlavor flavor;
  final String appName;
  final String flavorAssetsFolder;
  final String dashboardPath;
  final Color primaryColor;
  final String apiBaseUrl;

  const AppConfiguration._({
    required this.flavor,
    required this.appName,
    required this.flavorAssetsFolder,
    required this.dashboardPath,
    required this.primaryColor,
    required this.apiBaseUrl,
  });

  factory AppConfiguration.ofBookTracker() => const AppConfiguration._(
    flavor: AppFlavor.bookTracker,
    appName: 'Book Tracker',
    flavorAssetsFolder: 'book_tracker',
    dashboardPath: '/bookTrackerDashboard',
    primaryColor: ColorConstants.primaryBookTracker,
    apiBaseUrl: 'https://openlibrary.org/',
  );

  factory AppConfiguration.ofExpenseTracker() => const AppConfiguration._(
    flavor: AppFlavor.expenseTracker,
    appName: 'Expense Tracker',
    flavorAssetsFolder: 'expense_tracker',
    dashboardPath: '/expenseTrackerDashboard',
    primaryColor: ColorConstants.primaryExpenseTracker,
    apiBaseUrl: '',
  );

  static AppConfiguration getInstance(AppFlavor flavor) {
    switch (flavor) {
      case AppFlavor.bookTracker:
        return AppConfiguration.ofBookTracker();
      case AppFlavor.expenseTracker:
        return AppConfiguration.ofExpenseTracker();
    }
  }

}
