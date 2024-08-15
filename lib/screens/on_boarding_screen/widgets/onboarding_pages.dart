import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halal_check/theme/color_constant.dart';
import 'package:halal_check/theme/component_theme/custom_textstyle_theme.dart';
import '../on_boarding_screen.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingModel data;
  const OnboardingPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 30.h,
        ),
        Image.asset(
          data.image,
          fit: BoxFit.cover,
          height: 0.6.sh,
          width: 0.8.sw,
        ),
        const Spacer(),
        Text(
          data.title,
          style: context.textTheme.titleLarge,
        ),
        SizedBox(
          height: 20.h,
        ),
        Text(
          data.subTitle,
          style: context.textTheme.bodyMedium!
              .copyWith(color: ColorConstantLight.grey),
          textAlign: TextAlign.center,
        ),
        const Spacer(),
      ],
    );
  }
}
