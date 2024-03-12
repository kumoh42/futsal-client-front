import 'package:flutter_client_front/auth/model/entity/user_entity.dart';
import 'package:flutter_client_front/common/state/state.dart';

abstract class AuthState {}

class AuthStateNone extends NoneState implements AuthState {}

class AuthStateLoading extends LoadingState implements AuthState {}

class AuthStateSuccess extends SuccessState<UserEntity> implements AuthState {
  AuthStateSuccess(super.data);
}

class AuthStateError extends ErrorState implements AuthState {
  AuthStateError(super.message);
}
