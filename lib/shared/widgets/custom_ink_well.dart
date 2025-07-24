import 'package:flutter/material.dart';

class CustomInkWell extends StatefulWidget {
  final Function()? onTap;
  final Function()? onLongPress;
  final Widget child;
  final Color? splashColor;
  final InteractiveInkFeatureFactory? splashFactory;
  final BorderRadius? borderRadius;

  const CustomInkWell({
    super.key,
    required this.onTap,
    required this.child,
    this.onLongPress,
    this.splashColor,
    this.splashFactory,
    this.borderRadius,
  });

  @override
  State<CustomInkWell> createState() => _CustomInkWellState();
}

class _CustomInkWellState extends State<CustomInkWell> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: widget.splashColor,
      splashFactory: widget.splashFactory,
      borderRadius: widget.borderRadius,
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      onLongPress: widget.onLongPress,
      child: widget.child,
    );
  }
}
