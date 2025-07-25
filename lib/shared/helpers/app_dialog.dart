import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_multi_apps/core/utils/app_extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/app_utils.dart';

abstract class AppDialogBuilder {
  @protected
  static Future<T?> showCustomDialog<T>({
    required BuildContext context,
    required Widget child,
    DialogPosition position = DialogPosition.bottom,
    DialogAnimationType animationType = DialogAnimationType.fade,
    Duration transitionDuration = const Duration(milliseconds: 500),
    SlideDirection? slideDirection,
    Offset? customSlideOffset,
    bool isDismissible = true,
    double blurValue = 0.0
  }) {
    position = isTablet(context) ? DialogPosition.center : DialogPosition.bottom;
    Alignment alignment;
    switch (position) {
      case DialogPosition.top:
        alignment = Alignment.topCenter;
        break;
      case DialogPosition.center:
        alignment = Alignment.center;
        break;
      case DialogPosition.bottom:
        alignment = Alignment.bottomCenter;
        break;
    }
    Offset beginOffset = Offset.zero;
    if (animationType == DialogAnimationType.slide) {
      if (customSlideOffset != null) {
        beginOffset = customSlideOffset;
      } else if (slideDirection != null) {
        switch (slideDirection) {
          case SlideDirection.left:
            beginOffset = const Offset(-1, 0);
            break;
          case SlideDirection.right:
            beginOffset = const Offset(1, 0);
            break;
          case SlideDirection.top:
            beginOffset = const Offset(0, -1);
            break;
          case SlideDirection.bottom:
            beginOffset = const Offset(0, 1);
            break;
        }
      } else {
        // Fallback: if no slideDirection provided, use default based on dialog position.
        switch (position) {
          case DialogPosition.top:
            beginOffset = const Offset(0, -1);
            break;
          case DialogPosition.center:
            // Default center dialogs slide in from the bottom.
            beginOffset = const Offset(0, 1);
            break;
          case DialogPosition.bottom:
            beginOffset = const Offset(0, 1);
            break;
        }
      }
    }

    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: isDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black.customOpacity(0.3),
      transitionDuration: transitionDuration,
      pageBuilder: (context, animation, secondaryAnimation) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurValue, sigmaY: blurValue),
          child: Padding(
            padding: isTablet(context) 
                ? EdgeInsets.symmetric(
                    horizontal: 350.r,
                  ).copyWith(bottom: MediaQuery.of(context).viewInsets.bottom)
                 : EdgeInsets.symmetric(horizontal: 16.r, vertical: 20.r)
                    .copyWith(bottom: MediaQuery.of(context).viewInsets.bottom + 40.r),
            child: Align(
              alignment: alignment,
              child: SingleChildScrollView(
                child: Material(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  // elevation: 24,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: AppConstants.dialogMaxWidth, maxHeight: AppConstants.dialogMaxHeight),
                    child: child,
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, dialogChild) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
        );

        switch (animationType) {
          case DialogAnimationType.fade:
            return FadeTransition(
              opacity: curvedAnimation,
              child: dialogChild,
            );
          case DialogAnimationType.scale:
            return ScaleTransition(
              scale: curvedAnimation,
              child: FadeTransition(
                opacity: curvedAnimation,
                child: dialogChild,
              ),
            );
          case DialogAnimationType.rotate:
            return RotationTransition(
              turns: curvedAnimation,
              child: FadeTransition(
                opacity: curvedAnimation,
                child: dialogChild,
              ),
            );
          case DialogAnimationType.slide:
            return SlideTransition(
              position: Tween<Offset>(
                begin: beginOffset,
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: FadeTransition(
                opacity: curvedAnimation,
                child: dialogChild,
              ),
            );
        }
      },
    );
  }
}