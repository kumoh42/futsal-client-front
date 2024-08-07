import 'package:flutter/material.dart';
import 'package:flutter_client_front/auth/model/state/auth_state.dart';
import 'package:flutter_client_front/auth/view/login_view.dart';
import 'package:flutter_client_front/auth/viewmodel/login_viewmodel.dart';
import 'package:flutter_client_front/common/styles/colors.dart';
import 'package:flutter_client_front/common/styles/sizes.dart';
import 'package:flutter_client_front/common/styles/text_styles.dart';
import 'package:flutter_client_front/common/utils/date_utils.dart';
import 'package:flutter_client_front/common/utils/snack_bar_util.dart';
import 'package:flutter_client_front/reservation_status/component/designed_button.dart';
import 'package:flutter_client_front/reservation_status/component/reservation_state/reservation_state_item_2.dart';
import 'package:flutter_client_front/reservation_status/model/entity/reservation_entity.dart';
import 'package:flutter_client_front/reservation_status/model/state/reservation_list_state.dart';
import 'package:flutter_client_front/reservation_status/model/state/reservation_making_state.dart';
import 'package:flutter_client_front/reservation_status/type/reservation_type.dart';
import 'package:flutter_client_front/reservation_status/viewmodel/reservation_making_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReservationStateList extends ConsumerStatefulWidget {
  final ReservationStatusListState state;
  final List<ReservationStatusEntity>? reservationStatusList;
  late final ChangeNotifierProvider<CustomCancelListController> provider;

  ReservationStateList({
    Key? key,
    required this.state,
    required this.reservationStatusList,
    required CustomCancelListController controller,
  }) : super(key: key) {
    provider = ChangeNotifierProvider((ref) => controller);
  }

  @override
  ConsumerState<ReservationStateList> createState() =>
      _ReservationStateListState();
}

class _ReservationStateListState extends ConsumerState<ReservationStateList> {
  late CustomCancelListController controller;
  @override
  Widget build(BuildContext context) {
    controller = ref.watch(widget.provider);
    final viewmodel = ref.watch(loginViewModelProvider);
    final reservationViewModel = ref.watch(reservationMakingViewModelProvider);
    switch (widget.state.runtimeType) {
      case ReservationStatusListStateNone:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: const AssetImage("assets/image/black_logo.png"),
                width: kIconLargeSize * 5,
                height: kIconLargeSize * 5,
              ),
              Text(
                "아직 예약이 오픈되지 않았습니다.",
                style: kTextMainStyle.copyWith(fontSize: kTextLargeSize),
              ),
              SizedBox(height: kPaddingMiddleSize),
            ],
          ),
        );
      case ReservationStatusListStateLoading:
        return const Center(child: CircularProgressIndicator());
      case ReservationStatusListStateSuccess:
        return Column(
          children: widget.reservationStatusList!
              .asMap()
              .entries
              .map(
                (e) => Expanded(
                  child: Stack(
                    children: [
                      if (widget.reservationStatusList!.length - 1 != e.key)
                        Positioned(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: kPaddingLargeSize +
                                  (kIconMiddleSize - kBorderWidth) / 2,
                            ),
                            child: Container(
                              color: kMainColor,
                              width: kBorderWidth,
                            ),
                          ),
                        ),
                      Column(
                        children: [
                          Expanded(
                            child: ReservationStateItem2(
                              index: e.key,
                              entity: e.value,
                              isChecked:
                                  controller.isChecked(e.value.reservationId),
                              onPressed: () {
                                if (ReservationType.fromEntity(e.value) ==
                                        ReservationType.able &&
                                    viewmodel.state is AuthStateSuccess) {
                                  if ((viewmodel.state as AuthStateSuccess)
                                          .data
                                          .is_denied ==
                                      "Y") {
                                    SnackBarUtil.showError(
                                      "사용 승인이 되지 않았습니다!",
                                      textStyle: kTextReverseStyle.copyWith(
                                        fontSize: kTextMiddleSize,
                                      ),
                                    );
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          actions: [
                                            if (reservationViewModel.state
                                                is ReservationMakingStateLoading)
                                              const CircularProgressIndicator(),
                                            if (reservationViewModel.state
                                                is! ReservationMakingStateLoading)
                                              DesignedButton(
                                                color: kPointColor,
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                icon: Icons.close,
                                                text: "취소",
                                              ),
                                            if (reservationViewModel.state
                                                is! ReservationMakingStateLoading)
                                              DesignedButton(
                                                onPressed: () async {
                                                  if ((viewmodel.state
                                                      is AuthStateSuccess)) {
                                                    Navigator.of(context).pop();
                                                    await reservationViewModel
                                                        .makeReservation(
                                                      date: regDateFormat
                                                          .format(e.value.date),
                                                      time: e.value.time,
                                                    );

                                                    // SnackBarUtil.showSuccess("예약을 성공했습니다.");
                                                  }
                                                },
                                                icon: Icons.check,
                                                text: "확인",
                                              ),
                                          ],
                                          title: Text(
                                            "예약 확인",
                                            style: kTextMainStyle.copyWith(
                                              fontSize: kTextSmallSize,
                                            ),
                                          ),
                                          content: Padding(
                                            padding: EdgeInsets.only(
                                              top: kPaddingLargeSize,
                                            ),
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: Text(
                                                "예약 날짜: ${regDateFormatK.format(e.value.date)} ${e.value.time.toString().padLeft(2, "0")}시~${(e.value.time + 2).toString().padLeft(2, "0")}시\n정말 예약 하시겠습니까?",
                                                style: kTextMainStyle.copyWith(
                                                  fontSize: kTextMiddleSize + 1,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                }
                                if (ReservationType.fromEntity(e.value) ==
                                        ReservationType.able &&
                                    viewmodel.state is! AuthStateSuccess) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const Dialog(
                                        surfaceTintColor: Colors.transparent,
                                        backgroundColor: kBackgroundMainColor,
                                        child: SizedBox(
                                          width: 500,
                                          height: 500,
                                          child: LoginView(),
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                              onCancelPressed: () async {
                                if ((viewmodel.state is AuthStateSuccess)) {
                                  Navigator.of(context).pop();

                                  await reservationViewModel.calcelReservation(
                                    date: regDateFormat.format(e.value.date),
                                    time: e.value.time,
                                  );
                                  SnackBarUtil.showSuccess("예약을 취소했습니다.");
                                }
                              },
                              isLast:
                                  widget.reservationStatusList!.length - 1 ==
                                      e.key,
                            ),
                          ),
                          SizedBox(height: kPaddingLargeSize),
                        ],
                      )
                    ],
                  ),
                ),
              )
              .toList(),
        );
      case ReservationStatusListStateError:
        return Container();
    }
    return Container();
  }
}

class CustomCancelListController extends ChangeNotifier {
  late final List<int> _cancelIdList;

  CustomCancelListController() {
    _cancelIdList = [];
  }

  List<int> get cancelIdList => _cancelIdList;

  void clickedCheckBox(int id) {
    if (isChecked(id)) {
      _cancelIdList.remove(id);
    } else {
      _cancelIdList.add(id);
      _cancelIdList.sort();
    }
    notifyListeners();
  }

  void reset() {
    _cancelIdList.clear();
    notifyListeners();
  }

  bool isChecked(int id) {
    return _cancelIdList.contains(id);
  }
}
