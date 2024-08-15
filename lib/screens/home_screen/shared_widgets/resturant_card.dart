import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halal_check/theme/component_theme/custom_textstyle_theme.dart';

import '../../../app_constants/icons_constants.dart';
import '../../../theme/color_constant.dart';
import 'resturant_model.dart';

class RestaurantCard extends StatefulWidget {
  final RestaurantModel data;

  const RestaurantCard({
    super.key,
    required this.data,
  });

  @override
  State<RestaurantCard> createState() => _RestaurantCardState();
}

class _RestaurantCardState extends State<RestaurantCard> {
  late ValueNotifier<bool> fav;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fav = ValueNotifier(widget.data.isFav);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.42.sh,
      width: 0.66.sw,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
                  child: Image(image: AssetImage(widget.data.imageUrl))),
              ValueListenableBuilder<bool>(
                  valueListenable: fav,
                  builder: (context, isFav, _) {
                    return Positioned(
                        top: 8,
                        right: 8,
                        child: IconButton(
                          enableFeedback: true,
                          style: IconButton.styleFrom(backgroundColor: Colors.white),
                          icon: SvgPicture.asset(
                            isFav ? IconsConstant.favFilledIcon : IconsConstant.favIcon,
                          ),
                          onPressed: () {
                            HapticFeedback.lightImpact();
                            fav.value = !isFav;
                          },
                        ));
                  })
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0.w,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 6.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          IconsConstant.ratingIcon,
                          height: 30,
                          width: 30,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: widget.data.rating.toStringAsFixed(1),
                                  style: context.textTheme.bodyMedium),
                              TextSpan(
                                  text: ' (${widget.data.rating.toStringAsFixed(1)})',
                                  style: context.textTheme.bodyMedium!
                                      .copyWith(color: ColorConstantLight.grey)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SvgPicture.asset(IconsConstant.mapIcon)
                  ],
                ),
                SizedBox(
                  height: 6.h,
                ),
                Flexible(
                  child: Text(
                    widget.data.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.titleLarge!.copyWith(fontSize: 16.sp, height: 1.1),
                  ),
                ),
                SizedBox(
                  height: 6.h,
                ),
                Flexible(
                  child: Text(
                    widget.data.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodySmall!
                        .copyWith(height: 1.1, fontSize: 14.sp, color: ColorConstantLight.grey),
                  ),
                ),
                SizedBox(
                  height: 6.h,
                ),
                Flexible(
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        IconsConstant.pinIcon,
                        width: 20,
                        height: 20,
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Text(widget.data.location,
                          style: context.textTheme.bodyMedium!
                              .copyWith(color: ColorConstantLight.grey, fontSize: 12.sp)),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
