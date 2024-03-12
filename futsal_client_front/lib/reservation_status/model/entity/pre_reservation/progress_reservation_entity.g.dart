// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_reservation_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProgressReservationEntity _$ProgressReservationEntityFromJson(
        Map<String, dynamic> json) =>
    ProgressReservationEntity(
      isPre: json['isPre'] as bool,
      date: json['date'] as String,
      time: json['time'] as String,
    );

Map<String, dynamic> _$ProgressReservationEntityToJson(
        ProgressReservationEntity instance) =>
    <String, dynamic>{
      'date': instance.date,
      'time': instance.time,
      'isPre': instance.isPre,
    };
