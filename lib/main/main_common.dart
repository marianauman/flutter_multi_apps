import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../config/app_config.dart';
import '../config/routes.dart';
import '../config/theme.dart';
import '../core/providers/theme_provider.dart';
import '../core/shared_instances.dart/hive_box_shared_instance.dart';
import '../core/utils/app_utils.dart';

late AppConfiguration appconfig;

void mainCommon({required AppFlavor flavor}) async {
  appconfig = AppConfiguration.getInstance(flavor);
  await initializeHive();
  runApp(ProviderScope(child: const AppMainCommon()));
}

Future<void> initializeHive() async {
  HiveBoxSharedInstance boxManager = HiveBoxSharedInstance();
  await boxManager.initializeBoxes();
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
