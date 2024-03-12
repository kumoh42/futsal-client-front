// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_cancel_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationCancelEntity _$ReservationCancelEntityFromJson(
        Map<String, dynamic> json) =>
    ReservationCancelEntity(
      date: json['date'] as String,
      isPre: json['isPre'] as bool,
      times: (json['times'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$ReservationCancelEntityToJson(
        ReservationCancelEntity instance) =>
    <String, dynamic>{
      'date': instance.date,
      'times': instance.times,
      'isPre': instance.isPre,
    };
