import '../../../common/state/state.dart';
import '../entity/member_entity.dart';

abstract class MemberState {}

class MemberStateNone extends NoneState implements MemberState {}

class MemberStateLoading extends LoadingState implements MemberState {}

class MemberStateSuccess extends SuccessState<MemberEntity> implements MemberState {
  MemberStateSuccess(super.data);
}

class MemberStateError extends ErrorState implements MemberState {
  MemberStateError(super.message);
}
