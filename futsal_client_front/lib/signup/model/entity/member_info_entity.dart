import 'package:json_annotation/json_annotation.dart';

part 'member_info_entity.g.dart';

@JsonSerializable()
class MemberInfoEntity {
  @JsonKey(name: "user_name")
  final String user_name;
  @JsonKey(name: "circle_srl")
  final int circle_srl;
  @JsonKey(name: "major_srl")
  final int major_srl;
  @JsonKey(name: "is_denied")
  final String is_denied;
  @JsonKey(name: "user_student_number")
  final int user_student_number;
  @JsonKey(name: "phone_number")
  final String phone_number;
  @JsonKey(name: "member_srl")
  final int member_srl;

  MemberInfoEntity({
    required this.user_name,
    required this.user_student_number,
    required this.phone_number,
    required this.is_denied,
    required this.circle_srl,
    required this.major_srl,
    required this.member_srl,
  });

  Map<String, dynamic> toJson() => _$MemberInfoEntityToJson(this);
  factory MemberInfoEntity.fromJson(Map<String, dynamic> json) =>
      _$MemberInfoEntityFromJson(json);
}
