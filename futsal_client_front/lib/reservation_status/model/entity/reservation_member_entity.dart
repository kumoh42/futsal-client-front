import 'package:json_annotation/json_annotation.dart';

part 'reservation_member_entity.g.dart';

@JsonSerializable()
class ReservationMemberEntity {
  final String id;
  final String name;
  final String phone;
  final String email;

  ReservationMemberEntity({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
  });

  Map<String, dynamic> toJson() => _$ReservationMemberEntityToJson(this);

  factory ReservationMemberEntity.fromJson(Map<String, dynamic> json) =>
      _$ReservationMemberEntityFromJson(json);
}
