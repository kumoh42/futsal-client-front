import 'package:flutter_client_front/common/state/state.dart';
import 'package:flutter_client_front/signup/model/entity/member_info_entity.dart';

abstract class AuthState {}

class AuthStateNone extends NoneState implements AuthState {}

class AuthStateLoading extends LoadingState implements AuthState {}

class AuthStateSuccess extends SuccessState<MemberInfoEntity>
    implements AuthState {
  AuthStateSuccess(super.data);
}

class AuthStateError extends ErrorState implements AuthState {
  AuthStateError(super.message);
}
