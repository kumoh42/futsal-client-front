import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity {
    @JsonKey(name: "member_srl")
    final int memberSrl;
    @JsonKey(name: "user_id")
    final String userId;
    @JsonKey(name: "user_name")
    final String userName;
    @JsonKey(name: "nick_name")
    final String nickName;

    UserEntity({
        required this.memberSrl,
        required this.userId,
        required this.userName,
        required this.nickName,
    });

    Map<String, dynamic> toJson() => _$UserEntityToJson(this);

    factory UserEntity.fromJson(Map<String, dynamic> json) =>
        _$UserEntityFromJson(json);
}