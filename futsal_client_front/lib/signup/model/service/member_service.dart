import 'package:dio/dio.dart';
import 'package:flutter_client_front/common/local_storage/local_storage.dart';
import 'package:flutter_client_front/signup/model/entity/member_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/member_repository.dart';
import '../state/member_state.dart';

final memberServiceProvider =
    StateNotifierProvider<MemberService, MemberState>((ref) {
  final memberDataSource = ref.watch(memberRepositoryProvider);
  final storage = ref.watch(localStorageProvider);
  return MemberService(memberDataSource, storage);
});

class MemberService extends StateNotifier<MemberState> {
  final MemberRepository memberRepository;
  final LocalStorage storage;

  MemberService(this.memberRepository, this.storage) : super(MemberStateLoading()) {
  }

  Future signup({required String name, required int studentNum, required int phone, required int club, required String id, required String password, required int major}) async {
    //statenotifier의 state를 AuthStateLoading 상태로 변경
    state = MemberStateLoading();
    try {
      print('service');
      await memberRepository.signup(MemberEntity(id: id, password: password,studentNum: studentNum
          , club: club, major: major, name: name, phone: phone));
      } on DioException catch (e) {
      if (e.response?.data['message']?[0] != null) {
        return state = MemberStateError(e.response?.data['message']?[0]);
      }
      if (e.response?.statusCode == 200) {
        return state = MemberStateError(e.message ?? "알 수 없는 에러가 발생했습니다.");
      }
      state = MemberStateError("서버와 연결할 수 없습니다.");
    } catch (e) {
      state = MemberStateError("알 수 없는 에러가 발생했습니다.");
    }
  }
}
