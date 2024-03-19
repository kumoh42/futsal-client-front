import 'package:flutter/material.dart';
import 'package:flutter_client_front/common/state/state.dart';
import 'package:flutter_client_front/common/utils/date_utils.dart';
import 'package:flutter_client_front/common/utils/snack_bar_util.dart';
import 'package:flutter_client_front/reservation_status/component/custom_table_calendar.dart';
import 'package:flutter_client_front/reservation_status/component/reservation_state/reservation_state_list.dart';
import 'package:flutter_client_front/reservation_status/model/service/reservation_status_service.dart';
import 'package:flutter_client_front/reservation_status/model/state/reservation_list_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reservationStatusViewModelProvider =
    ChangeNotifierProvider((ref) => ReservationStatusViewModel(ref));

class ReservationStatusViewModel extends ChangeNotifier {
  final Ref ref;

  // statusState = reservationStatusServiceProvider
  late ReservationStatusListState statusState;
  late final CustomTimeTableController customTimeTableController;
  late final CustomCancelListController cancelListController;
  late final CustomTimeTableController blockReservationController;

  get reservationStatusList => statusState is ReservationStatusListStateSuccess
      ? (statusState as ReservationStatusListStateSuccess)
          .data
          .where((element) =>
              defaultDateFormat.format(element.date) ==
              defaultDateFormat.format(customTimeTableController.selectedDay))
          .toList()
      : null;

  ReservationStatusViewModel(this.ref) {
    customTimeTableController = CustomTimeTableController(
      onDayChange: getReservationStatusList,
    );
    cancelListController = CustomCancelListController();
    blockReservationController = CustomTimeTableController(
      useRange: true,
      isSelectableBeforeTime: false,
    );

    statusState = ref.read(reservationStatusServiceProvider);

    ref.listen(reservationStatusServiceProvider, (previous, next) {
      if (previous != next) {
        statusState = next;
        if (statusState is ErrorState) {
          SnackBarUtil.showError((statusState as ErrorState).message);
        }
        notifyListeners();
      }
    });
  }

  void getReservationStatusList({bool force = false}) async {
    await ref
        .read(reservationStatusServiceProvider.notifier)
        .getReservationStatusList(
          date: customTimeTableController.selectedDay,
          force: force,
        );
    cancelListController.reset();
    notifyListeners();
  }
}
