import 'package:flutter/material.dart';
import 'package:flutter_client_front/common/component/container/responsive_container.dart';
import 'package:flutter_client_front/common/component/container/stack_container.dart';
import 'package:flutter_client_front/common/component/custom_icon_button.dart';
import 'package:flutter_client_front/common/styles/sizes.dart';
import 'package:flutter_client_front/common/styles/text_styles.dart';
import 'package:flutter_client_front/common/utils/date_utils.dart';
import 'package:flutter_client_front/reservation_status/component/custom_table_calendar.dart';
import 'package:flutter_client_front/reservation_status/component/reservation_state/reservation_state_list.dart';
import 'package:flutter_client_front/reservation_status/viewmodel/reservation_status_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReservationStatusView extends ConsumerWidget {
  const ReservationStatusView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = ref.watch(reservationStatusViewModelProvider);

    return ResponsiveContainer(
      children: [
        ResponsiveWidget(
          wFlex: 7,
          mFlex: 1,
          child: StackContainer(
            child: CustomTimeTable(
              controller: viewmodel.customTimeTableController,
            ),
          ),
        ),
        ResponsiveSizedBox(size: kLayoutGutterSize),
        ResponsiveWidget(
          wFlex: 5,
          mFlex: 1,
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: kPaddingMiddleSize * 3),
                  Expanded(
                    child: Text(
                      '${viewmodel.customTimeTableController.focusedDay.month}월 ${viewmodel.customTimeTableController.focusedDay.day}일 (${getDayOfWeek(viewmodel.customTimeTableController.focusedDay).substring(0, 1)})',
                      style: kTextMainStyle.copyWith(fontSize: kTextLargeSize),
                    ),
                  ),
                  CustomIconButton(
                    icon: Icons.settings,
                    onPressed: () => viewmodel.blockReservation(context),
                    hintMessage: "예약 불가 기간 설정",
                  ),
                  ResponsiveSizedBox(size: kPaddingMiddleSize),
                  CustomIconButton(
                    icon: Icons.delete,
                    onPressed: () => viewmodel.cancelReservationStatus(context),
                    hintMessage: "예약 삭제",
                  ),
                  ResponsiveSizedBox(size: kPaddingMiddleSize),
                ],
              ),
              SizedBox(height: kPaddingLargeSize),
              Expanded(
                child: ReservationStateList(
                  state: viewmodel.statusState,
                  reservationStatusList: viewmodel.reservationStatusList,
                  controller: viewmodel.cancelListController,
                ),
              ),
            ],
          ),
        ),
      ],
    );
    /*Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 7,
            child: StackContainer(
              child: CustomTimeTable(
                  controller: viewmodel.customTimeTableController),
            )),
        SizedBox(width: kLayoutGutterSize),
        Expanded(
          flex: 5,
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: kPaddingMiddleSize * 3),
                  Expanded(
                    child: Text(
                      '${viewmodel.customTimeTableController.focusedDay.month}월 ${viewmodel.customTimeTableController.focusedDay.day}일 (${getDayOfWeek(viewmodel.customTimeTableController.focusedDay).substring(0, 1)})',
                      style: kTextMainStyle.copyWith(fontSize: kTextLargeSize),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings),
                    iconSize: kIconMiddleSize,
                    splashRadius: kIconMiddleSize,
                    onPressed: () {
                      viewmodel.blockReservation(context);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    iconSize: kIconMiddleSize,
                    splashRadius: kIconMiddleSize,
                    onPressed: () {
                      viewmodel.cancelReservationStatus(context);
                    },
                  ),
                  const SizedBox(width: 5.0),
                ],
              ),
              SizedBox(height: kPaddingLargeSize),
              Expanded(
                child: ReservationStateList(
                  state: viewmodel.statusState,
                  reservationStatusList: viewmodel.reservationStatusList,
                  controller: viewmodel.cancelListController,
                ),
              ),
            ],
          ),
        ),
      ],
    );*/
  }
}
