import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/hive_constants.dart';
import '../../../../core/shared_instances.dart/hive_box_shared_instance.dart';

final themeModeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((
  ref,
) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.system) {
    _loadThemeMode();
  }

  AppThemeMode _appThemeMode = AppThemeMode.system;
  final boxName = HiveConstants.themeBox;
  final HiveBoxSharedInstance _hiveManager = HiveBoxSharedInstance();

  ThemeMode get themeMode {
    switch (_appThemeMode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  Future<void> _loadThemeMode() async {
    final themeIndex = await _hiveManager.getData(
      boxName: boxName,
      key: 'app_theme_mode',
    );
    _appThemeMode = AppThemeMode.values[themeIndex ?? 0];
    state = themeMode;
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _appThemeMode = AppThemeMode.values[mode.index];
    await _hiveManager.putData(
      boxName: boxName,
      key: 'app_theme_mode',
      value: _appThemeMode.index,
    );
    state = themeMode;
  }
}
