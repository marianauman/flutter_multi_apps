import 'package:flutter/material.dart';
import 'package:flutter_multi_apps/core/utils/app_extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/text_styles.dart';
import 'custom_ink_well.dart';

class CustomRadioListTile<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final bool dense;
  final bool isThreeLine;
  final bool? selected;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? titleColor;
  final Color? subtitleColor;
  final EdgeInsetsGeometry? contentPadding;
  final bool autofocus;
  final bool? toggleable;
  final MaterialTapTargetSize? materialTapTargetSize;
  final VisualDensity? visualDensity;
  final FocusNode? focusNode;
  final bool enableFeedback;

  const CustomRadioListTile({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.dense = false,
    this.isThreeLine = false,
    this.selected,
    this.activeColor,
    this.inactiveColor,
    this.titleColor,
    this.subtitleColor,
    this.contentPadding,
    this.autofocus = false,
    this.toggleable,
    this.materialTapTargetSize,
    this.visualDensity,
    this.focusNode,
    this.enableFeedback = true,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final bool isSelected = value == groupValue;
    final bool isEnabled = onChanged != null;

    return CustomInkWell(
      onTap: isEnabled ? () => onChanged!(value) : null,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        color: Colors.transparent,
        padding: contentPadding ?? EdgeInsets.symmetric(
          horizontal: 16.r,
          vertical: 12.r,
        ),
        child: Row(
          children: [
            // Custom Radio Button
            Container(
              width: 20.w,
              height: 20.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? (activeColor ?? colorScheme.primary)
                      : (inactiveColor ?? colorScheme.outline),
                  width: 2.w,
                ),
                color: isSelected
                    ? (activeColor ?? colorScheme.primary)
                    : Colors.transparent,
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 8.w,
                        height: 8.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : null,
            ),
            16.customHorizontalSpace,
            // Leading Widget
            if (leading != null) ...[
              leading!,
              12.customHorizontalSpace,
            ],
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.body1(
                    text: title,
                    color: titleColor ?? (isEnabled 
                        ? colorScheme.onSurface 
                        : colorScheme.onSurface.customOpacity(0.6)),
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                  if (subtitle != null) ...[
                    4.customVerticalSpace,
                    AppText.subText2(
                      text: subtitle!,
                      color: subtitleColor ?? (isEnabled 
                          ? colorScheme.onSurfaceVariant 
                          : colorScheme.onSurfaceVariant.customOpacity(0.6)),
                    ),
                  ],
                ],
              ),
            ),
            // Trailing Widget
            if (trailing != null) ...[
              12.customHorizontalSpace,
              trailing!,
            ],
          ],
        ),
      ),
    );
  }
} 