import 'package:json_annotation/json_annotation.dart';

part 'reservation_cancel_entity.g.dart';

@JsonSerializable()
class ReservationCancelEntity {
  @JsonKey(name: "date")
  String date;
  @JsonKey(name: "times")
  List<int> times;
  @JsonKey(name: "isPre")
  bool isPre;
  ReservationCancelEntity(
      {required this.date, required this.isPre, required this.times});
  Map<String, dynamic> toJson() => _$ReservationCancelEntityToJson(this);
}
