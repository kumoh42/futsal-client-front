// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_info_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberInfoEntity _$MemberInfoEntityFromJson(Map<String, dynamic> json) =>
    MemberInfoEntity(
      name: json['userName'] as String,
      sNumber: json['sNumber'] as int,
      phoneNumber: json['phoneNumber'] as String,
      isConfirm: json['is_confirm'] as bool,
      circle: json['circle'] as int,
      major: json['major'] as int,
    );

Map<String, dynamic> _$MemberInfoEntityToJson(MemberInfoEntity instance) =>
    <String, dynamic>{
      'userName': instance.name,
      'circle': instance.circle,
      'major': instance.major,
      'is_confirm': instance.isConfirm,
      'sNumber': instance.sNumber,
      'phoneNumber': instance.phoneNumber,
    };
