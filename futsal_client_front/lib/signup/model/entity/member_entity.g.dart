// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberEntity _$MemberEntityFromJson(Map<String, dynamic> json) => MemberEntity(
      name: json['name'] as String,
      studentNum: json['studentNum'] as int,
      phone: json['phone'] as int,
      club: json['club'] as int,
      id: json['id'] as String,
      password: json['password'] as String,
      major: json['major'] as int,
    );

Map<String, dynamic> _$MemberEntityToJson(MemberEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'studentNum': instance.studentNum,
      'phone': instance.phone,
      'club': instance.club,
      'id': instance.id,
      'password': instance.password,
      'major': instance.major,
    };
