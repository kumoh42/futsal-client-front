// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'block_reservation_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlockReservationEntity _$BlockReservationEntityFromJson(
        Map<String, dynamic> json) =>
    BlockReservationEntity(
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
    );

Map<String, dynamic> _$BlockReservationEntityToJson(
        BlockReservationEntity instance) =>
    <String, dynamic>{
      'startDate': instance.startDate,
      'endDate': instance.endDate,
    };
