import 'package:flutter_client_front/reservation_status/model/repository/pre_resevation/progress_reservation_repository.dart';
import 'package:flutter_client_front/reservation_status/model/state/pre_reservation/progress_reservation_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

final progressResrvationServiceProvider =
    StateNotifierProvider<ProgressReservationService, ProgressReservationState>(
        (ref) {
  final progressReservationRepository =
      ref.watch(progressReservationRepositoryProvider);
  return ProgressReservationService(progressReservationRepository);
});

class ProgressReservationService
    extends StateNotifier<ProgressReservationState> {
  final ProgressReservationRepository repository;

  ProgressReservationService(this.repository)
      : super(ProgressReservationStateNone()) {
    getProgressReservation();
  }

  Future stopPreReservation() async {
    try {
      await repository.setProgressReservationState("stop");
    } catch (e) {
      state = ProgressReservationStateError("알 수 없는 에러가 발생했습니다");
    }
  }

  Future restartPreReservation() async {
    try {
      await repository.setProgressReservationState("reopen");
      await getProgressReservation();
    } catch (e) {
      state = ProgressReservationStateError("알 수 없는 에러가 발생했습니다");
    }
  }

  Future getProgressReservation() async {
    try {
      state = ProgressReservationStateLoading();

      final data = await repository.getProgressReservation();

      state = ProgressReservationStateSuccess(data);
    } on DioException {
      state = ProgressReservationStateError("서버로부터 진행중인 예약을 가져오지 못했습니다.");
    } catch (e) {
      state = ProgressReservationStateError("알 수 없는 에러가 발생했습니다");
    }
  }

  Future resetPreReservation() async {
    try {
      await repository.setProgressReservationState("reset");
    } catch (e) {
      state = ProgressReservationStateError("예약 삭제를 실패했습니다.");
    }
  }
}
