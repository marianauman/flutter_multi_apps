import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_apps/core/utils/app_extensions.dart';

import '../../core/utils/validators.dart';

class ImageNetwork extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final Color? color;
  final BoxFit? fit;
  final Widget? placeholder;
  final Widget? errorWidget;
  final int? memCacheHeight;
  final int? memCacheWidth;
  final bool fullRes;

  const ImageNetwork({
    super.key,
    required this.imageUrl,
    this.width = 24,
    this.height = 24,
    this.color,
    this.fit = BoxFit.contain,
    this.placeholder,
    this.errorWidget,
    this.memCacheHeight,
    this.memCacheWidth,
    this.fullRes = false,
  });

  @override
  Widget build(BuildContext context) {
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final multiplier = devicePixelRatio.clamp(1, 3);

    final int calculatedHeight = height.isInfinite
        ? 512
        : (height * multiplier).round();
    final int calculatedWidth = width.isInfinite
        ? 512
        : (width * multiplier).round();
    Widget imageWidget =
        imageUrl.trim().isEmpty || isValidUrl(imageUrl) == false
        ? SizedBox(
            width: width,
            height: height,
            child: (errorWidget ?? Icon(Icons.error)),
          )
        : CachedNetworkImage(
            imageUrl: imageUrl,
            width: width,
            height: height,
            color: color,
            fit: fit,
            cacheKey:
                '${imageUrl}_${width}_${height}_${memCacheWidth ?? calculatedWidth}_${memCacheHeight ?? calculatedHeight}',
            memCacheHeight: fullRes ? null : memCacheHeight ?? calculatedHeight,
            memCacheWidth: fullRes ? null : memCacheWidth ?? calculatedWidth,
            placeholder: (context, url) =>
                placeholder ??
                SizedBox(
                  width: width,
                  height: height,
                  child: CupertinoActivityIndicator(),
                ),
            errorWidget: (context, url, error) =>
                Container(
                  width: width,
                  height: height,
                  color: Theme.of(context).colorScheme.onSurface.customOpacity(0.1),
                  child: errorWidget ?? Icon(Icons.error),
                ),
          );
    return imageWidget;
  }
}
