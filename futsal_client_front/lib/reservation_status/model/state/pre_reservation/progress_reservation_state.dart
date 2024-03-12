import 'package:flutter_client_front/common/state/state.dart';
import 'package:flutter_client_front/reservation_status/model/entity/pre_reservation/progress_reservation_entity.dart';

abstract class ProgressReservationState {}

class ProgressReservationStateNone extends NoneState
    implements ProgressReservationState {}

class ProgressReservationStateLoading extends LoadingState
    implements ProgressReservationState {}

class ProgressReservationStateSuccess
    extends SuccessState<ProgressReservationEntity>
    implements ProgressReservationState {
  ProgressReservationStateSuccess(super.data, {super.message});
}

class ProgressReservationStateError extends ErrorState
    implements ProgressReservationState {
  ProgressReservationStateError(super.message);
}
