// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_making_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationMakingEntity _$ReservationMakingEntityFromJson(
        Map<String, dynamic> json) =>
    ReservationMakingEntity(
      date: json['date'] as String,
      times: json['times'] as int,
    );

Map<String, dynamic> _$ReservationMakingEntityToJson(
        ReservationMakingEntity instance) =>
    <String, dynamic>{
      'date': instance.date,
      'times': instance.times,
    };
