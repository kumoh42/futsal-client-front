import 'package:flutter_client_front/common/state/state.dart';
import 'package:flutter_client_front/reservation_status/model/entity/pre_reservation/pre_reservation_status_entity.dart';

abstract class PreReservationSettingState {}

class PreReservationSettingStateNone extends NoneState
    implements PreReservationSettingState {}

class PreReservationSettingStateLoading extends LoadingState
    implements PreReservationSettingState {}

class PreReservationSettingStateSuccess
    extends SuccessState<PreReservationStatusEntity>
    implements PreReservationSettingState {
  PreReservationSettingStateSuccess(super.data);
}

class PreReservationSettingStateError extends ErrorState
    implements PreReservationSettingState {
  PreReservationSettingStateError(super.message);
}

class PreReservationSettingListStateLoading extends LoadingState
    implements PreReservationSettingState {}
