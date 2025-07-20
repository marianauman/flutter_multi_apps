import '../../config/routes.dart';

class SplashHandler {
  static const _splashDelay = Duration(seconds: 3);

  static Future<void> handleSplash() async {
    _navigateToHomeScreen();
  }

  static Future<void> _navigateToHomeScreen() async {
    await Future.delayed(_splashDelay);
    NavigationService.pushReplacement(Routes.homeScreen);
  }
}
