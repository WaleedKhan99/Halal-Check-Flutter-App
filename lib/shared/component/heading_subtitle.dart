import 'package:flutter/material.dart';
import 'package:halal_check/theme/component_theme/custom_textstyle_theme.dart';

class HeaderSubtitle extends StatelessWidget {
  final String? headerText, subtitle;
  final CrossAxisAlignment alignment;
  const HeaderSubtitle(
      {super.key,
      this.headerText,
      required this.subtitle,
      this.alignment = CrossAxisAlignment.start});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        if (headerText != null)
          Text(headerText!, style: context.textTheme.titleLarge),
        if (subtitle != null) ...[
          const SizedBox(
            height: 8,
          ),
          Text(subtitle!, style: context.textTheme.displaySmall),
        ]
      ],
    );
  }
}
