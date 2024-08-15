import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ====================== For Heading ======================
class HeadingText extends StatelessWidget {
  final String headingtext;
  const HeadingText({
    super.key,
    required this.headingtext,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      headingtext,
      style: TextStyle(
        fontSize: 16,
        fontFamily: "Euclid Circular A",
        color: Color(0xFF1A1E25),
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

// ====================== For SubHeading ======================
class SubHeadingText extends StatelessWidget {
  final String subheadingtext;
  const SubHeadingText({
    super.key,
    required this.subheadingtext,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      subheadingtext,
      style: TextStyle(
          fontWeight: FontWeight.w400,
          fontFamily: "Euclid Circular A",
          color: Color(0xFF7D7F88),
          fontSize: 12),
    );
  }
}
// ===================== Menu Heading Text =============================

class MenuHeading extends StatelessWidget {
  final String text;

  const MenuHeading({
    Key? key, // Correct usage of key parameter
    required this.text,
  }) : super(key: key); // Pass the key parameter to the super constructor

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.0.w),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: TextStyle(
            fontFamily: "Euclid Circular A",
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade500, // Ensure correct color format
          ),
        ),
      ),
    );
  }
}
// ===========================================================

class LabelText extends StatelessWidget {
  final String labeltext;
  final Color? labelcolor; // Change the type to Color?

  const LabelText({
    Key? key, // Correct super.key to Key? key
    required this.labeltext,
    required this.labelcolor,
  }) : super(
            key: key); // Use super(key: key) to call the superclass constructor

  @override
  Widget build(BuildContext context) {
    return Text(
      labeltext,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontFamily: "Euclid Circular A",
        color: labelcolor, // Use the Color object here
        fontSize: 12,
      ),
    );
  }
}
// ==========================================================================


