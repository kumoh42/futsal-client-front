import 'package:json_annotation/json_annotation.dart';

part 'reservation_making_entity.g.dart';

@JsonSerializable()
class ReservationMakingEntity {
  @JsonKey(name: "date")
  final String date;
  @JsonKey(name: "time")
  final int time;
  ReservationMakingEntity({
    required this.date,
    required this.time,
  });
  factory ReservationMakingEntity.fromJson(Map<String, dynamic> json) =>
      _$ReservationMakingEntityFromJson(json);
  Map<String, dynamic> toJson() => _$ReservationMakingEntityToJson(this);
}
