import 'package:flutter/material.dart';
import 'package:flutter_client_front/common/state/state.dart';
import 'package:flutter_client_front/common/utils/date_utils.dart';
import 'package:flutter_client_front/common/utils/snack_bar_util.dart';
import 'package:flutter_client_front/reservation_status/component/custom_table_calendar.dart';
import 'package:flutter_client_front/reservation_status/component/dialog/calendar_select_dialog.dart';
import 'package:flutter_client_front/reservation_status/component/reservation_cancel_dialog.dart';
import 'package:flutter_client_front/reservation_status/component/reservation_state/reservation_state_list.dart';
import 'package:flutter_client_front/reservation_status/model/entity/reservation_entity.dart';
import 'package:flutter_client_front/reservation_status/model/service/pre_reservation/pre_reservation_setting_service.dart';
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

  void blockReservation(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => CalendarSelectDialog(
        onPressed: (controller, startTime, endTime) async {
          final startDate = controller.startDay == null
              ? defaultDateFormat.format(controller.selectedDay)
              : controller.startDay.toString().split(" ")[0];
          final endDate = controller.endDay == null
              ? startDate
              : controller.endDay.toString().split(" ")[0];
          if (startDate == endDate) {
            if (startTime.substring(0, 2).compareTo(endTime.substring(0, 2)) >=
                0) {
              SnackBarUtil.showError("시작 시간이 종료 시간보다 빨라야 합니다.");
              return;
            }
          }
          DateTime dateTimeNow = DateTime.now();
          String now = defaultDateFormat.format(dateTimeNow);
          if (now.compareTo(startDate) > 0 || now.compareTo(endDate) > 0) {
            SnackBarUtil.showError("이미 지난 기간은 기간 설정이 불가능합니다.");
            return;
          }
          if (statusState is ReservationStatusListStateNone) {
            SnackBarUtil.showError("해당 기간에 예약이 열려있지 않습니다.");
            return;
          }

          await ref
              .read(preReservationSettingServiceProvider.notifier)
              .blockReservation(
                start: '${startDate}T${startTime.substring(0, 2)}',
                end: '${endDate}T${endTime.substring(0, 2)}',
              );
          getReservationStatusList(force: true);
          if (context.mounted) Navigator.of(context).pop();
        },
        controller: blockReservationController,
        endTimes: const [
          "10시",
          "12시",
          "14시",
          "16시",
          "18시",
          "20시",
          "22시",
        ],
        startTimes: const [
          "08시",
          "10시",
          "12시",
          "14시",
          "16시",
          "18시",
          "20시",
        ],
        title: "예약 불가 기간 설정",
      ),
    );
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

  void cancelReservationStatus(
    BuildContext context,
  ) async {
    final List<ReservationStatusEntity> cancelList = [];

    for (int entityId in cancelListController.cancelIdList) {
      for (ReservationStatusEntity entity in reservationStatusList) {
        if (entity.reservationId == entityId) {
          cancelList.add(entity);
        }
      }
    }
    if (cancelList.isEmpty) return;

    await showDialog(
      context: context,
      builder: (context) => ReservationCancelDialog(
        entities: cancelList,
        onPressed: (e) => ref
            .read(reservationStatusServiceProvider.notifier)
            .cancelReservation(entities: cancelList),
      ),
    );

    cancelListController.reset();
  }
}
