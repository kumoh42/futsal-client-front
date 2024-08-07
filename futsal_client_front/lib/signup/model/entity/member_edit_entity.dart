import 'package:json_annotation/json_annotation.dart';

part 'member_edit_entity.g.dart';

@JsonSerializable()
class MemberEditEntity {
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "sNumber")
  final int sNumber;
  @JsonKey(name: "phoneNumber")
  final String phoneNumber;

  MemberEditEntity({
    required this.name,
    required this.phoneNumber,
    required this.sNumber,
  });
  factory MemberEditEntity.fromJson(Map<String, dynamic> json) =>
      _$MemberEditEntityFromJson(json);
  Map<String, dynamic> toJson() => _$MemberEditEntityToJson(this);
}
