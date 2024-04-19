// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_info_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberInfoEntity _$MemberInfoEntityFromJson(Map<String, dynamic> json) =>
    MemberInfoEntity(
      user_name: json['user_name'] as String,
      user_student_number: json['user_student_number'] as int,
      phone_number: json['phone_number'] as String,
      is_denied: json['is_denied'] as String,
      circle_srl: json['circle_srl'] as int,
      major_srl: json['major_srl'] as int,
      member_srl: json['member_srl'] as int,
    );

Map<String, dynamic> _$MemberInfoEntityToJson(MemberInfoEntity instance) =>
    <String, dynamic>{
      'user_name': instance.user_name,
      'circle_srl': instance.circle_srl,
      'major_srl': instance.major_srl,
      'is_denied': instance.is_denied,
      'user_student_number': instance.user_student_number,
      'phone_number': instance.phone_number,
      'member_srl': instance.member_srl,
    };
