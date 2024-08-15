import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halal_check/theme/component_theme/custom_textstyle_theme.dart';

class BottomSheetButton extends StatelessWidget {
  final String icon;
  final String title;
  final Function() onTap;
  const BottomSheetButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(1000),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!, width: 2),
                borderRadius: BorderRadius.circular(1000),
              ),
              child: SvgPicture.asset(
                icon,
                height: 60,
                width: 60,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            title,
            style: context.textTheme.titleLarge!.copyWith(fontSize: 14),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
