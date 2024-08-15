import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halal_check/shared/component/heading_subtitle.dart';

class BottomsheetLayout extends StatelessWidget {
  final String? title, subtitle;
  final Widget child;

  const BottomsheetLayout({
    super.key,
    required this.title,
    required this.child,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 1.sw,
        maxHeight: 0.7.sh,
      ),
      child: Padding(
        // padding: const EdgeInsets.symmetric(horizontal: 6.0),
        padding: const EdgeInsets.only(
          left: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            HeaderSubtitle(
              headerText: title,
              subtitle: subtitle,
              alignment: CrossAxisAlignment.center,
            ),
            child,
          ],
        ),
      ),
    );
  }
}
