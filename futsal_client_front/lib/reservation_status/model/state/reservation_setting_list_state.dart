import 'package:flutter_client_front/common/state/state.dart';
import 'package:flutter_client_front/reservation_status/model/entity/reservation_setting_entity.dart';

abstract class ReservationSettingListState {}

class ReservationSettingListStateNone extends NoneState
    implements ReservationSettingListState {}

class ReservationSettingListStateLoading extends LoadingState
    implements ReservationSettingListState {}

class ReservationSettingListStateSuccess
    extends SuccessState<List<ReservationSettingEntity>>
    implements ReservationSettingListState {
  ReservationSettingListStateSuccess(super.data);
}

class ReservationSettingListStateError extends ErrorState
    implements ReservationSettingListState {
  ReservationSettingListStateError(super.message);
}
