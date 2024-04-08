import 'package:json_annotation/json_annotation.dart';

part 'member_info_entity.g.dart';

@JsonSerializable()
class MemberInfoEntity {
  @JsonKey(name: "userName")
  final String name;
  @JsonKey(name: "circle")
  final int circle;
  @JsonKey(name: "major")
  final int major;
  @JsonKey(name: "is_confirm")
  final bool isConfirm;
  @JsonKey(name: "sNumber")
  final int sNumber;
  @JsonKey(name: "phoneNumber")
  final String phoneNumber;

  MemberInfoEntity({
    required this.name,
    required this.sNumber,
    required this.phoneNumber,
    required this.isConfirm,
    required this.circle,
    required this.major,
  });

  Map<String, dynamic> toJson() => _$MemberInfoEntityToJson(this);

  factory MemberInfoEntity.fromJson(Map<String, dynamic> json) =>
      _$MemberInfoEntityFromJson(json);
}
