import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WebViewState extends ChangeNotifier {
  bool _isLoading = true;
  bool _canGoBack = false;
  bool _canGoForward = false;
  double _progress = 0.0;

  bool get isLoading => _isLoading;
  bool get canGoBack => _canGoBack;
  bool get canGoForward => _canGoForward;
  double get progress => _progress;

  void setProgress(double value) {
    _progress = value;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    if (loading) {
      _progress = 0.0;
    }
    notifyListeners();
  }

  void updateNavigationState({required bool canBack, required bool canForward}) {
    _canGoBack = canBack;
    _canGoForward = canForward;
    notifyListeners();
  }
}

final webViewStateProvider = ChangeNotifierProvider<WebViewState>((ref) => WebViewState()); 