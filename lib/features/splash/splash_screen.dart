import 'package:flutter/material.dart';
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
      body: Center(child: Text('${appconfig.appName} SplashScreen')),
    );
  }
}
