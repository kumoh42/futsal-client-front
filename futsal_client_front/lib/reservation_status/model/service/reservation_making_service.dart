import 'package:dio/dio.dart';
import 'package:flutter_client_front/reservation_status/model/entity/reservation_making_entity.dart';
import 'package:flutter_client_front/reservation_status/model/repository/reservation_making_repository.dart';
import 'package:flutter_client_front/reservation_status/model/state/reservation_making_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reservationMakingServiceProvider =
    StateNotifierProvider<ReservationMakingService, ReservationMakingState>(
        (ref) {
  final reservationRepository = ref.watch(reservationMakingRepositoryProvider);
  return ReservationMakingService(reservationRepository);
});

class ReservationMakingService extends StateNotifier<ReservationMakingState> {
  final ReservationMakingRepository repository;
  ReservationMakingService(this.repository)
      : super(ReservationMakingStateNone());

  Future<void> makeReservation(ReservationMakingEntity entity) async {
    try {
      state = ReservationMakingStateLoading();
      await repository.makeReservation(entity);
      state = ReservationMakingStateSuccess("예약을 성공했습니다.");
    } on DioException catch (e) {
      if (e.response?.data['message']?[0] != null) {
        state =
            ReservationMakingStateError(e.response!.data['message'].toString());
      } else {
        state = ReservationMakingStateError("예약을 실패했습니다.");
      }
    } catch (e) {
      state = ReservationMakingStateError("알 수 없는 에러가 발생했습니다.");
    }
  }

  Future calcelReservation(ReservationMakingEntity entity) async {
    try {
      state = ReservationMakingStateLoading();
      await repository.cancelReservation(entity);
      state = ReservationMakingStateSuccess("예약을 취소했습니다.");
    } on DioException catch (e) {
      if (e.response?.data['message']?[0] != null) {
        state =
            ReservationMakingStateError(e.response!.data['message'].toString());
      } else {
        state = ReservationMakingStateError("예약 취소를 실패했습니다.");
      }
    } catch (e) {
      state = ReservationMakingStateError("알 수 없는 에러가 발생했습니다.");
    }
  }
}
