import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomIconButton extends StatelessWidget {
  final String icon;
  final VoidCallback onTap;
  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      style: IconButton.styleFrom(
          side: const BorderSide(color: Color(0xffE3E3E7)),
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
      onPressed: onTap,
      icon: CircleAvatar(
        radius: 22.r,
        backgroundColor: Colors.transparent,
        child: SvgPicture.asset(
          icon,
          width: 24,
          height: 24,
        ),
      ),
    );
  }
}
