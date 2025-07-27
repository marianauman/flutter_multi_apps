import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewConfig {
  final bool isZoomEnabled;

  WebViewConfig({
    this.isZoomEnabled = true,
  });

  static bool get defaultJavaScriptEnabled => true;
  
  InAppWebViewSettings get defaultSettings => InAppWebViewSettings(
    javaScriptEnabled: defaultJavaScriptEnabled,
    useShouldOverrideUrlLoading: true,
    mediaPlaybackRequiresUserGesture: false,
    allowsInlineMediaPlayback: true,
    iframeAllowFullscreen: true,
    useOnLoadResource: true,
    useOnDownloadStart: true,
    useShouldInterceptAjaxRequest: true,
    useShouldInterceptFetchRequest: true,
    cacheEnabled: false,
    javaScriptCanOpenWindowsAutomatically: true,
    supportZoom: isZoomEnabled,
  );

  // Cookie Management
  static const bool enableCookies = true;
  static const bool enableThirdPartyCookies = true;

  // Cache Configuration
  static const bool enableCache = false;
  static const Duration cacheExpiration = Duration(days: 7);

  // User Agent Configuration
  //static String get defaultUserAgent => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.114 Safari/537.36';

  // Security Settings
  static const bool allowFileAccess = false;
  static const bool allowContentAccess = false;
  static const bool allowFileAccessFromFileURLs = false;
  static const bool allowUniversalAccessFromFileURLs = false;

  // Media Settings
  static const bool allowInlineMediaPlayback = true;

  // Zoom Settings
  static const double minZoom = 1.0;
  static const double maxZoom = 3.0;
} 