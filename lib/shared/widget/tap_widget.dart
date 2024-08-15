import 'package:flutter/material.dart';
import 'package:halal_check/theme/color_constant.dart';

class TapWidget extends StatelessWidget {
  final bool circle;
  final Widget child;
  final EdgeInsets? padding;
  final Color? highlightColor;
  final double? radius, elevation;
  final GestureTapCallback? onTap;
  final Color? color, hoverColor, splashColor, shadowColor;

  const TapWidget({
    super.key,
    this.onTap,
    this.color,
    this.radius,
    this.padding,
    this.elevation,
    this.hoverColor,
    this.splashColor,
    this.shadowColor,
    this.circle = false,
    required this.child,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: _elevation,
      shadowColor: shadowColor,
      color: color ?? Colors.transparent,
      borderRadius: BorderRadius.circular(
        circle ? 50 : radius ?? 0,
      ),
      child: InkWell(
        onTap: onTap,
        hoverColor: hoverColor,
        splashColor: splashColor,
        highlightColor: highlightColor ?? ColorConstantDark.primary.withAlpha(50),
        borderRadius: BorderRadius.circular(
          radius ?? 0,
        ),
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: child,
        ),
      ),
    );
  }

  double get _elevation {
    if (elevation != null) {
      return elevation!;
    } else if (shadowColor != null) {
      return 1;
    } else {
      return 0;
    }
  }
}