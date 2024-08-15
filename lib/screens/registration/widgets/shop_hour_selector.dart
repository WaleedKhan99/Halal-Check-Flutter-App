import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halal_check/shared/widget/custom_textform_field.dart';
import 'package:halal_check/shared/widget/customecheckbox.dart';
import 'package:halal_check/theme/component_theme/custom_textstyle_theme.dart';
import 'package:time_range_picker/time_range_picker.dart';

import '../../../domain/shop_details/model/shop_timing_model.dart';

class ShopHourSelector extends StatefulWidget {
  final Function(ShopHourModel) onChange;
  final ShopHourModel dayHour;
  final bool is24HourFormat;

  const ShopHourSelector({
    super.key,
    required this.dayHour,
    required this.onChange,
    required this.is24HourFormat,
  });

  @override
  State<ShopHourSelector> createState() => _ShopHourSelectorState();
}

class _ShopHourSelectorState extends State<ShopHourSelector> {
  late InputDescriptor openTime, closeTime;
  late ShopHourModel shopTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    shopTime = widget.dayHour;

    openTime = InputDescriptor(
        label: 'Open Time',
        initialValue: shopTime.getFormatTime(shopTime.openingTime, widget.is24HourFormat));
    closeTime = InputDescriptor(
        label: 'Close Time',
        initialValue: shopTime.getFormatTime(shopTime.closingTime, widget.is24HourFormat));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    openTime.dispose();
    closeTime.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CustomCheckbox(
              isChecked: shopTime.isOpen,
              onChange: (value) {
                setState(() {
                  shopTime = shopTime.copyWith(isOpen: value);
                  widget.onChange(shopTime);
                });
              },
            ),
            Text(
              widget.dayHour.day,
              style: context.textTheme.titleLarge!.copyWith(fontSize: 18),
            )
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        InkWell(
          onTap: shopTime.isOpen ? _changeTime : null,
          child: Row(
            children: [
              Flexible(
                child: CustomTextField(
                  descriptor: openTime,
                  readOnly: true,
                  enabled: false,
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Flexible(
                child: CustomTextField(
                  descriptor: closeTime,
                  readOnly: true,
                  enabled: false,
                ),
              ),
              SizedBox(
                width: 0.3.sw,
              )
            ],
          ),
        )
      ],
    );
  }

  _changeTime() async {
    final response = await showTimeRangePicker(
        context: context,
        use24HourFormat: widget.is24HourFormat,
        start: shopTime.openingTime,
        fromText: 'Open From',
        toText: 'Close At',
        end: shopTime.closingTime) as TimeRange?;

    if (response != null) {
      shopTime = shopTime.copyWith(openingTime: response.startTime, closingTime: response.endTime);

      openTime.controller.text =
          shopTime.getFormatTime(shopTime.openingTime, widget.is24HourFormat);
      closeTime.controller.text =
          shopTime.getFormatTime(shopTime.closingTime, widget.is24HourFormat);
      widget.onChange(shopTime);
    }
  }
}
