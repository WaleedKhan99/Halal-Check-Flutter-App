import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halal_check/domain/shop_details/model/shop_timing_model.dart';
import 'package:halal_check/screens/screen_layout.dart';
import 'package:halal_check/theme/component_theme/custom_textstyle_theme.dart';

import '../../shared/component/heading_subtitle.dart';
import '../../shared/widget/custom_gradient_button.dart';
import '../../shared/widget/customecheckbox.dart';
import 'widgets/shop_hour_selector.dart';

class ShopTimingScreen extends StatefulWidget {
  static String route = '/shop_timing_screen';
  final ShopTimingModel shopTiming;

  const ShopTimingScreen({super.key, required this.shopTiming});

  @override
  State<ShopTimingScreen> createState() => _ShopTimingScreenState();
}

class _ShopTimingScreenState extends State<ShopTimingScreen> {
  late ShopTimingModel timingModel;
  late ValueNotifier<bool> loader;
  late ValueNotifier<bool> allDaysCheck;
  bool use24HourFormat = false;

  @override
  void initState() {
    super.initState();
    timingModel = widget.shopTiming;
    allDaysCheck = ValueNotifier(timingModel.isOpenAllDay);
    loader = ValueNotifier(false);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      appBarTitle: 'Shop Timing',
      loader: loader,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeaderSubtitle(
              headerText: 'Select Shop opening hours',
              subtitle: 'Select the days and timings of your shop',
            ),
            SizedBox(
              height: 26.h,
            ),
            Row(
              children: [
                ValueListenableBuilder<bool>(
                  valueListenable: allDaysCheck,
                  builder: (context, check, _) {
                    return CustomCheckbox(
                      isChecked: check,
                      onChange: (value) {
                        allDaysCheck.value = value;
                        timingModel.toggleOpenDays(value);
                      },
                    );
                  },
                ),
                Text(
                  'All Day',
                  style: context.textTheme.titleLarge!.copyWith(
                    fontSize: 18,
                  ),
                ),
                const Spacer(),
                Text(
                  '24 Hour format ',
                  style: context.textTheme.bodySmall!.copyWith(
                    fontSize: 14,
                  ),
                ),
                Switch(
                  value: use24HourFormat,
                  onChanged: (value) {
                    setState(() => use24HourFormat = value);
                  },
                ),
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            ValueListenableBuilder<bool>(
              valueListenable: allDaysCheck,
              builder: (context, check, _) {
                return Column(
                  children: [
                    ...List.generate(
                      timingModel.timing.length,
                      (index) {
                        final timePerDay = timingModel.timing[index];
                        return ShopHourSelector(
                          key: GlobalKey(),
                          dayHour: timePerDay,
                          is24HourFormat: use24HourFormat,
                          onChange: (value) {
                            timingModel.timing[index] = value;
                            allDaysCheck.value = timingModel.isOpenAllDay;
                          },
                        );
                      },
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 16.h),
            CustomGradientButton(
              text: 'Save',
              onPressed: () {
                Navigator.pop(context, timingModel);
              },
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}

// ========================================================================
