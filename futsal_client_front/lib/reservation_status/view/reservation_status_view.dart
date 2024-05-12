import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_client_front/auth/model/state/auth_state.dart';
import 'package:flutter_client_front/auth/view/login_view.dart';
import 'package:flutter_client_front/auth/viewmodel/login_viewmodel.dart';
import 'package:flutter_client_front/common/component/container/responsive_container.dart';
import 'package:flutter_client_front/common/component/container/stack_container.dart';
import 'package:flutter_client_front/common/const/information_const.dart';
import 'package:flutter_client_front/common/styles/colors.dart';
import 'package:flutter_client_front/common/styles/sizes.dart';
import 'package:flutter_client_front/common/styles/text_styles.dart';
import 'package:flutter_client_front/common/utils/date_utils.dart';
import 'package:flutter_client_front/geolocate.dart';
import 'package:flutter_client_front/reservation_status/component/custom_table_calendar.dart';
import 'package:flutter_client_front/reservation_status/component/reservation_state/reservation_state_list.dart';
import 'package:flutter_client_front/reservation_status/model/state/reservation_list_state.dart';
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
                        if (viewmodel.statusState
                            is! ReservationStatusListStateLoading)
                          Tooltip(
                            message: "예약 리스트 새로고침",
                            child: IconButton(
                                iconSize: (kIconLargeSize),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text(
                                        '사용자 위치 확인',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            // 취소 버튼을 눌렀을 때 수행할 작업을 여기에 추가
                                            Navigator.of(context)
                                                .pop(); // AlertDialog를 닫고 false를 반환
                                          },
                                          child: const Text(
                                            '취소',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            // 확인 버튼을 눌렀을 때 수행할 작업을 여기에 추가
                                            Navigator.of(context)
                                                .pop(); // AlertDialog를 닫고 true를 반환
                                          },
                                          child: const Text(
                                            '확인',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ],
                                      content: SizedBox(
                                        width: kIconLargeSize * 20,
                                        height: kIconLargeSize * 20,
                                        child: const MapWithMarkerAndCircle(),
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.refresh_sharp)),
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
              //  if (loginViewModel.state is AuthStateSuccess)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "동아리: SOFT",
                    style: kTextMainStyle.copyWith(
                      fontSize: kTextLargeSize,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "학과: 컴퓨터소프트웨어공학과",
                    style: kTextMainStyle.copyWith(
                      fontSize: kTextLargeSize,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "사용 승인 여부: 승인 O",
                    style: kTextMainStyle.copyWith(
                      fontSize: kTextLargeSize,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              // if (loginViewModel.state is! AuthStateSuccess)
              //   Text.rich(
              //     TextSpan(
              //       text: '풋살장 예약을 하려면 ',
              //       style: kTextMainStyle.copyWith(
              //         fontSize: kTextLargeSize,
              //       ),
              //       children: <TextSpan>[
              //         TextSpan(
              //           text: '로그인',
              //           style: const TextStyle(
              //             color: kMainColor,
              //           ),
              //           recognizer: TapGestureRecognizer()
              //             ..onTap = () {
              //               showDialog(
              //                 context: context,
              //                 builder: (BuildContext context) {
              //                   return const Dialog(
              //                     surfaceTintColor: Colors.transparent,
              //                     backgroundColor: kBackgroundMainColor,
              //                     child: SizedBox(
              //                       width: 500,
              //                       height: 500,
              //                       child: LoginView(),
              //                     ),
              //                   );
              //                 },
              //               );
              //             },
              //         ),
              //         TextSpan(
              //           text: '이 필요합니다!',
              //           style: kTextMainStyle.copyWith(
              //             fontSize: kTextLargeSize,
              //           ),
              //         ),
              //       ],
              //     ),
              //     textAlign: TextAlign.center,
              //   ),
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
