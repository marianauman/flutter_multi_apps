import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivitySharedInstance {
  
  static final ConnectivitySharedInstance _instance = ConnectivitySharedInstance._internal();
  factory ConnectivitySharedInstance() => _instance;
  ConnectivitySharedInstance._internal();

  final Connectivity _connectivity = Connectivity();

  // Check current connectivity status
  Future<bool> isConnected() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    return _hasConnection(connectivityResult);
  }

  bool _hasConnection(List<ConnectivityResult> result) {
    return result.contains(ConnectivityResult.mobile) ||
           result.contains(ConnectivityResult.wifi) ||
           result.contains(ConnectivityResult.ethernet) ||
           result.contains(ConnectivityResult.vpn);
  }
}