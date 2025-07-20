import 'package:flutter/material.dart';
import 'package:flutter_multi_apps/config/app_config.dart';

import '../config/routes.dart';

late AppConfiguration appconfig;

void mainCommon({required AppFlavor flavor}) {
  appconfig = AppConfiguration.getInstance(flavor);
  runApp(const AppMainCommon());
}

class AppMainCommon extends StatelessWidget {
  const AppMainCommon({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: appconfig.appName,
      debugShowCheckedModeBanner: false,
      // theme: AppTheme.getLightTheme(),
      // darkTheme: AppTheme.getDarkTheme(),
      // themeMode: ref.watch(isDarkModeProvider) ? ThemeMode.dark : ThemeMode.light,
      routerConfig: router,
    );
  }
}
