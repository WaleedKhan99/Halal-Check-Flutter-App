import 'package:flutter/material.dart';
import 'package:halal_check/theme/color_constant.dart';
import 'component_theme/component_theme.dart';
import 'component_theme/custom_textstyle_theme.dart';

class CustomThemeData {
  static ThemeData getThemeData({bool isDark = false}) {
    final colorScheme = isDark ? darkColorScheme() : lightColorScheme();
    return ThemeData(
      colorScheme: colorScheme,
      textTheme: CustomTextStyle(),
      appBarTheme: ComponentTheme.appBarTheme,
      textButtonTheme: ComponentTheme.textButtonTheme,
      iconButtonTheme: ComponentTheme.iconButtonTheme,
      outlinedButtonTheme: ComponentTheme.outlinedButtonTheme,
      elevatedButtonTheme: ComponentTheme.elevatedButtonTheme,
      inputDecorationTheme: ComponentTheme.inputDecorationTheme,
    );
  }

  static lightColorScheme() => const ColorScheme.light(
        primary: ColorConstantLight.primary,
        secondary: ColorConstantLight.secondary,
      );

  static darkColorScheme() => const ColorScheme.dark(
        primary: ColorConstantDark.primary,
        secondary: ColorConstantDark.secondary,
      );
}
