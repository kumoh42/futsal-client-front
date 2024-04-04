import 'package:json_annotation/json_annotation.dart';

part 'member_info_entity.g.dart';

@JsonSerializable()
class MemberInfoEntity {
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "sNumber")
  final int sNumber;
  @JsonKey(name: "phoneNumber")
  final String phoneNumber;

  MemberInfoEntity({
    required this.name,
    required this.sNumber,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() => _$MemberInfoEntityToJson(this);

  factory MemberInfoEntity.fromJson(Map<String, dynamic> json) =>
      _$MemberInfoEntityFromJson(json);
}
