// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_edit_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemeberEditEntity _$MemeberEditEntityFromJson(Map<String, dynamic> json) =>
    MemeberEditEntity(
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      sNumber: json['sNumber'] as int,
    );

Map<String, dynamic> _$MemberEditEntityToJson(MemeberEditEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'sNumber': instance.sNumber,
      'phoneNumber': instance.phoneNumber,
    };
