import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_client_front/common/dio/dio.dart';
import 'package:flutter_client_front/signup/model/entity/member_edit_entity.dart';
import 'package:flutter_client_front/signup/model/entity/member_info_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'member_info_repository.g.dart';

final memberInfoRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return MemberInfoRepository(dio);
});

@RestApi()
abstract class MemberInfoRepository {
  factory MemberInfoRepository(Dio dio, {String baseUrl}) =
      _MemberInfoRepository;
  @GET('/user')
  @Headers({'accessToken': 'true'})
  Future<MemberInfoEntity> getMemberInfo();
  @PATCH('/user')
  @Headers({'accessToken': 'true'})
  Future editMemberInfo(@Body() MemberEditEntity entity);
}
