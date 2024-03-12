// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pre_reservation_status_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreReservationStatusEntity _$PreReservationStatusEntityFromJson(
        Map<String, dynamic> json) =>
    PreReservationStatusEntity(
      date: json['date'] as String,
      time: json['time'] as String,
      isPre: json['isPre'] as bool,
    );

Map<String, dynamic> _$PreReservationStatusEntityToJson(
        PreReservationStatusEntity instance) =>
    <String, dynamic>{
      'date': instance.date,
      'time': instance.time,
      'isPre': instance.isPre,
    };
