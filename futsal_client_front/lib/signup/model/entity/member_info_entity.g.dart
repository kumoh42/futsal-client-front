// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_info_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberInfoEntity _$MemberInfoEntityFromJson(Map<String, dynamic> json) =>
    MemberInfoEntity(
      name: json['name'] as String,
      sNumber: json['sNumber'] as int,
      phoneNumber: json['phoneNumber'] as String,
    );

Map<String, dynamic> _$MemberInfoEntityToJson(MemberInfoEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'sNumber': instance.sNumber,
      'phoneNumber': instance.phoneNumber,
    };
