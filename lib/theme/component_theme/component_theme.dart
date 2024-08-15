import 'package:flutter/material.dart';
import 'package:halal_check/theme/component_theme/custom_textstyle_theme.dart';

class ComponentTheme {
  //================ Appbar Theme Start =================
  static AppBarTheme appBarTheme = AppBarTheme();
  //================ Appbar Theme End =================

  // ================== TextForm Decoration Start ===================
  static InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    fillColor: const Color(0xffF2F2F3),
    hintStyle: CustomTextStyle.hintText,
    filled: true,
    suffixIconColor: const Color(0xff7D7F88),
    border: const OutlineInputBorder(
      borderSide: BorderSide(),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 0),
    errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xffE3E3E7)),
        borderRadius: BorderRadius.all(Radius.circular(100))),
    enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xffE3E3E7)),
        borderRadius: BorderRadius.all(Radius.circular(100))),
    focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xffE3E3E7)),
        borderRadius: BorderRadius.all(Radius.circular(100))),
    focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xff18432D)),
        borderRadius: BorderRadius.all(Radius.circular(100))),
    disabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xffE3E3E7)),
        borderRadius: BorderRadius.all(Radius.circular(100))),
    outlineBorder: const BorderSide(color: Color(0xffE3E3E7)),
  );
  // ================== TextForm Decoration End ===================

  //================ Button Theme Data Start =================
  static final elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(),
  );

  static final outlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(),
  );

  static final textButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(),
  );

  static final iconButtonTheme = IconButtonThemeData(
    style: IconButton.styleFrom(),
  );
  //================ Button Theme Data End =================
}
