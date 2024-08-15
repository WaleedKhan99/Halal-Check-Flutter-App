import 'package:flutter/material.dart';

import '../../theme/color_constant.dart';
import '../../theme/component_theme/custom_textstyle_theme.dart';

class CustomOnBoardingGradientButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  final Color? buttonBGColor, disabledTextColor, textColor;
  final double? width;
  final double? height;
  final Widget? icon;
  final bool showShadow; // New property to control shadow visibility

  const CustomOnBoardingGradientButton({
    Key? key,
    this.text,
    this.onPressed,
    this.buttonBGColor,
    this.disabledTextColor,
    this.textColor,
    this.width = double.infinity,
    this.height = double.infinity,
    this.icon,
    this.showShadow = true, // Default value is true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1000),
        boxShadow: showShadow
            ? [
                BoxShadow(
                  spreadRadius: -4,
                  color: ColorConstantLight.primary.withOpacity(0.4),
                  offset: const Offset(10, 10.0), //(x,y)
                  blurRadius: 14.0,
                ),
              ]
            : [], // Conditionally include shadow
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorConstantLight.secondary,
            ColorConstantLight.primary,
          ],
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(1000),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) icon!,
                if (text != null && icon != null)
                  SizedBox(width: 8), // Add some space between icon and text
                if (text != null)
                  Text(
                    text!,
                    style: CustomTextStyle.buttonTextStyle!
                        .copyWith(fontSize: width == double.infinity ? 16 : 12),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
