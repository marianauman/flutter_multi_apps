//textfield
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_apps/config/text_styles.dart';
import 'package:flutter_multi_apps/core/utils/app_extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/app_utils.dart';

class CustomTextField extends StatefulWidget {
  // Required parameter
  final TextEditingController controller;

  // Optional parameters
  final InputDecoration? decoration;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextStyle? style;
  final TextAlign textAlign;
  final bool autofocus;
  final bool obscureText;
  final bool enableSuggestions;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final Function(String)? onFieldSubmitted;
  final GestureTapCallback? onTap;
  final bool readOnly;
  final bool enabled;
  final bool autocorrect;
  final TextCapitalization capitalization;
  // Parameters for prefix/suffix icons and label behavior
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? prefix;
  final Widget? suffix;
  final String? labelText;
  final String? heading;
  final String? hintText;
  final TextStyle? hintStyle;
  final bool isFilled;
  final Color? fillColor;
  final BoxConstraints? suffixIconConstraints;
  final BoxConstraints? prefixIconConstraints;
  final FocusNode? focusNode;
  const CustomTextField({
    super.key,
    required this.controller,
    this.decoration,
    this.keyboardType,
    this.textInputAction,
    this.style,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.obscureText = false,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.prefix,
    this.suffix,
    this.heading,
    this.labelText,
    required this.hintText,
    this.hintStyle,
    this.isFilled = false,
    this.fillColor,
    this.suffixIconConstraints,
    this.prefixIconConstraints,
    this.autocorrect = true,
    this.focusNode,
    this.onFieldSubmitted,
    this.capitalization = TextCapitalization.none,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final InputDecoration effectiveDecoration =
        (widget.decoration ?? const InputDecoration()).copyWith(
          // Merge provided decoration with the new properties
          prefixIcon: widget.prefixIcon ?? widget.decoration?.prefixIcon,
          prefixIconConstraints:
              widget.prefixIconConstraints ??
              BoxConstraints(minWidth: 50.sp, minHeight: 23.sp),
          suffixIcon: widget.suffixIcon ?? widget.decoration?.suffixIcon,
          suffixIconConstraints:
              widget.suffixIconConstraints ?? BoxConstraints(minWidth: 35.sp),
          prefix: widget.prefix ?? widget.decoration?.prefix,
          suffix: widget.suffix ?? widget.decoration?.suffix,
          labelText: null,
          hintText: widget.hintText ?? widget.decoration?.hintText,
          hintStyle: widget.hintStyle ?? widget.decoration?.hintStyle,
          floatingLabelBehavior:
              widget.decoration?.floatingLabelBehavior ??
              FloatingLabelBehavior.always,
          filled: widget.isFilled,
          fillColor: widget.fillColor ?? widget.decoration?.fillColor,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.r,
            vertical: 15.r,
          ),
          // contentPadding: widget.suffixIcon != null
          //     ? EdgeInsets.fromLTRB(15.r, 15.r, 0.0, 15.r)
          //     : EdgeInsets.symmetric(horizontal: 16.r, vertical: 15.r),
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.heading != null) AppText.body3(text: widget.heading!),
        if (widget.heading != null) 7.customVerticalSpace,
        Semantics(
          label: "",
          hint: widget.hintText,
          value: widget.controller.text,
          enabled: widget.enabled,
          excludeSemantics: true,
          textField: true,
          child: AbsorbPointer(
            absorbing: !widget.enabled,
            child: TextField(
              key: widget.key,
              onSubmitted: widget.onFieldSubmitted,
              controller: widget.controller,
              focusNode: widget.focusNode,
              decoration: widget.decoration ?? effectiveDecoration,
              keyboardType: widget.keyboardType,
              textInputAction: widget.textInputAction,
              autocorrect: widget.obscureText
                  ? false
                  : widget.keyboardType == TextInputType.emailAddress
                  ? false
                  : widget.autocorrect,
              style: widget.style,
              textAlign: widget.textAlign,
              autofocus: widget.autofocus,
              obscureText: widget.obscureText,
              maxLines: widget.maxLines,
              minLines: widget.minLines,
              maxLength: widget.maxLength,
              onChanged: widget.onChanged,
              onTap: widget.onTap,
              readOnly: widget.readOnly,
              enabled: widget.enabled,
              enableSuggestions: widget.obscureText
                  ? false
                  : widget.enableSuggestions,
              enableInteractiveSelection: widget.obscureText ? false : true,
              textCapitalization: widget.capitalization,
              obscuringCharacter: '•',
              onTapOutside: (event) {
                hideKeyboard(context);
              },
            ),
          ),
        ),
      ],
    );
  }
}
