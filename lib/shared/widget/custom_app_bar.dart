import 'package:flutter/material.dart';
import 'package:halal_check/theme/color_constant.dart';
import 'package:halal_check/theme/component_theme/custom_textstyle_theme.dart';
import '../../app_constants/icons_constants.dart';
import 'custom_icon_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: Stack(
        children: [
          Positioned(
            top: -110,
            left: 10,
            child: CircleAvatar(
              radius: 100,
              backgroundColor: ColorConstantDark.primary.withOpacity(0.5),
            ),
          ),
          Positioned(
            top: -70,
            left: -80,
            child: CircleAvatar(
              radius: 100,
              backgroundColor: ColorConstantDark.primary.withOpacity(0.5),
            ),
          ),
          Positioned(
              left: 20,
              bottom: 20,
              child: CustomIconButton(
                icon: IconsConstant.backarrow,
                onTap: () {
                  Navigator.pop(context);
                },
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(title, style: context.textTheme.titleLarge),
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size(90, 90);
}
