import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

bool isTablet(BuildContext context) {
  final double tabletThreshold = 600.0;
  final double screenWidth = MediaQuery.of(context).size.shortestSide;
  return screenWidth >= tabletThreshold;
}

bool isPortrait(BuildContext context) {
  return MediaQuery.of(context).orientation == Orientation.portrait;
}

Future<void> setDeviceOrientations(BuildContext context) async {
  if (isTablet(context)) {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  } else {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}

Size getScreenSize(BuildContext context) {
  final isTabletDevice = isTablet(context);
  final isPortraitDevice = isPortrait(context);
  final designSize = isTabletDevice
      ? isPortraitDevice
            ? MediaQuery.of(context).size
            : const Size(1135, 744)
      : const Size(375, 812);
  return designSize;
}

hideKeyboard(BuildContext context) {
  FocusManager.instance.primaryFocus?.unfocus();
}

bool isDarkMode(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark;
}

Future<bool> isConnected() async {
  final connectivityResult = await Connectivity().checkConnectivity();
  return _hasConnection(connectivityResult);
}

bool _hasConnection(List<ConnectivityResult> result) {
  return result.contains(ConnectivityResult.mobile) ||
      result.contains(ConnectivityResult.wifi) ||
      result.contains(ConnectivityResult.ethernet) ||
      result.contains(ConnectivityResult.vpn);
}
