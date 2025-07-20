// App Base Configuration to load the flavor specifics

enum AppFlavor {
  bookTracker,
  expenseTracker,
}

class AppConfiguration {
  final AppFlavor flavor;
  final String appName;
  final String flavorAssetsFolder;
  final String homeScreenPath;

  const AppConfiguration._({
    required this.flavor,
    required this.appName,
    required this.flavorAssetsFolder,
    required this.homeScreenPath,
  });

  factory AppConfiguration.ofBookTracker() => const AppConfiguration._(
    flavor: AppFlavor.bookTracker,
    appName: 'Book Tracker',
    flavorAssetsFolder: 'book_tracker',
    homeScreenPath: '/bookTrackerHome',
  );

  factory AppConfiguration.ofExpenseTracker() => const AppConfiguration._(
    flavor: AppFlavor.expenseTracker,
    appName: 'Expense Tracker',
    flavorAssetsFolder: 'expense_tracker',
    homeScreenPath: '/expenseTrackerHome',
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
