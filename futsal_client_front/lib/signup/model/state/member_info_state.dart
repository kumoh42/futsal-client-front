import 'package:flutter_client_front/common/state/state.dart';
import 'package:flutter_client_front/signup/model/entity/member_info_entity.dart';

abstract class MemberInfoState {}

class MemberInfoStateNone extends NoneState implements MemberInfoState {}

class MemeberInfoStateLoading extends LoadingState implements MemberInfoState {}

class MemberInfoStateSuccess extends SuccessState<MemberInfoEntity>
    implements MemberInfoState {
  MemberInfoStateSuccess(super.data);
}

class MemberInfoStateError extends ErrorState implements MemberInfoState {
  MemberInfoStateError(super.message);
}
