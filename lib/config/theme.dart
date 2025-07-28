import 'package:flutter/material.dart';
import 'package:flutter_multi_apps/core/utils/app_extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        backgroundColor: AppColors().primary,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors().primary,
        foregroundColor: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          color: ColorConstants.secondary300,
          fontWeight: FontWeight.w400,
          fontSize: 14.sp,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorConstants.secondary50),
          borderRadius: BorderRadius.circular(10.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors().primary.customOpacity(0.6)),
          borderRadius: BorderRadius.circular(10.r),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorConstants.secondary50),
          borderRadius: BorderRadius.circular(10.r),
        ),
        labelStyle: const TextStyle(
          color: ColorConstants.secondary300,
          fontSize: 16,
        ),
        iconColor: ColorConstants.secondary300,
        suffixIconColor: ColorConstants.secondary300,
        prefixIconColor: ColorConstants.secondary300,
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
        backgroundColor: AppColors().primary,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors().primary,
        foregroundColor: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          color: ColorConstants.secondary50,
          fontWeight: FontWeight.w400,
          fontSize: 14.sp,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorConstants.secondary400),
          borderRadius: BorderRadius.circular(10.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors().primary.customOpacity(0.6)),
          borderRadius: BorderRadius.circular(10.r),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorConstants.secondary400),
          borderRadius: BorderRadius.circular(10.r),
        ),
        labelStyle: const TextStyle(
          color: ColorConstants.secondary100,
          fontSize: 16,
        ),
        iconColor: ColorConstants.secondary100,
        suffixIconColor: ColorConstants.secondary100,
        prefixIconColor: ColorConstants.secondary100,
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
