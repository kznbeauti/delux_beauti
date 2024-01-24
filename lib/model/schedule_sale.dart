import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'schedule_sale.freezed.dart';
part 'schedule_sale.g.dart';

@freezed
class ScheduleSale with _$ScheduleSale {
  factory ScheduleSale({
    required String title,
    required int price,
    required DateTime endTime,
  }) = _ScheduleSale;
  factory ScheduleSale.fromJson(Map<String, dynamic> json) =>
      _$ScheduleSaleFromJson(json);
}
