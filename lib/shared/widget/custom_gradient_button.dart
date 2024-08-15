import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halal_check/app_constants/icons_constants.dart';
import 'package:halal_check/theme/color_constant.dart';
import 'package:halal_check/theme/component_theme/custom_textstyle_theme.dart';

class CustomGradientButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color? buttonBGColor, disabledTextColor, textColor;
  final double width;
  final bool elevation;

  const CustomGradientButton(
      {super.key,
      required this.text,
      this.onPressed,
      this.buttonBGColor,
      this.disabledTextColor,
      this.textColor,
      this.width = double.infinity,
      this.elevation = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1000),
          boxShadow: [
            if (elevation)
              BoxShadow(
                spreadRadius: -4,
                color: ColorConstantLight.primary.withOpacity(0.4),
                offset: const Offset(10, 10.0), //(x,y)
                blurRadius: 14.0,
              ),
          ],
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              ColorConstantLight.secondary,
              ColorConstantLight.primary,
            ],
          )),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(1000),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              alignment: Alignment.center,
              child: Text(text,
                  style: CustomTextStyle.buttonTextStyle!
                      .copyWith(fontSize: width == double.infinity ? 16 : 12)),
            )),
      ),
    );
  }
}

class CustomGradientIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final String? iconPath;
  final bool elevation, showIcon;
  final Color? buttonBGColor, disabledTextColor, textColor;

  const CustomGradientIconButton(
      {super.key,
      required this.text,
      this.iconPath,
      this.onPressed,
      this.buttonBGColor,
      this.disabledTextColor,
      this.textColor,
      this.showIcon = false,
      this.elevation = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: showIcon ? 50 : null,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1000),
          boxShadow: [
            if (elevation)
              BoxShadow(
                spreadRadius: -4,
                color: ColorConstantLight.primary.withOpacity(0.4),
                offset: const Offset(10, 10.0), //(x,y)
                blurRadius: 14.0,
              ),
          ],
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              ColorConstantLight.secondary,
              ColorConstantLight.primary,
            ],
          )),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(1000),
            child: showIcon
                ? Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(IconsConstant.forwararrow),
                  )
                : Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 30),
                    alignment: Alignment.center,
                    child: Text(text,
                        style: CustomTextStyle.buttonTextStyle!
                            .copyWith(fontSize: 12.sp)),
                  )),
      ),
    );
  }
}

// =========================================================


