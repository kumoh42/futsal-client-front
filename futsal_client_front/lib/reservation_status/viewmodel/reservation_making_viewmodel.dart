import 'package:flutter/material.dart';
import 'package:flutter_client_front/common/state/state.dart';
import 'package:flutter_client_front/common/utils/snack_bar_util.dart';
import 'package:flutter_client_front/reservation_status/model/entity/reservation_making_entity.dart';
import 'package:flutter_client_front/reservation_status/model/service/reservation_making_service.dart';
import 'package:flutter_client_front/reservation_status/model/state/reservation_making_state.dart';
import 'package:flutter_client_front/reservation_status/viewmodel/reservation_status_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reservationMakingViewModelProvider =
    ChangeNotifierProvider((ref) => ReservationMakingViewModel(ref));

class ReservationMakingViewModel extends ChangeNotifier {
  final Ref ref;
  late ReservationMakingState state;

  ReservationMakingViewModel(this.ref) {
    state = ref.read(reservationMakingServiceProvider);
    ref.listen(reservationMakingServiceProvider, (previous, next) {
      if (previous != next) {
        state = next;
        if (state is ErrorState) {
          SnackBarUtil.showError((state as ErrorState).message);
        } else if (state is SuccessState) {
          SnackBarUtil.showSuccess((state as SuccessState).data.toString());
        }
        notifyListeners();
      }
    });
  }
  Future makeReservation({
    required final String date,
    required final int time,
  }) async {
    await ref.read(reservationMakingServiceProvider.notifier).makeReservation(
          ReservationMakingEntity(date: date, time: time),
        );
    await ref
        .read(reservationStatusViewModelProvider.notifier)
        .getReservationStatusList(force: true);
    notifyListeners();
  }

  Future calcelReservation({
    required final String date,
    required final int time,
  }) async {
    await ref.read(reservationMakingServiceProvider.notifier).calcelReservation(
          ReservationMakingEntity(date: date, time: time),
        );
    await ref
        .read(reservationStatusViewModelProvider.notifier)
        .getReservationStatusList(force: true);
    notifyListeners();
  }
}
