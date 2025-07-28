import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/color_constants.dart';

class CustomToggle extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? thumbColor;
  final double? width;
  final double? height;
  final double? thumbSize;
  final Duration? animationDuration;
  final bool disabled;
  final String? label;
  final TextStyle? labelStyle;
  final bool showLabel;

  const CustomToggle({
    super.key,
    required this.value,
    this.onChanged,
    this.activeColor,
    this.inactiveColor,
    this.thumbColor,
    this.width,
    this.height,
    this.thumbSize,
    this.animationDuration,
    this.disabled = false,
    this.label,
    this.labelStyle,
    this.showLabel = false,
  });

  @override
  State<CustomToggle> createState() => _CustomToggleState();
}

class _CustomToggleState extends State<CustomToggle>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration ?? const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    if (widget.value) {
      _animationController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(CustomToggle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      if (widget.value) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Determine effective colors
    final Color effectiveActiveColor = widget.activeColor ?? 
        theme.colorScheme.primary;
    final Color effectiveInactiveColor = widget.inactiveColor ?? 
        ColorConstants.secondary100;
    final Color effectiveThumbColor = widget.thumbColor ?? 
        Colors.white;
    
    // Determine effective sizes
    final double effectiveWidth = widget.width ?? 50.w;
    final double effectiveHeight = widget.height ?? 28.h;
    final double effectiveThumbSize = widget.thumbSize ?? (effectiveHeight - 4);

    return Opacity(
      opacity: widget.disabled ? 0.5 : 1.0,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.showLabel && widget.label != null) ...[
            Text(
              widget.label!,
              style: widget.labelStyle ?? 
                  TextStyle(
                    fontSize: 14.sp,
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            SizedBox(width: 12.w),
          ],
          GestureDetector(
            onTap: widget.disabled ? null : () {
              widget.onChanged?.call(!widget.value);
            },
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Container(
                  width: effectiveWidth,
                  height: effectiveHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(effectiveHeight / 2),
                    color: Color.lerp(
                      effectiveInactiveColor,
                      effectiveActiveColor,
                      _animation.value,
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Thumb
                      Positioned(
                        left: _animation.value * (effectiveWidth - effectiveThumbSize - 2),
                        top: 2,
                        child: Container(
                          width: effectiveThumbSize,
                          height: effectiveThumbSize,
                          decoration: BoxDecoration(
                            color: effectiveThumbColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Convenience widget for simple toggle without label
class SimpleToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? thumbColor;
  final double? width;
  final double? height;
  final double? thumbSize;
  final Duration? animationDuration;
  final bool disabled;

  const SimpleToggle({
    super.key,
    required this.value,
    this.onChanged,
    this.activeColor,
    this.inactiveColor,
    this.thumbColor,
    this.width,
    this.height,
    this.thumbSize,
    this.animationDuration,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomToggle(
      value: value,
      onChanged: onChanged,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      thumbColor: thumbColor,
      width: width,
      height: height,
      thumbSize: thumbSize,
      animationDuration: animationDuration,
      disabled: disabled,
    );
  }
}

// Toggle with label widget
class LabeledToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final String label;
  final TextStyle? labelStyle;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? thumbColor;
  final double? width;
  final double? height;
  final double? thumbSize;
  final Duration? animationDuration;
  final bool disabled;

  const LabeledToggle({
    super.key,
    required this.value,
    required this.label,
    this.onChanged,
    this.labelStyle,
    this.activeColor,
    this.inactiveColor,
    this.thumbColor,
    this.width,
    this.height,
    this.thumbSize,
    this.animationDuration,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomToggle(
      value: value,
      onChanged: onChanged,
      label: label,
      labelStyle: labelStyle,
      showLabel: true,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      thumbColor: thumbColor,
      width: width,
      height: height,
      thumbSize: thumbSize,
      animationDuration: animationDuration,
      disabled: disabled,
    );
  }
} 