// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:halal_check/app_constants/icons_constants.dart';
// import 'package:halal_check/shared/widget/custom_text.dart';

// import 'OverallRatingWidge.dart';
// // Assuming this is the correct import for OverallRatingWidget

// class ReviewsOverallRating extends StatefulWidget {
//   const ReviewsOverallRating({
//     super.key,
//   });
//   @override
//   State<ReviewsOverallRating> createState() => _ReviewsOverallRatingState();
// }

// class _ReviewsOverallRatingState extends State<ReviewsOverallRating> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Column(
//                 children: [
//                   OverallRatingWidget(rating: "4", progressValue: 0.8),
//                   OverallRatingWidget(rating: "3", progressValue: 0.6),
//                   OverallRatingWidget(rating: "2", progressValue: 0.4),
//                   OverallRatingWidget(rating: "1", progressValue: 0.2),
//                 ],
//               ),
//               SizedBox(width: 22),
//               Column(
//                 children: [
//                   Row(
//                     children: [
//                       Text(
//                         "4.0",
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontFamily: "Euclid Circular A",
//                             fontSize: 44),
//                       ),
//                       SizedBox(width: 8),
//                       SvgPicture.asset(
//                           width: 16, height: 16, IconsConstant.ratingIcon)
//                     ],
//                   ),
//                   LabelText(labeltext: "273 Reviews", labelcolor: Colors.black),
//                   SizedBox(height: 20),
//                   Text(
//                     "88%",
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontFamily: "Euclid Circular A",
//                         fontSize: 44),
//                   ),
//                   LabelText(labeltext: "Recommended", labelcolor: Colors.black),
//                 ],
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// // // ======================== Converted to dynamic ========================

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:halal_check/app_constants/icons_constants.dart';
import 'package:halal_check/shared/widget/custom_text.dart';

import 'OverallRatingWidge.dart';
// Assuming this is the correct import for OverallRatingWidget

class ReviewsOverallRating extends StatelessWidget {
  final List<Map<String, dynamic>> ratingsData;

  const ReviewsOverallRating({
    Key? key,
    required this.ratingsData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: ratingsData.map((data) {
                  return OverallRatingWidget(
                    rating: data['rating'].toString(),
                    progressValue: data['progressValue'] as double,
                  );
                }).toList(),
              ),
              SizedBox(width: 22),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        _calculateAverageRating().toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Euclid Circular A",
                          fontSize: 44,
                        ),
                      ),
                      SizedBox(width: 8),
                      SvgPicture.asset(
                        IconsConstant.ratingIcon,
                        width: 16,
                        height: 16,
                      ),
                    ],
                  ),
                  LabelText(
                    labeltext: "${_totalReviews()} Reviews",
                    labelcolor: Colors.black,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "${_calculateRecommendedPercentage()}%",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Euclid Circular A",
                      fontSize: 40,
                    ),
                  ),
                  LabelText(
                    labeltext: "Recommended",
                    labelcolor: Colors.black,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  double _calculateAverageRating() {
    double totalRating = 0;
    for (var ratingData in ratingsData) {
      // totalRating += ratingData['rating'] as double;
      totalRating += (ratingData['rating'] as num).toDouble();
    }
    return totalRating / ratingsData.length;
  }

  int _totalReviews() {
    return ratingsData.length;
  }

  double _calculateRecommendedPercentage() {
    int totalRecommended = 0;
    for (var ratingData in ratingsData) {
      if (ratingData['progressValue'] >= 0.5) {
        totalRecommended++;
      }
    }
    return (totalRecommended / ratingsData.length) * 100;
  }
}
