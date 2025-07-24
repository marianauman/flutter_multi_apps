import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageAsset extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit? fit;
  final Widget? errorIcon;
  final Alignment alignment;
  final ImageRepeat repeat;

  const ImageAsset({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.contain,
    this.errorIcon,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
  });

  @override
  Widget build(BuildContext context) {
    // Image widget
    Widget imageWidget = Image.asset(
      imagePath,
      width: width ?? 28.r,
      height: height ?? 28.r,
      color: color,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      errorBuilder: (context, error, stackTrace) {
        return errorIcon ?? Icon(Icons.error, size: width, color: color);
      },
    );

    return imageWidget;
  }
}
