import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halal_check/theme/component_theme/custom_textstyle_theme.dart';

import '../../../domain/shop_details/model/shop_timing_model.dart';
import '../../../shared/widget/custom_textform_field.dart';

class ShopTimingsBottomSheet extends StatefulWidget {
  final ShopTimingModel shopTiming;

  const ShopTimingsBottomSheet({super.key, required this.shopTiming});

  @override
  State<ShopTimingsBottomSheet> createState() => _ShopTimingsBottomSheetState();
}

class _ShopTimingsBottomSheetState extends State<ShopTimingsBottomSheet> {
  final ValueNotifier<bool> _is24HourFormat = ValueNotifier(false);
  late InputDescriptor openTime, closeTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    openTime = InputDescriptor(
      label: 'Open Time',
    );
    closeTime = InputDescriptor(
      label: 'Close Time',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Row(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     const Spacer(),
        //     Text(
        //       '24 Hour format ',
        //       style: context.textTheme.bodySmall!.copyWith(
        //         fontSize: 14,
        //       ),
        //     ),
        //     ValueListenableBuilder(
        //       valueListenable: _is24HourFormat,
        //       builder: (context, is24HourFormat, _) {
        //         return Switch(
        //           value: is24HourFormat,
        //           onChanged: (value) => _is24HourFormat.value = value,
        //         );
        //       },
        //     ),
        //     20.width,
        //   ],
        // ),
        Text(
          'Shop Timing',
          style: context.textTheme.titleLarge,
        ),
        SizedBox(
          height: 0.6.sh,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.shopTiming.timing.length,
            itemBuilder: (context, i) => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.shopTiming.timing[i].day,
                  style: context.textTheme.titleLarge!.copyWith(
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                ValueListenableBuilder(
                  valueListenable: _is24HourFormat,
                  builder: (context, is24HourFormat, _) {
                    return Row(
                      children: [
                        Flexible(
                          child: CustomTextField(
                            enabled: false,
                            readOnly: true,
                            descriptor: openTime,
                            initialValue: widget.shopTiming.timing[i].getFormatTime(
                              widget.shopTiming.timing[i].openingTime,
                              is24HourFormat,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Flexible(
                          child: CustomTextField(
                            enabled: false,
                            readOnly: true,
                            descriptor: closeTime,
                            initialValue: widget.shopTiming.timing[i].getFormatTime(
                              widget.shopTiming.timing[i].closingTime,
                              is24HourFormat,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 0.3.sw,
                        )
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
