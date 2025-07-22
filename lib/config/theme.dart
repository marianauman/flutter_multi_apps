import 'package:flutter/material.dart';
import '../core/constants/color_constants.dart';
import '../main/main_common.dart';

class AppColors extends ChangeNotifier {
  Color _primary = appconfig.primaryColor;
  Color get primary => _primary;
  void setPrimary(Color color) {
    _primary = color;
    notifyListeners();
  }
}

class AppTheme {
  static ThemeData getLightTheme() {
    return ThemeData(
      primaryColor: AppColors().primary,
      brightness: Brightness.light,
      splashFactory: NoSplash.splashFactory,
      scaffoldBackgroundColor: ColorConstants.scaffoldBackgroundColorLight,
      appBarTheme: AppBarTheme(
        backgroundColor: ColorConstants.scaffoldBackgroundColorLight,
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors().primary,
        primary: AppColors().primary,
        onPrimary: Colors.white,
        secondary: AppColors().primary,
        onSecondary: Colors.white,
        brightness: Brightness.light,
        surface: ColorConstants.lightSurface,
        onSurface: ColorConstants.lightOnSurface,
        surfaceContainer: ColorConstants.lightSurfaceContainer,
      ),
    );
  }

  static ThemeData getDarkTheme() {
    return ThemeData(
      primaryColor: AppColors().primary,
      brightness: Brightness.dark,
      splashFactory: NoSplash.splashFactory,
      scaffoldBackgroundColor: ColorConstants.scaffoldBackgroundColorDark,
      appBarTheme: AppBarTheme(
        backgroundColor: ColorConstants.scaffoldBackgroundColorDark,
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors().primary,
        primary: AppColors().primary,
        onPrimary: Colors.white,
        secondary: AppColors().primary,
        onSecondary: Colors.white,
        brightness: Brightness.dark,
        surface: ColorConstants.darkSurface,
        onSurface: ColorConstants.darkOnSurface,
        surfaceContainer: ColorConstants.darkSurfaceContainer,
      ),
    );
  }
}
