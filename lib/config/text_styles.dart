// text styles
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  static TextStyle title1({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontSize: (fontSize ?? 20).sp,
      fontWeight: fontWeight ?? FontWeight.w400,
      color: color,
      decoration: decoration,
    );
  }

  static TextStyle title2({
    FontWeight? fontWeight,
    Color? color,
    double? fontSize,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontSize: (fontSize ?? 18).sp,
      fontWeight: fontWeight ?? FontWeight.w400,
      color: color,
      decoration: decoration,
    );
  }

  static TextStyle title3({
    FontWeight? fontWeight,
    Color? color,
    double? fontSize,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontSize: (fontSize ?? 16).sp,
      fontWeight: fontWeight ?? FontWeight.w400,
      color: color,
      decoration: decoration,
    );
  }

  static TextStyle body1({
    FontWeight? fontWeight,
    Color? color,
    double? fontSize,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontSize: (fontSize ?? 14).sp,
      fontWeight: fontWeight ?? FontWeight.w400,
      color: color,
      decoration: decoration,
    );
  }

  static TextStyle body2({
    FontWeight? fontWeight,
    Color? color,
    double? fontSize,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontSize: (fontSize ?? 13).sp,
      fontWeight: fontWeight ?? FontWeight.w400,
      color: color,
      decoration: decoration,
    );
  }

  static TextStyle body3({
    FontWeight? fontWeight,
    Color? color,
    double? fontSize,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontSize: (fontSize ?? 12).sp,
      fontWeight: fontWeight ?? FontWeight.w400,
      color: color,
      decoration: decoration,
    );
  }

  static TextStyle subText1({
    FontWeight? fontWeight,
    Color? color,
    double? fontSize,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontSize: (fontSize ?? 11).sp,
      fontWeight: fontWeight ?? FontWeight.w400,
      color: color,
      decoration: decoration,
    );
  }

  static TextStyle subText2({
    FontWeight? fontWeight,
    Color? color,
    double? fontSize,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontSize: (fontSize ?? 11).sp,
      fontWeight: fontWeight ?? FontWeight.w400,
      color: color,
      decoration: decoration,
    );
  }

  static TextStyle subText3({
    FontWeight? fontWeight,
    Color? color,
    double? fontSize,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontSize: (fontSize ?? 11).sp,
      fontWeight: fontWeight ?? FontWeight.w400,
      color: color,
      decoration: decoration,
    );
  }
}

class AppText extends StatelessWidget {
  final String text;
  final TextStyle baseStyle;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final TextDecoration? decoration;
  final int? maxLines;
  final TextOverflow? overflow;

  const AppText(
    {
    required this.text,
    required this.baseStyle,
    this.textAlign,
    this.fontWeight,
    this.fontSize,
    this.color,
    this.decoration,
    this.maxLines,
    this.overflow,
    super.key,
  });

  AppText.title1(
    {
    required this.text,
    this.textAlign,
    this.fontWeight,
    this.fontSize,
    this.color,
    this.decoration,
    this.maxLines,
    this.overflow,
    super.key,
  }) : baseStyle = AppTextStyles.title1();

  AppText.title2(
    {
    required this.text,
    this.textAlign,
    this.fontWeight,
    this.fontSize,
    this.color,
    this.decoration,
    this.maxLines,
    this.overflow,
    super.key,
  }) : baseStyle = AppTextStyles.title2();

  AppText.title3(
    {
    required this.text,
    this.textAlign,
    this.fontWeight,
    this.fontSize,
    this.color,
    this.decoration,
    this.maxLines,
    this.overflow,
    super.key,
  }) : baseStyle = AppTextStyles.title3();

  AppText.body1(
    {
    required this.text,
    this.textAlign,
    this.fontWeight,
    this.fontSize,
    this.color,
    this.decoration,
    this.maxLines,
    this.overflow,
    super.key,
  }) : baseStyle = AppTextStyles.body1();

  AppText.body2(
    {
    required this.text,
    this.textAlign,
    this.fontWeight,
    this.fontSize,
    this.color,
    this.decoration,
    this.maxLines,
    this.overflow,
    super.key,
  }) : baseStyle = AppTextStyles.body2();

  AppText.body3(
    {
    required this.text,
    this.textAlign,
    this.fontWeight,
    this.fontSize,
    this.color,
    this.decoration,
    this.maxLines,
    this.overflow,
    super.key,
  }) : baseStyle = AppTextStyles.body3();

  AppText.subText1(
    {
    required this.text,
    this.textAlign,
    this.fontWeight,
    this.fontSize,
    this.color,
    this.decoration,
    this.maxLines,
    this.overflow,
    super.key,
  }) : baseStyle = AppTextStyles.subText1();

  AppText.subText2(
    {
    required this.text,
    this.textAlign,
    this.fontWeight,
    this.fontSize,
    this.color,
    this.decoration,
    this.maxLines,
    this.overflow,
    super.key,
  }) : baseStyle = AppTextStyles.subText2();

  AppText.subText3(
    {
    required this.text,
    this.textAlign,
    this.fontWeight,
    this.fontSize,
    this.color,
    this.decoration,
    this.maxLines,
    this.overflow,
    super.key,
  }) : baseStyle = AppTextStyles.subText3();

  @override
  Widget build(BuildContext context) {
    final mergedStyle = baseStyle.copyWith(
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
      decoration: decoration,
    );

    return Text(
      text,
      style: mergedStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
