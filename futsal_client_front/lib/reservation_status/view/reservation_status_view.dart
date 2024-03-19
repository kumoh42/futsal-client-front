import 'package:flutter/material.dart';
import 'package:flutter_client_front/auth/model/state/auth_state.dart';
import 'package:flutter_client_front/auth/viewmodel/login_viewmodel.dart';
import 'package:flutter_client_front/common/component/container/responsive_container.dart';
import 'package:flutter_client_front/common/component/container/stack_container.dart';
import 'package:flutter_client_front/common/styles/colors.dart';
import 'package:flutter_client_front/common/styles/sizes.dart';
import 'package:flutter_client_front/common/styles/text_styles.dart';
import 'package:flutter_client_front/common/utils/date_utils.dart';
import 'package:flutter_client_front/reservation_status/component/custom_table_calendar.dart';
import 'package:flutter_client_front/reservation_status/component/reservation_state/reservation_state_list.dart';
import 'package:flutter_client_front/reservation_status/viewmodel/reservation_status_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReservationStatusView extends ConsumerWidget {
  static String get routeName => 'ReservationStatusView';
  const ReservationStatusView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = ref.watch(reservationStatusViewModelProvider);
    final loginViewModel = ref.watch(loginViewModelProvider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: ResponsiveContainer(
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
                            style: kTextMainStyle.copyWith(
                                fontSize: kTextLargeSize),
                          ),
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
          ),
        ),
        ResponsiveSizedBox(size: kPaddingMiddleSize),
        Container(
          decoration: BoxDecoration(
            color: kBackgroundMainColor,
            border: Border.all(
              color: kBorderColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(kBorderRadiusSize),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (loginViewModel.state is AuthStateSuccess)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "학과: 컴퓨터소프트웨어공학과",
                      style: kTextMainStyle.copyWith(
                        fontSize: kTextLargeSize,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "동아리: SOFT",
                      style: kTextMainStyle.copyWith(
                        fontSize: kTextLargeSize,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "이름: 김정현",
                      style: kTextMainStyle.copyWith(
                        fontSize: kTextLargeSize,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              if (loginViewModel.state is! AuthStateSuccess)
                Text(
                  "풋살장 예약을 하려면 로그인이 필요합니다!",
                  style: kTextMainStyle.copyWith(
                    fontSize: kTextLargeSize,
                  ),
                  textAlign: TextAlign.center,
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
