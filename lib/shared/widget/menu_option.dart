import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../app_constants/icons_constants.dart';

class MenuOption extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;

  const MenuOption({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.0.w),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              width: 40.h,
              height: 40.h,
              decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: Color(0xffE3E3E7)),
                color: Color(0xFFFDFDFD),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xF454545).withOpacity(0.3),
                    spreadRadius: 0.0,
                    blurRadius: 16,
                    offset: Offset(0, 4),
                    blurStyle: BlurStyle.normal,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(10.0.r),
                child: SvgPicture.asset(
                  icon,
                  width: 18,
                  height: 20,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: "Euclid Circular A",
                  color: Color(0xFF1A1E25),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SvgPicture.asset(
              IconsConstant.arrowright,
              width: 20,
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}


// ====================================================================

// class MenuOptionModel {
//   final String title;
//   final String icon;
//   final VoidCallback onTap;

//   MenuOptionModel({
//     required this.title,
//     required this.icon,
//     required this.onTap,
//   });
// }
