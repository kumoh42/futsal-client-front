import 'package:dio/dio.dart';
import 'package:flutter_client_front/reservation_status/model/repository/reservation_setting_repository.dart';
import 'package:flutter_client_front/reservation_status/model/state/reservation_setting_status.dart';
import 'package:flutter_client_front/reservation_status/type/reservation_setting_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reservationSettingServiceProvider =
    StateNotifierProvider<ReservationSettingService, ReservationSettingState>(
        (ref) {
  final reservationRepository = ref.watch(reservationSettingRepositoryProvider);
  return ReservationSettingService(reservationRepository);
});

class ReservationSettingService extends StateNotifier<ReservationSettingState> {
  final ReservationSettingRepository repository;

  ReservationSettingService(this.repository)
      : super(ReservationSettingStateNone());

  Future startReservation() async {
    try {
      state = ReservationSettingStateLoading();
      await repository.setPreReservationState("open");
      state = ReservationSettingStateSuccess(
        ReservationSettingType.started,
        message: "사전예약이 오픈되었습니다.",
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        return state = ReservationSettingStateError("이미 사전예약이 진행중입니다.");
      }
      state = ReservationSettingStateError("사전예약 오픈에 실패하였습니다.");
    } catch (e) {
      state = ReservationSettingStateError("알 수 없는 에러가 발생했습니다.");
    }
  }

  Future closeReservation() async {
    try {
      state = ReservationSettingStateLoading();
      await repository.setPreReservationState("close");
      state = ReservationSettingStateSuccess(
        ReservationSettingType.closed,
        message: "사전예약이 중단되고 기존 예약 내역이 모두 삭제되었습니다.",
      );
    } on DioException {
      state = ReservationSettingStateError("사전예약 중단에 실패하였습니다.");
    } catch (e) {
      state = ReservationSettingStateError("알 수 없는 에러가 발생했습니다.");
    }
  }
}
