import 'package:dio/dio.dart';
import 'package:flutter_client_front/common/local_storage/local_storage.dart';
import 'package:flutter_client_front/signup/model/entity/member_entity.dart';
import 'package:flutter_client_front/signup/model/repository/member_repository.dart';
import 'package:flutter_client_front/signup/model/state/member_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final memberServiceProvider =
StateNotifierProvider<MemberService, MemberState>((ref) {
  final memberDataSource = ref.watch(memberRepositoryProvider);
  final storage = ref.watch(localStorageProvider);
  return MemberService(storage, memberDataSource);
});

class MemberService extends StateNotifier<MemberState> {
  final MemberRepository memberRepository;
  final LocalStorage storage;

  MemberService(this.storage, this.memberRepository): super(MemberStateNone());

  Future signup({required MemberEntity memberEntity}) async {
    try{
      state = MemberStateLoading();
      await memberRepository.signup(memberEntity);
      state = MemberStateSuccess("회원가입에 성공했습니다");
    } on DioException catch (e) {
      if (e.response?.data['message']?[0] != null) {
         state = MemberStateError(e.response!.data['message'].toString());
      }
      else{
        if (e.response?.statusCode == 200) {
          state = MemberStateError(e.message ?? "알 수 없는 에러가 발생했습니다.");
        }
        else if (e.response?.statusCode == 400) {
          state = MemberStateError(e.message ?? "계정이 이미 존재합니다.");
        }
        else {
          state = MemberStateError("서버와 연결할 수 없습니다.");
        }
      }
    } catch (e) {
      state = MemberStateError("알 수 없는 에러가 발생했습니다.");
    }
  }
}