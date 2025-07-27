import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/base_screen.dart';
import '../../widgets/custom_icon_button.dart';
import 'managers/web_view_controller_manager.dart';
import 'managers/javascript_channel_manager.dart';
import 'config/web_view_config.dart';
import 'providers/web_view_state.dart';

class AppWebViewWidget extends ConsumerStatefulWidget {
  final String appBarTitle;
  final String webUrl;
  final bool isZoomEnabled;

  const AppWebViewWidget({
    super.key,
    required this.appBarTitle,
    required this.webUrl,
    this.isZoomEnabled = true,
  });

  @override
  ConsumerState<AppWebViewWidget> createState() => _AppWebViewWidgetState();
}

class _AppWebViewWidgetState extends ConsumerState<AppWebViewWidget> {
  late final InAppWebViewController _controller;
  late final WebViewControllerManager _controllerManager;
  late final JavaScriptChannelManager _jsChannelManager;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    if (!mounted) return;

    _validateUrl();
    _setupManagers();
  }

  void _validateUrl() {
    try {
      final uri = WebUri(widget.webUrl);
      print("URL parsed successfully: ${uri.toString()}");
    } catch (e) {
      print('Invalid URL format: $e');
    }
  }

  void _setupManagers() {
    _controllerManager = WebViewControllerManager(
      url: widget.webUrl,
      onLoadingChanged: _handleLoadingChange,
      onNavigationStateChanged: _handleNavigationStateChange,
      isZoomEnabled: widget.isZoomEnabled,
    );

    _jsChannelManager = JavaScriptChannelManager(context: context);
  }

  void _handleLoadingChange(bool loading) {
    if (mounted) {
      ref.read(webViewStateProvider.notifier).setLoading(loading);
    }
  }

  void _handleNavigationStateChange(bool canBack, bool canForward) {
    if (mounted) {
      ref.read(webViewStateProvider.notifier).updateNavigationState(
        canBack: canBack,
        canForward: canForward,
      );
    }
  }

  @override
  void dispose() {
    try {
      _controllerManager.clearCache(_controller);
    } catch (e) {
      print('Error clearing cache: $e');
    }
    super.dispose();
  }

  List<Widget> _buildNavigationButtons(WebViewState state) {
    return [
      if (state.canGoBack)
        _buildNavigationButton(
          icon: Icons.arrow_back,
          size: 25.r,
          onPressed: () => _controllerManager.goBack(_controller),
        ),
      if (state.canGoForward)
        _buildNavigationButton(
          icon: Icons.arrow_forward,
          size: 25.r,
          onPressed: () => _controllerManager.goForward(_controller),
        ),
    ];
  }

  Widget _buildNavigationButton({
    required IconData icon,
    required VoidCallback onPressed,
    required double size,
    double ? padding,
  }) {
    return CustomIconButton(
      icon: icon,
      size: size,
      paddingAll: padding,
      onPressed: onPressed,
    );
  }

  Future<void> _updateNavigationState(InAppWebViewController controller) async {
    try {
      final canGoBack = await controller.canGoBack();
      final canGoForward = await controller.canGoForward();
      ref.read(webViewStateProvider.notifier).updateNavigationState(
        canBack: canGoBack,
        canForward: canGoForward,
      );
    } catch (e) {
      print('Error checking navigation state: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final webViewState = ref.watch(webViewStateProvider);
    
    return BaseScreen(
      title: widget.appBarTitle,
      centerTitle: false,
      actions: _buildNavigationButtons(webViewState),
      child: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(widget.webUrl)),
            initialSettings: WebViewConfig(isZoomEnabled: widget.isZoomEnabled).defaultSettings,
            onWebViewCreated: (controller) {
              _controller = controller;
              _jsChannelManager.registerChannels(controller);
            },
            onLoadStart: (_, __) => ref.read(webViewStateProvider.notifier).setLoading(true),
            onLoadStop: (controller, __) async {
              ref.read(webViewStateProvider.notifier).setLoading(false);
              await _updateNavigationState(controller);
              await _jsChannelManager.evaluateJavascript(controller);
            },
            onReceivedError: (_, __, error) {
              print('WebView load error: ${error.description} (code: ${error.type})');
              ref.read(webViewStateProvider.notifier).setLoading(false);
            },
            onReceivedHttpError: (_, __, response) {
              print('WebView HTTP error:(status: ${response.statusCode})');
              ref.read(webViewStateProvider.notifier).setLoading(false);
            },
            onProgressChanged: (_, progress) {
              ref.read(webViewStateProvider.notifier).setProgress(progress / 100.0);
            },
            shouldOverrideUrlLoading: (_, navigationAction) async {
              print("Attempting to load URL: ${navigationAction.request.url}");
              return NavigationActionPolicy.ALLOW;
            },
          ),
          if (webViewState.isLoading || webViewState.progress < 1.0)
            Align(
              alignment: Alignment.topCenter,
              child: LinearProgressIndicator(
                value: webViewState.progress,
                color: Theme.of(context).colorScheme.primary,
                backgroundColor: Colors.transparent,
                minHeight: 10,
              ),
            ),
        ],
      ),
    );
  }
}
