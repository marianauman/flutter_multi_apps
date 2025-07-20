import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../core/constants/assets_constants.dart';
import '../../main/main_common.dart';
import 'splash_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _splashHandler();
  }

  void _splashHandler() async {
    await SplashHandler.handleSplash();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appconfig.primaryColor,
      body: Center(
        child: Lottie.asset(
          AssetsConstants.splash,
          width: 300.r,
          height: 300.r,
        ),
      ),
    );
  }
}
