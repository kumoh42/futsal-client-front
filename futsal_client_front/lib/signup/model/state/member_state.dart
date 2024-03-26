import 'package:flutter_client_front/common/state/state.dart';

abstract class MemberState {}

class MemberStateNone extends NoneState implements MemberState {}

class MemberStateLoading extends LoadingState implements MemberState {}

class MemberStateSuccess extends SuccessState implements MemberState {
  MemberStateSuccess(super.message);
}

class MemberStateError extends ErrorState implements MemberState {
  MemberStateError(super.message);
}