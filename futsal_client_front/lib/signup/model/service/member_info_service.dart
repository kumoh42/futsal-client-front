import 'package:dio/dio.dart';
import 'package:flutter_client_front/signup/model/entity/member_edit_entity.dart';
import 'package:flutter_client_front/signup/model/repository/member_info_repository.dart';
import 'package:flutter_client_front/signup/model/state/member_info_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final memberInfoServiceProvider =
    StateNotifierProvider<MemberInfoService, MemberInfoState>((ref) {
  final repository = ref.watch(memberInfoRepositoryProvider);
  return MemberInfoService(repository);
});

class MemberInfoService extends StateNotifier<MemberInfoState> {
  final MemberInfoRepository repository;
  MemberInfoService(this.repository) : super(MemberInfoStateNone());
  Future getMemberInfo() async {
    try {
      state = MemeberInfoStateLoading();
      final result = await repository.getMemberInfo();
      state = MemberInfoStateSuccess(result);
    } on DioException {
      state = MemberInfoStateError("서버에서 정보를 가져올 수 없습니다.");
    } catch (e) {
      state = MemberInfoStateError("알 수 없는 에러가 발생했습니다.");
    }
  }

  Future editMemberInfo(MemberEditEntity entity) async {
    try {
      state = MemeberInfoStateLoading();
      await repository.editMemberInfo(entity);
      state = MemberInfoStateSuccess("정보를 수정하였습니다.");
    } on DioException {
      state = MemberInfoStateError("서버에서 정보를 가져올 수 없습니다.");
    } catch (e) {
      state = MemberInfoStateError("알 수 없는 에러가 발생했습니다.");
    }
  }
}
