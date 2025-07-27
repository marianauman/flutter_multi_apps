import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class JavaScriptChannelManager {
  final BuildContext context;

  JavaScriptChannelManager({
    required this.context,
  });

  void registerChannels(InAppWebViewController controller) {
    
  }

  Future<void> evaluateJavascript(InAppWebViewController controller) async {
    await controller.evaluateJavascript(source: """
    ${_defaultZoomScript()}
    
   """);
  }

  String _defaultZoomScript() {
    return """
    (function() {
      var meta = document.querySelector('meta[name=viewport]');
      if (!meta) {
        meta = document.createElement('meta');
        meta.name = 'viewport';
        meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';
        document.head.appendChild(meta);
      } else {
        meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';
      }
      document.body.style.zoom = 1.0;
    })();
    """;
  }
  

}
