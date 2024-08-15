import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 02,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.grey.shade200, // Light grey on the left
            Colors.grey.shade200, // Slightly darker grey in the middle
            Colors.grey.shade200, // Light grey on the right
          ],
        ),
      ),
    );
  }
}
