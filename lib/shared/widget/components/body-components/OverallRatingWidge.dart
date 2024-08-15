import 'package:flutter/material.dart';

class OverallRatingWidget extends StatelessWidget {
  final String rating;
  final double progressValue;

  const OverallRatingWidget({
    Key? key,
    required this.rating,
    required this.progressValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(rating),
          SizedBox(width: 8),
          Container(
            width: 223,
            child: LinearProgressIndicator(
              value: progressValue,
              minHeight: 12,
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFCC836)),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}
