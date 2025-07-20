// App Base Configuration to load the flavor specifics

import 'dart:ui';
import '../core/color_constants.dart';

enum AppFlavor {
  bookTracker,
  expenseTracker,
}

class AppConfiguration {
  final AppFlavor flavor;
  final String appName;
  final String flavorAssetsFolder;
  final String homeScreenPath;
  final Color primaryColor;

  const AppConfiguration._({
    required this.flavor,
    required this.appName,
    required this.flavorAssetsFolder,
    required this.homeScreenPath,
    required this.primaryColor,
  });

  factory AppConfiguration.ofBookTracker() => const AppConfiguration._(
    flavor: AppFlavor.bookTracker,
    appName: 'Book Tracker',
    flavorAssetsFolder: 'book_tracker',
    homeScreenPath: '/bookTrackerHome',
    primaryColor: ColorConstants.primaryBookTracker,
  );

  factory AppConfiguration.ofExpenseTracker() => const AppConfiguration._(
    flavor: AppFlavor.expenseTracker,
    appName: 'Expense Tracker',
    flavorAssetsFolder: 'expense_tracker',
    homeScreenPath: '/expenseTrackerHome',
    primaryColor: ColorConstants.primaryExpenseTracker,
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
