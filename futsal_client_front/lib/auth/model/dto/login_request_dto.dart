import 'package:json_annotation/json_annotation.dart';

part 'login_request_dto.g.dart';

@JsonSerializable()
class LoginRequestDto {
    @JsonKey(name: "user_id")
    String id;
    @JsonKey(name: "user_password")
    String password;

    LoginRequestDto({required this.id, required this.password});

    Map<String, dynamic> toJson() => _$LoginRequestDtoToJson(this);

    factory LoginRequestDto.fromJson(Map<String, dynamic> json) =>
        _$LoginRequestDtoFromJson(json);
}