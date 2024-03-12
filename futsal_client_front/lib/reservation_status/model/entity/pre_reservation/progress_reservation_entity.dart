import 'package:json_annotation/json_annotation.dart';

part 'progress_reservation_entity.g.dart';

@JsonSerializable()
class ProgressReservationEntity {
  String date;
  String time;
  bool isPre;
  ProgressReservationEntity(
      {required this.isPre, required this.date, required this.time});

  Map<String, dynamic> toJson() => _$ProgressReservationEntityToJson(this);

  factory ProgressReservationEntity.fromJson(Map<String, dynamic> json) =>
      _$ProgressReservationEntityFromJson(json);
}
