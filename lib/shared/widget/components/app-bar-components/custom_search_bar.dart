import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../app_constants/icons_constants.dart';
import '../../custom_textform_field.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      descriptor: InputDescriptor(hint: 'New York, New York'),
      prefixIcon: Padding(
        padding: const EdgeInsets.all(13.0),
        child: SvgPicture.asset(
          IconsConstant.search,
        ),
      ),
      suffixIcon: Padding(
        padding: const EdgeInsets.all(6.0),
        child: SvgPicture.asset(
          IconsConstant.setting,
        ),
      ),
      fillColor: Colors.white,
    );
  }
}
