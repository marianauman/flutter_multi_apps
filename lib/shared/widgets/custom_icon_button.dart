import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_ink_well.dart';
import 'image_asset.dart';

class CustomIconButton extends StatelessWidget {
  final IconData? icon;
  final String? imagePath;
  final double? size;
  final Color? iconColor;
  final Color? backgroundColor;
  final List<Color>? gradientColors;
  final VoidCallback onPressed;
  final double? paddingLeft;
  final double? paddingRight;
  final double? paddingTop;
  final double? paddingBottom;
  final double? splashRadius;
  final double? borderRadius;
  final double? paddingAll;
  final Color? splashColor;
  final Color? highlightColor;
  final bool isLoading;
  final Color? loaderColor;
  final bool iconColorEnabled;

  const CustomIconButton({
    super.key,
    this.icon,
    this.imagePath,
    required this.onPressed,
    this.size,
    this.iconColor,
    this.backgroundColor,
    this.gradientColors,
    this.paddingLeft,
    this.paddingRight,
    this.paddingTop,
    this.paddingBottom,
    this.splashRadius,
    this.borderRadius,
    this.paddingAll,
    this.splashColor,
    this.highlightColor,
    this.isLoading = false,
    this.loaderColor,
    this.iconColorEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final bool isInteractable = !isLoading;

    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: splashColor ?? Colors.transparent,
        highlightColor: highlightColor ?? Colors.transparent,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
        child: CustomInkWell(
          onTap: isInteractable ? onPressed : null,
          splashFactory: InkRipple.splashFactory,
          borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
          child: AbsorbPointer(
            absorbing: !isInteractable,
            child: Container(
              decoration: BoxDecoration(
                color: gradientColors == null
                    ? backgroundColor ?? Theme.of(context).colorScheme.surface
                    : null,
                gradient: gradientColors != null
                    ? LinearGradient(
                        colors: gradientColors!,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomLeft,
                      )
                    : null,
                borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
              ),
              padding: paddingAll != null
                  ? EdgeInsets.all(paddingAll!)
                  : EdgeInsets.only(
                      left: paddingLeft ?? 7.r,
                      right: paddingRight ?? 7.r,
                      top: paddingTop ?? 7.r,
                      bottom: paddingBottom ?? 7.r,
                    ),
              child: Stack(
                children: [
                  Opacity(
                    opacity: isLoading ? 0.0 : 1.0,
                    child: imagePath != null
                        ? ImageAsset(
                            imagePath: imagePath!,
                            color: iconColorEnabled ? iconColor ??
                                Theme.of(context).colorScheme.onSurface : null,
                            height: size ?? 28.r,
                            width: size ?? 28.r,
                          )
                        : Icon(icon, size: size ?? 28.r, color: iconColorEnabled ? iconColor ??
                                Theme.of(context).colorScheme.onSurface : null),  
                  ),
                  if (isLoading)
                    Positioned.fill(
                      child: Center(
                        child: CupertinoActivityIndicator(
                            color: loaderColor ?? Theme.of(context).colorScheme.onSurface,
                            radius: 10.sp,
                            animating: true,
                        ),
                      ),  
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
