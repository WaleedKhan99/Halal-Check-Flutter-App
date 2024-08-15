import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../app_constants/icons_constants.dart';

class CustomListCard extends StatefulWidget {
  final String imageUrl;
  final String rating;
  final String reviews;
  final String title;
  final String description;
  final String location;
  final VoidCallback? onRatingTap;
  final VoidCallback? onMapTap;

  const CustomListCard({
    Key? key,
    required this.imageUrl,
    required this.rating,
    required this.reviews,
    required this.title,
    required this.description,
    required this.location,
    required this.onRatingTap,
    required this.onMapTap,
  }) : super(key: key);

  @override
  State<CustomListCard> createState() => _CustomListCardState();
}

class _CustomListCardState extends State<CustomListCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 357.w,
      height: 160.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 121.w,
            height: 160.h,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              child: Image.asset(
                widget.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16,
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: widget.onRatingTap,
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                IconsConstant.ratingIcon,
                                height: 12.h,
                                width: 12.h,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                widget.rating,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: "Euclid Circular A",
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                widget.reviews,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: "Euclid Circular A",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 122.w),
                        GestureDetector(
                          onTap: widget.onMapTap,
                          child: SvgPicture.asset(
                            IconsConstant.mapIcon,
                            height: 24.h,
                            width: 24.w,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 18.h),
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontFamily: "Euclid Circular A",
                      fontSize: 20.sp,
                      color: Color(0xFF1A1E25),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    widget.description,
                    style: TextStyle(
                      fontFamily: "Euclid Circular A",
                      fontSize: 16.sp,
                      color: Color(0xFF7D7F88),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 18.h),
                  Row(
                    children: [
                      SvgPicture.asset(
                        IconsConstant.pinIcon,
                        width: 14.w,
                        height: 14.h,
                      ),
                      SizedBox(width: 7.w),
                      Text(
                        widget.location,
                        style: TextStyle(
                          fontFamily: "Euclid Circular A",
                          fontSize: 13.sp,
                          color: Color(0xFF7D7F88),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
