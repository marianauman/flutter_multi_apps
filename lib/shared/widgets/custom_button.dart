import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/text_styles.dart';
import 'custom_ink_well.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final String btnTitle;
  final Color? backgroundColorActive;
  final Color? backgroundColorInactive;
  final Color? backgroundColorLoading;
  final double? fontSize;
  final bool disabled;
  final bool isLoading;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final double elevation;
  final Color? textColorActive;
  final Color? textColorInactive;
  final Color? loaderColor;

  /// **New optional border-related parameters**:
  final Color? borderColor;
  final double? borderWidth;

  /// Image URL to display alongside the label
  final IconData? icon;
  final double? iconSize;
  final Color? iconColor;
  final bool iconOnLeft;

  const CustomButton({
    super.key,
    required this.btnTitle,
    this.onTap,
    this.onLongPress,
    this.backgroundColorActive,
    this.backgroundColorInactive,
    this.backgroundColorLoading,
    this.fontSize,
    this.disabled = false,
    this.isLoading = false,
    this.padding,
    this.borderRadius,
    this.elevation = 0.0,
    this.textColorActive,
    this.textColorInactive,
    this.loaderColor,
    this.borderColor,
    this.borderWidth,
    this.icon,
    this.iconSize,
    this.iconColor,
    this.iconOnLeft = true,
  });

  @override
  Widget build(BuildContext context) {
    // Determine effective colors based on parameters and theme.
    final Color effectiveBackgroundColorActive = backgroundColorActive ?? Theme.of(context).colorScheme.primary;
    final Color effectiveBackgroundColorInactive = backgroundColorInactive ?? Theme.of(context).colorScheme.primary.withAlpha((255 * 0.65).toInt());
    final Color effectiveBackgroundColorLoading = backgroundColorLoading ?? Theme.of(context).colorScheme.primary.withAlpha((255 * 0.65).toInt());
    // Whether the button should be interactable
    final bool isInteractable = !disabled && !isLoading;

    // Decide final background color
    final Color effectiveBackgroundColor = isLoading
        ? effectiveBackgroundColorLoading
        : (disabled
            ? effectiveBackgroundColorInactive
            : effectiveBackgroundColorActive);


    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
        // If borderColor is null, it defaults to no border.
        border: borderColor != null
            ? Border.all(
                color: borderColor!,
                width: borderWidth ?? 1.0,
              )
            : null,
      ),
      child: Material(
        color: effectiveBackgroundColor,
        elevation: elevation,
        borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
        child: CustomInkWell(
          borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
          onTap: isInteractable ? onTap : null,
          onLongPress: isInteractable ? onLongPress : null,
          child: AbsorbPointer(
            absorbing: !isInteractable,
            child: Padding(
              padding: padding ??
                  EdgeInsets.symmetric(horizontal: 10.r, vertical: 12.r),
              child: SizedBox(
                width: 1.sw,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Opacity(
                      opacity: isLoading ? 0.0 : 1.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (icon != null && iconOnLeft) ...[ 
                            Icon(icon, size: iconSize ?? 24.sp, color: iconColor ?? Theme.of(context).colorScheme.onPrimary),
                            SizedBox(width: 8.sp),
                          ],
                          Flexible(
                            child: AppText.title3(
                              text: btnTitle,
                              color: textColorActive ?? Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (icon != null && !iconOnLeft) ...[ 
                            SizedBox(width: 8.sp),
                            Icon(icon, size: iconSize ?? 24.sp, color: iconColor ?? Theme.of(context).colorScheme.onPrimary),
                          ],
                        ],
                      ),
                    ),
                    // Loading indicator
                    if (isLoading)
                      Positioned.fill(
                        child: Center(
                          child: CupertinoActivityIndicator(
                            color: loaderColor ?? Theme.of(context).colorScheme.onPrimary,
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
      ),
    );
  }
}
