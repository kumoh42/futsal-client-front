// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_member_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationMemberEntity _$ReservationMemberEntityFromJson(
        Map<String, dynamic> json) =>
    ReservationMemberEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$ReservationMemberEntityToJson(
        ReservationMemberEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'email': instance.email,
    };
