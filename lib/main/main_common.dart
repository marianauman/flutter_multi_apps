import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_multi_apps/config/app_config.dart';
import 'package:flutter_multi_apps/core/providers/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/routes.dart';
import '../config/theme.dart';
import '../core/utils/app_utils.dart';

late AppConfiguration appconfig;

void mainCommon({required AppFlavor flavor}) {
  appconfig = AppConfiguration.getInstance(flavor);
  runApp(ProviderScope(child: const AppMainCommon()));
}

class AppMainCommon extends ConsumerStatefulWidget {
  const AppMainCommon({super.key});

  @override
  ConsumerState<AppMainCommon> createState() => _AppMainCommonState();
}

class _AppMainCommonState extends ConsumerState<AppMainCommon> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _setOrientations();
    });
  }

  Future<void> _setOrientations() async {
    await setDeviceOrientations(context);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: getScreenSize(context),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: appconfig.appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.getLightTheme(),
          darkTheme: AppTheme.getDarkTheme(),
          themeMode: ref.watch(themeModeProvider),
          routerConfig: router,
        );
      }
    );
  }
}
