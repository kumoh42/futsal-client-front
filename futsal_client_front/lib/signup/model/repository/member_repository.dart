import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_client_front/signup/model/entity/member_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';

import 'package:flutter_client_front/common/dio/dio.dart';

part 'member_repository.g.dart';

final memberRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
     return MemberRepository(dio);
});

@RestApi()
abstract class MemberRepository {
  factory MemberRepository(Dio dio, {String baseUrl}) = _MemberRepository;

  @POST('/user')
  Future<void> signup(
      @Body() MemberEntity memberEntity
      );

}