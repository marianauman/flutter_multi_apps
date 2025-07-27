import 'package:flutter/material.dart';
import 'package:flutter_multi_apps/core/utils/app_extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonLoaderShimmer extends StatelessWidget {
  final Widget child;
  final Color? baseColor;
  final Color? highlightColor;

  const SkeletonLoaderShimmer({super.key, required this.child, this.baseColor, this.highlightColor});    

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Theme.of(context).colorScheme.surface.customOpacity(0.5),
      highlightColor: highlightColor ?? Theme.of(context).colorScheme.surface.customOpacity(0.3),
      child: child,
    );
  }
}

class SkeletonLoaderBox extends StatelessWidget {
  final double? width;
  final double? height;
  final double? borderRadius;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const SkeletonLoaderBox({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(borderRadius ?? 4.r),
      ),
    );
  }
}
