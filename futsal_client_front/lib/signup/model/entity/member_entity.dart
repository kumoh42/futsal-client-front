import 'package:json_annotation/json_annotation.dart';

part 'member_entity.g.dart';

@JsonSerializable()
class MemberEntity {
    final String name;
    final int studentNum;
    final int phone;
    final int club;
    final String id;
    final String password;
    final int major;

    MemberEntity({required this.name, required this.studentNum, required this.phone, required this.club, required this.id, required this.password, required this.major});

    Map<String, dynamic> toJson() => _$MemberEntityToJson(this);

    factory MemberEntity.fromJson(Map<String, dynamic> json) =>
        _$MemberEntityFromJson(json);
}

// //{
// "이름": "김현진",
// "학번": 12024345,
// ”전화번호”: 01039333333,
// ”동아리”: “코스트” or “개인”,
// ”id”: “test”,
// ”password”: “kim123@”
// }