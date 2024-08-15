import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewCard extends StatefulWidget {
  final String name;
  final String rating;
  final String rankingnumber;
  final String description;
  final String imageUrl;
  final VoidCallback? onTapRating;

  const ReviewCard({
    Key? key,
    required this.name,
    required this.rating,
    required this.rankingnumber,
    required this.description,
    required this.imageUrl,
    required this.onTapRating,
  }) : super(key: key);

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 195.h,
      width: 352.h,
      decoration: BoxDecoration(
        color: Color(0xFFF2F5FA),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCircularImageWithRating(widget.imageUrl),
                SizedBox(width: 8.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                            fontFamily: "Euclid Circular A",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A1E25),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        RatingBarIndicator(
                          rating: double.parse(widget
                              .rankingnumber), // Assuming rating is a String
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors
                                .yellow, // Set your desired color for rated items
                          ),
                          itemCount: 5,
                          itemSize: 18.0, // Adjust the size as needed
                          unratedColor: Colors.grey
                              .shade300, // Set your desired color for unrated items
                          direction: Axis.horizontal,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          widget.rating,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: "Euclid Circular A",
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 15.h),
            Container(
              child: Text(
                widget.description,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: "Euclid Circular A",
                  fontWeight: FontWeight.w400,
                  fontSize: 13.sp,
                  color: Color(0xFF7D7F88),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularImageWithRating(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(17.w),
      child: Image.asset(
        imageUrl,
        width: 34.w,
        height: 34.h,
        fit: BoxFit.cover,
      ),
    );
  }
}
