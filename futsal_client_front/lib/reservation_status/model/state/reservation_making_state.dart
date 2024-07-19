import 'package:flutter_client_front/common/state/state.dart';

abstract class ReservationMakingState {}

class ReservationMakingStateNone extends NoneState
    implements ReservationMakingState {}

class ReservationMakingStateLoading extends LoadingState
    implements ReservationMakingState {}

class ReservationMakingStateSuccess extends SuccessState
    implements ReservationMakingState {
  ReservationMakingStateSuccess(super.data);
}

class ReservationMakingStateError extends ErrorState
    implements ReservationMakingState {
  ReservationMakingStateError(super.message);
}
