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
      useMaterial3: true,
      primaryColor: AppColors().primary,
      brightness: Brightness.light,
      scaffoldBackgroundColor: ColorConstants.scaffoldBackgroundColorLight,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors().primary,
        brightness: Brightness.light,
      ),
    );
  }

  static ThemeData getDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      primaryColor: AppColors().primary,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: ColorConstants.scaffoldBackgroundColorDark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors().primary,
        brightness: Brightness.dark,
      ),
    );
  }
}
