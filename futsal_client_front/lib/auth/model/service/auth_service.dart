import 'package:dio/dio.dart';
import 'package:flutter_client_front/auth/model/dto/login_request_dto.dart';
import 'package:flutter_client_front/auth/model/repository/auth_repository.dart';
import 'package:flutter_client_front/auth/model/state/auth_state.dart';
import 'package:flutter_client_front/common/env/env.dart';
import 'package:flutter_client_front/common/local_storage/local_storage.dart';
import 'package:flutter_client_front/signup/model/entity/member_info_entity.dart';
import 'package:flutter_client_front/signup/model/repository/member_info_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider =
    StateNotifierProvider<AuthService, AuthState>((ref) {
  final authDataSource = ref.watch(authRepositoryProvider);
  final storage = ref.watch(localStorageProvider);
  final memberInfoRepo = ref.watch(memberInfoRepositoryProvider);
  return AuthService(authDataSource, storage, memberInfoRepo);
});

class AuthService extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  final MemberInfoRepository memberInfoRepository;
  final LocalStorage storage;

  AuthService(this.authRepository, this.storage, this.memberInfoRepository)
      : super(AuthStateLoading()) {
    _getUserInfo();
  }

  Future login({required String id, required String password}) async {
    //statenotifier의 state를 AuthStateLoading 상태로 변경
    state = AuthStateLoading();
    try {
      await authRepository.login(LoginRequestDto(id: id, password: password));
      await _getUserInfo();
    } on DioException catch (e) {
      if (e.response?.data['message']?[0] != null) {
        return state = AuthStateError(e.response?.data['message']?[0]);
      }
      if (e.response?.statusCode == 400) {
        return state = AuthStateError("id 또는 password가 틀렸습니다.");
      }
      if (e.response?.statusCode == 200) {
        return state = AuthStateError(e.message ?? "알 수 없는 에러가 발생했습니다.");
      }
      state = AuthStateError("서버와 연결할 수 없습니다.");
    } catch (e) {
      state = AuthStateError("알 수 없는 에러가 발생했습니다.");
    }
  }

  Future logout() async {
    state = AuthStateLoading();
    await _removeToken();
    state = AuthStateNone();
  }

  Future _getUserInfo() async {
    final accessToken = await storage.read(key: Env.ACCESS_TOKEN_KEY);
    final refreshToken = await storage.read(
      key: Env.REFRESH_TOKEN_KEY,
    );

    if (accessToken == null || refreshToken == null) {
      state = AuthStateNone();
      return;
    }

    try {
      //  final data = await memberInfoRepository.getMemberInfo();
      state = AuthStateSuccess(
        MemberInfoEntity(
          name: "zzz",
          phoneNumber: "010-8411-6111",
          sNumber: 20200284,
          isConfirm: false,
          circle: 15,
          major: 27,
        ),
      );
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 400) {
        state = AuthStateError(
            e.response!.data["message"][0] ?? "알 수 없는 에러가 발생했습니다.");
      }
      state = AuthStateError("사용자 정보를 가져올 수 없습니다.");
    } catch (e) {
      state = AuthStateError("알 수 없는 에러가 발생했습니다.");
    }
  }

  Future _removeToken() async {
    Future.wait([
      storage.delete(key: Env.ACCESS_TOKEN_KEY),
      storage.delete(key: Env.REFRESH_TOKEN_KEY),
    ]);
  }
}
