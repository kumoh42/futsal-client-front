import 'package:json_annotation/json_annotation.dart';

part 'block_reservation_entity.g.dart';

@JsonSerializable()
class BlockReservationEntity {
  String startDate;
  String endDate;
  BlockReservationEntity({required this.startDate, required this.endDate});

  Map<String, dynamic> toJson() => _$BlockReservationEntityToJson(this);
}
