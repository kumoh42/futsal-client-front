import 'package:json_annotation/json_annotation.dart';

part 'reservation_setting_entity.g.dart';

@JsonSerializable()
class ReservationSettingEntity {
    ReservationSettingEntity();

    Map<String, dynamic> toJson() => _$ReservationSettingEntityToJson(this);

    factory ReservationSettingEntity.fromJson(Map<String, dynamic> json) =>
        _$ReservationSettingEntityFromJson(json);
}