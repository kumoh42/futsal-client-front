// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationStatusEntity _$ReservationStatusEntityFromJson(
        Map<String, dynamic> json) =>
    ReservationStatusEntity(
      reservationId: json['reservation_srl'] as int,
      placeId: json['place_srl'] as int?,
      date: ReservationStatusEntity._dateFromJson(json['date'] as String),
      time: json['time'] as int,
      isAble: json['is_able'] as String,
      isHoliday: json['is_holiday'] as String,
      regDate:
          ReservationStatusEntity._regDateFromJson(json['regdate'] as String),
      circle: json['circle'] as String?,
      major: json['major'] as String?,
    );

Map<String, dynamic> _$ReservationStatusEntityToJson(
        ReservationStatusEntity instance) =>
    <String, dynamic>{
      'reservation_srl': instance.reservationId,
      'place_srl': instance.placeId,
      'date': ReservationStatusEntity._dateToJson(instance.date),
      'time': instance.time,
      'is_able': instance.isAble,
      'is_holiday': instance.isHoliday,
      'regdate': ReservationStatusEntity._regDateToJson(instance.regDate),
      'circle': instance.circle,
      'major': instance.major,
    };
