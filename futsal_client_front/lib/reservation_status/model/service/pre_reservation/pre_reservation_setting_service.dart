import 'package:dio/dio.dart';
import 'package:flutter_client_front/reservation_status/model/entity/block_reservation_entity.dart';
import 'package:flutter_client_front/reservation_status/model/entity/pre_reservation/pre_reservation_status_entity.dart';
import 'package:flutter_client_front/reservation_status/model/entity/pre_reservation/progress_reservation_entity.dart';
import 'package:flutter_client_front/reservation_status/model/repository/pre_resevation/pre_reservation_setting_repository.dart';
import 'package:flutter_client_front/reservation_status/model/state/pre_reservation/pre_reservation_setting_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final preReservationSettingServiceProvider = StateNotifierProvider<
    PreReservationSettingService, PreReservationSettingState>((ref) {
  final reservationRepository =
      ref.watch(preReservationSettingRepositoryProvider);
  return PreReservationSettingService(reservationRepository);
});

class PreReservationSettingService
    extends StateNotifier<PreReservationSettingState> {
  final PreReservationSettingRepository repository;

  PreReservationSettingService(this.repository)
      : super(PreReservationSettingStateNone()) {
    getPreReservation();
  }

  Future setPreReservation(
      {required ProgressReservationEntity progressReservationEntity}) async {
    state = PreReservationSettingStateLoading();
    try {
      await repository.setPreReservation(progressReservationEntity);
      await getPreReservation();
    } on DioException {
      state = PreReservationSettingStateError("서버와의 통신이 끊겼습니다.");
    } catch (e) {
      state = PreReservationSettingStateError("알 수 없는 에러가 발생했습니다.");
    }
  }

  Future getPreReservation() async {
    try {
      state = PreReservationSettingListStateLoading();

      final resp = await repository.getPreReservation();

      state = PreReservationSettingStateSuccess(resp[0]);
    } on DioException {
      state = PreReservationSettingStateError("서버에서 사전예약 정보를 가져올 수 없습니다. ");
    } catch (e) {
      state = PreReservationSettingStateError("알 수 없는 에러가 발생했습니다.");
    }
  }

  Future deletePreReservation(PreReservationStatusEntity entity) async {
    try {
      await repository.deletePreReservation(entity);
    } on DioException {
      state = PreReservationSettingStateError("서버에서 사전예약 정보를 가져올 수 없습니다. ");
    } catch (e) {
      state = PreReservationSettingStateError("알 수 없는 에러가 발생했습니다.");
    }
  }

  Future cancelPreReservation(
      {required PreReservationStatusEntity preReservationStatusEntity}) async {
    try {
      state = PreReservationSettingStateLoading();
      await repository.cancelPreReservation(preReservationStatusEntity);
      await getPreReservation();
    } on DioException {
      state = PreReservationSettingStateError("서버에서 예약 정보를 가져올 수 없습니다. ");
    } catch (e) {
      state = PreReservationSettingStateError("알 수 없는 에러가 발생했습니다.");
    }
  }

  Future blockReservation({required String start, required String end}) async {
    try {
      await repository.blockReservation(
        BlockReservationEntity(endDate: end, startDate: start),
      );
    } on DioException {
      state = PreReservationSettingStateError("서버와 통신이 끊겼습니다.");
    } catch (e) {
      state = PreReservationSettingStateError("알 수 없는 에러가 발생했습니다.");
    }
  }
}
