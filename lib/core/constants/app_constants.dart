import 'package:flutter_screenutil/flutter_screenutil.dart';

enum AppThemeMode { system, light, dark }

enum DioApiError {
  none,
  noInternet,
  unauthorized,
  timeout,
  badResponse,
  unknown,
}

enum BookStatus { none, wantToRead, reading, finished }

enum BookAccessType { none, public, borrowable, printdisabled }

enum DialogPosition { top, center, bottom }

enum DialogAnimationType { slide, fade, scale, rotate }

enum SlideDirection { left, right, top, bottom }

enum DialogType { success, error, info, confirmation, custom }

class AppConstants {
  static const privacyPolicyUrl = '';
  static double dialogMaxWidth = 0.95.sw;
  static double dialogMaxHeight = 0.8.sh;
}
