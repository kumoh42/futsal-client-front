import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_client_front/signup/model/entity/member_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';

import '../../../common/dio/dio.dart';

part 'member_repository.g.dart';

final memberRepositoryProvider = Provider((ref) {
  print('repository');
  final dio = ref.watch(dioProvider);
     return MemberRepository(dio);
});

@RestApi()
abstract class MemberRepository {
  factory MemberRepository(Dio dio, {String baseUrl}) = _MemberRepository;

  @POST('/signup')
  Future signup(@Body() MemberEntity memberEntity);

}


//repository랑 riverpod강의 듣기