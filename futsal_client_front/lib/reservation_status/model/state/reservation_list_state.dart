import 'package:flutter_client_front/common/state/state.dart';
import 'package:flutter_client_front/reservation_status/model/entity/reservation_entity.dart';

abstract class ReservationStatusListState {}

class ReservationStatusListStateNone extends NoneState
    implements ReservationStatusListState {}

class ReservationStatusListStateLoading extends LoadingState
    implements ReservationStatusListState {}

class ReservationStatusListStateSuccess
    extends SuccessState<List<ReservationStatusEntity>>
    implements ReservationStatusListState {
  ReservationStatusListStateSuccess(super.data);
}

class ReservationStatusListStateError extends ErrorState
    implements ReservationStatusListState {
  ReservationStatusListStateError(super.message);
}
