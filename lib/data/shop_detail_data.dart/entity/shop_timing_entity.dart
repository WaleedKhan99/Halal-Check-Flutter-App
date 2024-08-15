import 'package:halal_check/domain/shop_details/model/shop_timing_model.dart';

class ShopTimingEntity {
  final bool is12HourFormat;
  final List<ShopHoursEntity> timing;

  ShopTimingEntity({required this.is12HourFormat, required this.timing});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'is12HourFormat': is12HourFormat,
      'timing': timing.map((x) => x.toMap()).toList(),
    };
  }

  factory ShopTimingEntity.fromModel(ShopTimingModel timingModel) {
    final timingEntity = List.generate(timingModel.timing.length,
        (index) => ShopHoursEntity.fromModel(timingModel.timing[index]));
    return ShopTimingEntity(
        is12HourFormat: timingModel.is12HourFormat, timing: timingEntity);
  }

  factory ShopTimingEntity.fromMap(Map<String, dynamic> map) {
    return ShopTimingEntity(
      is12HourFormat: map['is12HourFormat'] as bool,
      timing: List<ShopHoursEntity>.from(
        (map['timing'] as List<int>).map<ShopHoursEntity>(
          (x) => ShopHoursEntity.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}

class ShopHoursEntity {
  final int id;
  final int openHour;
  final int openMin;
  final int closeHour;
  final int closeMin;
  final bool isOpen;
  const ShopHoursEntity({
    required this.id,
    required this.openHour,
    required this.openMin,
    required this.closeHour,
    required this.closeMin,
    required this.isOpen,
  });

  factory ShopHoursEntity.fromModel(ShopHourModel model) {
    return ShopHoursEntity(
        id: model.id,
        openHour: model.openingTime.hour,
        openMin: model.openingTime.minute,
        closeHour: model.closingTime.hour,
        closeMin: model.closingTime.minute,
        isOpen: model.isOpen);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'openingTime': '$openHour:$openMin',
      'closingTime': '$closeHour:$closeMin',
      'isOpen': isOpen,
    };
  }

  factory ShopHoursEntity.fromMap(Map<String, dynamic> map) {
    final opening = (map['openingTime'] as String).split(':');
    final closing = (map['closingTime'] as String).split(':');

    return ShopHoursEntity(
      id: map['id'] as int,
      openHour: int.tryParse(opening.first) ?? 0,
      openMin: int.tryParse(opening.last) ?? 0,
      closeHour: int.tryParse(closing.first) ?? 0,
      closeMin: int.tryParse(closing.last) ?? 0,
      isOpen: map['isOpen'] as bool,
    );
  }
}
