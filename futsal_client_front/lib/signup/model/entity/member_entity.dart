import 'package:json_annotation/json_annotation.dart';

part 'member_entity.g.dart';

@JsonSerializable()
class MemberEntity {
    @JsonKey(name: "name")
    final String name;
    @JsonKey(name: "sNumber")
    final int sNumber;
    @JsonKey(name: "phoneNumber")
    final String phoneNumber;
    @JsonKey(name: "circle")
    final int circle;
    @JsonKey(name: "major")
    final int major;
    @JsonKey(name: "id")
    final String id;
    @JsonKey(name: "password")
    final String password;

    MemberEntity({required this.name, required this.sNumber, required this.phoneNumber, required this.circle, required this.id, required this.password, required this.major});

    Map<String, dynamic> toJson() => _$MemberEntityToJson(this);

    factory MemberEntity.fromJson(Map<String, dynamic> json) =>
        _$MemberEntityFromJson(json);
}
