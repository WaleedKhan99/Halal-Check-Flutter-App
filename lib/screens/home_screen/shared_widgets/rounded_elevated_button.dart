import 'package:flutter/material.dart';
import 'package:halal_check/theme/component_theme/custom_textstyle_theme.dart';

class RoundedElevatedButton extends StatelessWidget {
  final String text;
  final Color color;
  final Function() onTap;
  const RoundedElevatedButton({
    super.key,
    required this.text,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
              elevation: 8,
              fixedSize: const Size.fromHeight(double.infinity),
              shadowColor: color,
              backgroundColor: color),
          child: Text(
            text,
            style: CustomTextStyle.buttonTextStyle,
          )),
    );
  }
}
