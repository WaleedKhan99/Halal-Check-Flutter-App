import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension AppNavigation on BuildContext {
  push (Widget screen) {
    Navigator.push(
      this,
      MaterialPageRoute(
        builder: (context) {
          return screen;
        },
      ),
    );
  }
}

extension NullAndEmptyCheck on List? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  // bool get isNotNullOrEmpty => this != null || this!.isNotEmpty;
  bool get isNotNullOrEmpty => this?.isNotEmpty ?? false;
}

/// returning SizedBox with coming dimension
extension IntToSizedBox on int {
  Widget get height => SizedBox(height: toDouble().h);
  Widget get width => SizedBox(width: toDouble().w);
}