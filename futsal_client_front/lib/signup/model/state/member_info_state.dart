import 'package:flutter_client_front/common/state/state.dart';

abstract class MemberInfoState {}

class MemberInfoStateNone extends NoneState implements MemberInfoState {}

class MemeberInfoStateLoading extends LoadingState implements MemberInfoState {}

class MemberInfoStateSuccess extends SuccessState implements MemberInfoState {
  MemberInfoStateSuccess(super.data);
}

class MemberInfoStateError extends ErrorState implements MemberInfoState {
  MemberInfoStateError(super.message);
}
