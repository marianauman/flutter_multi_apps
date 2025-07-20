import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

bool isTablet(BuildContext context) {
  final double tabletThreshold = 600.0;
  final double screenWidth = MediaQuery.of(context).size.shortestSide;
  return screenWidth >= tabletThreshold;
}

Future<void> setDeviceOrientations(BuildContext context)async{
  if(isTablet(context)){
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }else{
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}

Size getScreenSize(BuildContext context) {
  final isTabletDevice = isTablet(context);
  final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
  final designSize = isTabletDevice
      ? isPortrait ? MediaQuery.of(context).size : const Size(1135, 744)
      : const Size(375, 812);
  return designSize;
}

hideKeyboard(BuildContext context) {
  FocusManager.instance.primaryFocus?.unfocus();
}

