// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => UserEntity(
      memberSrl: json['member_srl'] as int,
      userId: json['user_id'] as String,
      userName: json['user_name'] as String,
      nickName: json['nick_name'] as String,
    );

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'member_srl': instance.memberSrl,
      'user_id': instance.userId,
      'user_name': instance.userName,
      'nick_name': instance.nickName,
    };
