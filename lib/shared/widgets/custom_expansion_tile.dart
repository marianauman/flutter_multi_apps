import 'package:flutter/material.dart';
import 'package:flutter_multi_apps/core/utils/app_extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/text_styles.dart';
import 'custom_ink_well.dart';

class CustomExpansionTile extends StatefulWidget {
  final String title;
  final String? subtitle;
  final List<Widget> children;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? collapsedBackgroundColor;
  final double? elevation;
  final ShapeBorder? shape;
  final bool initiallyExpanded;
  final bool maintainState;
  final bool tilePadding;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onExpansionChanged;
  final Color? iconColor;
  final Color? collapsedIconColor;
  final double? iconSize;
  final Duration? animationDuration;
  final Curve? animationCurve;
  final bool? expandedAlignment;
  final bool? expandedCrossAxisAlignment;
  final bool childrenPadding;
  final Color? collapsedTextColor;
  final Color? textColor;
  final TextStyle? titleTextStyle;
  final TextStyle? subtitleTextStyle;

  const CustomExpansionTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.children,
    this.margin,
    this.padding,
    this.backgroundColor,
    this.collapsedBackgroundColor,
    this.elevation,
    this.shape,
    this.initiallyExpanded = false,
    this.maintainState = false,
    this.tilePadding = true,
    this.leading,
    this.trailing,
    this.onExpansionChanged,
    this.iconColor,
    this.collapsedIconColor,
    this.iconSize,
    this.animationDuration,
    this.animationCurve,
    this.expandedAlignment,
    this.expandedCrossAxisAlignment,
    this.childrenPadding = true,
    this.collapsedTextColor,
    this.textColor,
    this.titleTextStyle,
    this.subtitleTextStyle,
  });

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _iconTurns;
  late Animation<double> _heightFactor;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration ?? const Duration(milliseconds: 200),
      vsync: this,
    );
    _iconTurns = Tween<double>(begin: 0.0, end: 0.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _heightFactor = _controller.drive(CurveTween(curve: Curves.easeInOut));
    _isExpanded = widget.initiallyExpanded;
    if (_isExpanded) {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
    widget.onExpansionChanged?.call();
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color backgroundColor = widget.backgroundColor ?? colorScheme.surface;
    final Color collapsedBackgroundColor = 
        widget.collapsedBackgroundColor ?? colorScheme.surface;

    return CustomInkWell(
      onTap: _handleTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 10.r),
          decoration: BoxDecoration(
            color: _isExpanded ? backgroundColor : collapsedBackgroundColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
        child: Column(
          children: [
            Padding(
              padding: widget.padding ?? const EdgeInsets.all(16),
              child: Row(
                children: [
                  if (widget.leading != null) ...[
                    widget.leading!,
                    12.customHorizontalSpace,
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.body1(text: widget.title),
                        if (widget.subtitle != null) ...[
                          4.customVerticalSpace,
                          AppText.subText2(text: widget.subtitle!),
                        ],
                      ],
                    ),
                  ),
                  if (widget.trailing != null) ...[
                    12.customHorizontalSpace,
                    widget.trailing!,
                  ],
                  8.customHorizontalSpace,
                  RotationTransition(
                    turns: _iconTurns,
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: _isExpanded 
                          ? (widget.iconColor ?? colorScheme.primary)
                          : (widget.collapsedIconColor ?? colorScheme.onSurface),
                      size: widget.iconSize ?? 24.r,
                    ),
                  ),
                ],
              ),
            ),
            ClipRect(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget? child) {
                  return Align(
                    alignment: Alignment.topCenter,
                    heightFactor: _heightFactor.value,
                    child: child,
                  );
                },
                child: _isExpanded
                    ? Padding(
                        padding: widget.childrenPadding == true
                            ? const EdgeInsets.fromLTRB(16, 0, 16, 16)
                            : EdgeInsets.zero,
                        child: Column(children: widget.children),
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    return _buildChildren(
      context,
      closed && !widget.maintainState ? null : Column(children: widget.children),
    );
  }
} 