// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}

class CustomTextStyle extends TextTheme {
  static String _family = 'Euclid Circular A';

  static Color _fontColor = const Color(0xff1A1E25);
  static Color _secondaryFontColor = const Color(0xff7D7F88);

  @override
  TextStyle? get titleLarge => TextStyle(
        fontFamily: _family,
        fontWeight: FontWeight.w700,
        fontSize: 24,
        color: _fontColor,
      );

  @override
  TextStyle? get titleMedium => TextStyle(
        fontFamily: _family,
        fontWeight: FontWeight.w500,
        color: _fontColor,
      );

  @override
  TextStyle? get titleSmall => TextStyle(
        fontFamily: _family,
        fontWeight: FontWeight.w500,
        color: _fontColor,
      );

  @override
  TextStyle? get labelLarge => TextStyle(
      fontFamily: _family,
      fontWeight: FontWeight.w400,
      color: _fontColor,
      fontSize: 16);

  @override
  TextStyle? get labelMedium => TextStyle(
        fontFamily: _family,
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: _fontColor,
      );

  @override
  TextStyle? get labelSmall => TextStyle(
        fontFamily: _family,
        fontWeight: FontWeight.w500,
        color: _fontColor,
      );

  @override
  TextStyle? get bodyLarge => TextStyle(
        fontFamily: _family,
        fontWeight: FontWeight.w400,
        color: _fontColor,
      );

  @override
  TextStyle? get bodyMedium => TextStyle(
        fontFamily: _family,
        fontWeight: FontWeight.w400,
        color: _secondaryFontColor,
      );

  @override
  TextStyle? get bodySmall => TextStyle(
        fontFamily: _family,
        fontWeight: FontWeight.w400,
        color: _fontColor,
      );

  @override
  TextStyle? get displayLarge => TextStyle(
        fontFamily: _family,
        fontWeight: FontWeight.w400,
        color: _fontColor,
      );

  @override
  TextStyle? get displayMedium => TextStyle(
        fontFamily: _family,
        fontWeight: FontWeight.w400,
        color: _fontColor,
      );

  @override
  TextStyle? get displaySmall => TextStyle(
      fontFamily: _family,
      fontWeight: FontWeight.w400,
      color: _secondaryFontColor,
      fontSize: 14);

  @override
  TextStyle? get headlineLarge => TextStyle(
        fontFamily: _family,
        fontWeight: FontWeight.w400,
        color: _fontColor,
      );

  @override
  TextStyle? get headlineMedium => TextStyle(
        fontFamily: _family,
        fontWeight: FontWeight.w400,
        color: _fontColor,
      );

  @override
  TextStyle? get headlineSmall => TextStyle(
        fontFamily: _family,
        fontWeight: FontWeight.w400,
        color: _fontColor,
      );

  @override
  TextStyle? get button => TextStyle(
      fontFamily: _family,
      fontWeight: FontWeight.w500,
      color: _fontColor,
      fontSize: 16);

  static TextStyle? get hintText => TextStyle(
      fontFamily: _family,
      fontWeight: FontWeight.w400,
      color: const Color(0xff7D7F88),
      fontSize: 16);
  static TextStyle? get buttonTextStyle => TextStyle(
      fontFamily: _family,
      fontWeight: FontWeight.w500,
      color: Colors.white,
      fontSize: 16);
}
