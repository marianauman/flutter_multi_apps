import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieAsset extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final bool isNetwork;
  final BoxFit? fit;
  final bool repeat;
  final Color? loaderColor;

  const LottieAsset({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.isNetwork = false,
    this.fit,
    this.repeat = true,
    this.loaderColor,
  });
  @override
  Widget build(BuildContext context) {
    if (isNetwork) {
      return Lottie.network(
        path,
        width: width,
        height: height,
        fit: fit,
        repeat: repeat,
        frameBuilder: (context, child, composition) {
          return composition != null
              ? child
              : CupertinoActivityIndicator(color: loaderColor);
        },
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
      );
    } else {
      return Lottie.asset(
        path,
        width: width,
        height: height,
        fit: fit,
        repeat: repeat,
        frameBuilder: (context, child, composition) {
          return composition != null
              ? child
              : CupertinoActivityIndicator(color: loaderColor);
        },
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
      );
    }
  }
}
