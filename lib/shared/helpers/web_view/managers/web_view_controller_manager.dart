import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewControllerManager {
  final String url;
  final Function(bool) onLoadingChanged;
  final Function(bool, bool) onNavigationStateChanged;
  final bool isZoomEnabled;

  WebViewControllerManager({
    required this.url,
    required this.onLoadingChanged,
    required this.onNavigationStateChanged,
    this.isZoomEnabled = true,
  });

  Future<void> goBack(InAppWebViewController controller) async {
    try {
      print('Attempting to go back');
      onLoadingChanged(true);

      if (await controller.canGoBack()) {
        print('Can go back, navigating...');
        await controller.goBack();

        Future.delayed(const Duration(milliseconds: 500), () async {
          final canGoBack = await controller.canGoBack();
          final canGoForward = await controller.canGoForward();
          print(
              'Navigation state after back: canGoBack=$canGoBack, canGoForward=$canGoForward');
          onNavigationStateChanged(canGoBack, canGoForward);
        });
      } else {
        print('Cannot go back');
        onLoadingChanged(false);
      }
    } catch (e) {
      print('Error going back: $e');
      onLoadingChanged(false);
    }
  }

  Future<void> goForward(InAppWebViewController controller) async {
    try {
      if (await controller.canGoForward()) {
        await controller.goForward();
      }
    } catch (e) {
      print('Error going forward: $e');
    }
  }

  Future<void> reload(InAppWebViewController controller) async {
    try {
      await controller.reload();
    } catch (e) {
      print('Error reloading: $e');
    }
  }

  Future<void> clearCache(InAppWebViewController controller) async {
    InAppWebViewController.clearAllCache();
    CookieManager.instance().deleteAllCookies();
  }

}
