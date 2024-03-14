import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_client_front/auth/model/dto/login_request_dto.dart';
import 'package:flutter_client_front/auth/model/entity/user_entity.dart';
import 'package:flutter_client_front/common/dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_repository.g.dart';

final authRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return AuthRepository(dio);
});

@RestApi()
abstract class AuthRepository {
  factory AuthRepository(Dio dio, {String baseUrl}) = _AuthRepository;

  @POST('/auth')
  Future login(@Body() LoginRequestDto loginRequestDto);

  @GET('/user')
  @Headers({'accessToken': 'true'})
  Future<UserEntity> getUserInfo();
}
