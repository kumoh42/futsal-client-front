// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberEntity _$MemberEntityFromJson(Map<String, dynamic> json) => MemberEntity(
      name: json['name'] as String,
      sNumber: json['sNumber'] as int,
      phoneNumber: json['phoneNumber'] as String,
      circle: json['circle'] as int,
      id: json['id'] as String,
      password: json['password'] as String,
      major: json['major'] as int,
    );

Map<String, dynamic> _$MemberEntityToJson(MemberEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'sNumber': instance.sNumber,
      'phoneNumber': instance.phoneNumber,
      'circle': instance.circle,
      'major': instance.major,
      'id': instance.id,
      'password': instance.password,
    };
