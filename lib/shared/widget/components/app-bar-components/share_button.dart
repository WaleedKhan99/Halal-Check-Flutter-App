import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halal_check/app_constants/icons_constants.dart';

class ShareButton extends StatelessWidget {
  final VoidCallback onTap;
  const ShareButton({super.key, required this.onTap});

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
          IconsConstant.share,
          width: 24,
          height: 24,
        ),
      ),
    );
  }
}
