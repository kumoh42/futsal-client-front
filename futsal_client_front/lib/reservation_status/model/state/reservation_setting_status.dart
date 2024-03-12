import 'package:flutter_client_front/common/state/state.dart';
import 'package:flutter_client_front/reservation_status/type/reservation_setting_type.dart';

abstract class ReservationSettingState {}

class ReservationSettingStateNone extends NoneState
    implements ReservationSettingState {}

class ReservationSettingStateLoading extends LoadingState
    implements ReservationSettingState {}

class ReservationSettingStateSuccess
    extends SuccessState<ReservationSettingType>
    implements ReservationSettingState {
  ReservationSettingStateSuccess(super.data, {super.message});
}

class ReservationSettingStateError extends ErrorState
    implements ReservationSettingState {
  ReservationSettingStateError(super.message);
}
