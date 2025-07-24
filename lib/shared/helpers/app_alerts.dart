import 'package:flutter/material.dart';
import '../../config/routes.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/assets_constants.dart';
import '../../core/constants/text_constants.dart';
import '../widgets/custom_dialog_widget.dart';
import 'app_dialog.dart';

/// Configuration class for common dialog parameters
class DialogConfig {
  final DialogPosition position;
  final DialogAnimationType animationType;
  final bool isDismissible;
  final Duration transitionDuration;
  final SlideDirection? slideDirection;
  final Offset? customSlideOffset;
  final double blurValue;

  const DialogConfig({
    this.position = DialogPosition.bottom,
    this.animationType = DialogAnimationType.fade,
    this.isDismissible = true,
    this.transitionDuration = const Duration(milliseconds: 350),
    this.slideDirection,
    this.customSlideOffset,
    this.blurValue = 0.0
  });
}

class AppAlerts extends AppDialogBuilder {
  /// Base method using DialogConfig
  static Future<T?> _showBaseDialog<T>({
    required BuildContext context,
    required Widget child,
    DialogConfig? config,
  }) async {
    final DialogConfig dialogConfig = config ?? const DialogConfig();
    
    final result = await AppDialogBuilder.showCustomDialog(
      context: context,
      position: dialogConfig.position,
      animationType: dialogConfig.animationType,
      isDismissible: dialogConfig.isDismissible,
      transitionDuration: dialogConfig.transitionDuration,
      slideDirection: dialogConfig.slideDirection,
      customSlideOffset: dialogConfig.customSlideOffset,
      child: child,
      blurValue: dialogConfig.blurValue,
    );
    
    return result as T?;
  }

  /// Shows a custom dialog with the provided child widget
  static Future<void> showCustomDialog({
    required Widget child,
    DialogConfig? config,
  }) async {
    await _showBaseDialog(
      context: NavigationService.context,
      child: child,
      config: config,
    );
  }

  /// Shows a confirmation dialog with confirm and cancel buttons
  static Future<bool> showConfirmationDialog({
    required String title,
    required String message,
    String? confirmBtnTitle,
    String? cancelBtnTitle,
    DialogConfig? config,
    Function(bool)? onTapConfirm,
    Function(bool)? onTapCancel,
  }) async { 
   var result = await _showBaseDialog(
      context: NavigationService.context,
      config: config,
      child: CustomDialogWidget(
        title: title,
        subtitle: message,
        confirmBtnTitle: confirmBtnTitle ?? 
            TextConstants.ok,
        cancelBtnTitle: cancelBtnTitle ?? 
            TextConstants.cancel,
        dialogType: DialogType.confirmation,
        onTapConfirm: () {
          onTapConfirm?.call(true);
          NavigationService.pop(true);
        },
        onTapCancel: () {
          onTapCancel?.call(false);
          NavigationService.pop(false);
        },
      ),
    );
    return result ?? false;
  }

  /// Shows a success dialog with a success icon
  static Future<void> showSuccessDialog({
    required String title,
    required String message,
    String? confirmBtnTitle,
    DialogConfig? config,
    Function(bool)? onTapConfirm,
  }) async {
    return await _showBaseDialog(
      context: NavigationService.context,
      config: config,
      child: CustomDialogWidget(
        title: title,
        subtitle: message,
        imagePath: AssetsConstants.successIcon,
        confirmBtnTitle: confirmBtnTitle ?? 
            TextConstants.ok,
        dialogType: DialogType.success,
        onTapConfirm: () {
          onTapConfirm?.call(true);
          NavigationService.pop(true);
        },
      ),
    );
  }

  /// Shows an error dialog with an error icon
  static Future<bool> showErrorDialog({
    required String title,
    required String message,
    String? confirmBtnTitle,
    DialogConfig? config,
    Function(bool)? onTapConfirm,
  }) async {
    final result = await _showBaseDialog<bool>(
      context: NavigationService.context,
      config: config,
      child: CustomDialogWidget(
        title: title,
        subtitle: message,
        imagePath: AssetsConstants.errorIcon,
        confirmBtnTitle: confirmBtnTitle ?? 
            TextConstants.ok,
        dialogType: DialogType.error,
        onTapConfirm: () {
          onTapConfirm?.call(true);
          NavigationService.pop(true);
        },
      ),
    );
    return result ?? false;
  }

  /// Shows an info dialog with an info icon
  static Future<bool> showInfoDialog({
    required String title,
    required String message,
    String? confirmBtnTitle,
    DialogConfig? config,
    Function(bool)? onTapConfirm,
  }) async {
    final result = await _showBaseDialog<bool>(
      context:  NavigationService.context,
      config: config,
      child: CustomDialogWidget(
        title: title,
        subtitle: message,
        imagePath: AssetsConstants.infoIcon,
        confirmBtnTitle: confirmBtnTitle ?? 
            TextConstants.ok,
        dialogType: DialogType.info,
        onTapConfirm: () {
          onTapConfirm?.call(true);
          NavigationService.pop(true);
        },
      ),
    );
    return result ?? false;
  }
}