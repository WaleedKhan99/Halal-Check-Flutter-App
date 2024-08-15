// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/shop_detail_data.dart/entity/shop_timing_entity.dart';

class ShopTimingModel {
  final bool is12HourFormat;
  final List<ShopHourModel> timing;

  const ShopTimingModel({required this.is12HourFormat, required this.timing});

  ShopTimingEntity get getEntity => ShopTimingEntity.fromModel(this);

  factory ShopTimingModel.initializeTiming() {
    final timing = List.generate(7, (index) {
      return ShopHourModel.fromTiming(
        id: index + 1,
        isOpen: index > 4 ? false : true,
        open: const TimeOfDay(hour: 10, minute: 0),
        close: const TimeOfDay(hour: 18, minute: 0),
      );
    });
    return ShopTimingModel(is12HourFormat: true, timing: timing);
  }

  toggleOpenDays(bool value) {
    List.generate(timing.length, (index) {
      timing[index] = timing[index].copyWith(isOpen: value);
    });
  }

  bool get isOpenAllDay =>
      !List.generate(timing.length, (index) => timing[index].isOpen)
          .contains(false);

  factory ShopTimingModel.fromEntity(ShopTimingEntity entity) {
    final List<ShopHourModel> timing =
        List.generate(entity.timing.length, (index) {
      return ShopHourModel.fromEntity(entity.timing[index]);
    });
    return ShopTimingModel(
        is12HourFormat: entity.is12HourFormat, timing: timing);
  }
}

class ShopHourModel extends Equatable {
  final int id;
  final String day;
  final TimeOfDay openingTime;
  final TimeOfDay closingTime;
  final bool isOpen;

  const ShopHourModel({
    required this.id,
    required this.day,
    required this.openingTime,
    required this.closingTime,
    required this.isOpen,
  });

  factory ShopHourModel.fromTiming({
    required int id,
    required TimeOfDay open,
    required TimeOfDay close,
    bool isOpen = true,
  }) {
    return ShopHourModel(
        id: id,
        day: getDay(id),
        openingTime: open,
        closingTime: close,
        isOpen: isOpen);
  }

  factory ShopHourModel.fromEntity(ShopHoursEntity entity) {
    return ShopHourModel.fromTiming(
        id: entity.id,
        isOpen: entity.isOpen,
        open: TimeOfDay(
          hour: entity.openHour,
          minute: entity.openMin,
        ),
        close: TimeOfDay(
          hour: entity.closeHour,
          minute: entity.closeMin,
        ));
  }

  static String getDay(int id) {
    final days = {
      1: 'Monday',
      2: 'Tuesday',
      3: 'Wednesday',
      4: 'Thursday',
      5: 'Friday',
      6: 'Saturday',
      7: 'Sunday'
    };

    return days[id]!;
  }

  getFormatTime(TimeOfDay time, bool is24HourFormat) {
    return DateFormat(is24HourFormat ? 'HH:mm' : 'hh:mm a')
        .format(DateTime(2001, 1, 1, time.hour, time.minute));
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id];

  ShopHourModel copyWith({
    int? id,
    String? day,
    TimeOfDay? openingTime,
    TimeOfDay? closingTime,
    bool? isOpen,
  }) {
    return ShopHourModel(
      id: id ?? this.id,
      day: day ?? this.day,
      openingTime: openingTime ?? this.openingTime,
      closingTime: closingTime ?? this.closingTime,
      isOpen: isOpen ?? this.isOpen,
    );
  }
}
