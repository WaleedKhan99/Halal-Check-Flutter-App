import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SocialButton extends StatelessWidget {
  final String label;
  final String iconAsset;
  final VoidCallback onTap;

  const SocialButton({
    Key? key,
    required this.label,
    required this.iconAsset,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: 11),
        width: 121.h,
        height: 40.h,
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF263238)
                  .withOpacity(0.2), // Set shadow color and opacity
              blurRadius: 12, // Set the blur radius
              offset: Offset(0, 10), // Set the offset
            ),
          ],
          borderRadius: BorderRadius.circular(72.r), // Set border radius
        ),
        child: Row(
          children: [
            SvgPicture.asset(width: 17, height: 17, iconAsset),
            SizedBox(
                width: 5), // Adding some space between the icon and the label
            Text(
              label,
              style: TextStyle(
                fontFamily: "Euclid Circular A",
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xFF18432D),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
