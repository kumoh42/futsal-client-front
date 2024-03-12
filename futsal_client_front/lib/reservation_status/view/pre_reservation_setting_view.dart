import 'package:flutter/material.dart';
import 'package:flutter_client_front/common/component/container/designed_container.dart';
import 'package:flutter_client_front/common/component/container/responsive_container.dart';
import 'package:flutter_client_front/common/component/custom_icon_button.dart';
import 'package:flutter_client_front/common/styles/colors.dart';
import 'package:flutter_client_front/common/styles/sizes.dart';
import 'package:flutter_client_front/common/styles/text_styles.dart';
import 'package:flutter_client_front/common/utils/date_utils.dart';
import 'package:flutter_client_front/reservation_status/component/designed_button.dart';
import 'package:flutter_client_front/reservation_status/component/titled_text.dart';
import 'package:flutter_client_front/reservation_status/viewmodel/pre_reservation_viewmodel/pre_reservation_setting_viewmodel.dart';
import 'package:flutter_client_front/reservation_status/viewmodel/pre_reservation_viewmodel/progress_reservation_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PreReservationSettingView extends ConsumerStatefulWidget {
  const PreReservationSettingView({super.key});

  @override
  ConsumerState<PreReservationSettingView> createState() =>
      _PreReservationSettingViewState();
}

class _PreReservationSettingViewState
    extends ConsumerState<PreReservationSettingView> {
  @override
  void initState() {
    super.initState();
    // UI가 빌드된 후 실행
    Future(() {
      ref
          .read(preReservationSettingViewModelProvider)
          .getPreReservationStatus();
      ref.read(progressReservationViewModelProvider).getProgressReservation();
    });
  }

  String toFirstDay(String? date) {
    if (date == null) return '-';
    DateTime dateTime = regDateMonthFormat.parse(date);
    DateTime result = DateTime(dateTime.year, dateTime.month, 1);
    return "${regDateFormatK.format(result)} 00:00";
  }

  String toCurrentDay(String? date, String? time) =>
      date == null || time == null
          ? '-'
          : "${regDateFormatK.format(regDateFormat.parse(date))} $time:00";

  String toNextMonth(String? date) {
    if (date == null) return '-';
    DateTime dateTime = regDateMonthFormat.parse(date);
    DateTime result = DateTime(dateTime.year, dateTime.month + 1, 1);
    return "${regDateFormatK.format(result)} 00:00";
  }

  @override
  Widget build(BuildContext context) {
    final preViewmodel = ref.watch(preReservationSettingViewModelProvider);
    final progressViewmodel = ref.watch(progressReservationViewModelProvider);

    return ResponsiveContainer(
      children: [
        ResponsiveWidget(
          wFlex: 7,
          child: DesignedContainer(
            title: "진행중인 예약",
            actions: [
              CustomIconButton(
                icon: Icons.refresh,
                onPressed: progressViewmodel.getProgressReservation,
                hintMessage: "진행중인 예약 새로고침",
              ),
            ],
            child: Column(
              children: [
                TitledText(
                  title: '정식 예약',
                  text: progressViewmodel.progressReservationStatus != null &&
                          !progressViewmodel.progressReservationStatus!.isPre
                      ? '${toFirstDay(progressViewmodel.progressReservationStatus?.date)} ~ ${toNextMonth(progressViewmodel.progressReservationStatus?.date)}'
                      : '-',
                ),
                SizedBox(height: kPaddingMiddleSize),
                TitledText(
                  title: '사전 예약',
                  text: progressViewmodel.progressReservationStatus != null &&
                          progressViewmodel.progressReservationStatus!.isPre
                      ? '${toCurrentDay(progressViewmodel.progressReservationStatus?.date, progressViewmodel.progressReservationStatus?.time)} ~ ${toNextMonth(progressViewmodel.progressReservationStatus?.date)}'
                      : '-',
                ),
                SizedBox(height: kPaddingMiddleSize),
                Row(
                  children: [
                    DesignedButton(
                      icon: Icons.pause,
                      text: "예약 중단",
                      onPressed: () =>
                          progressViewmodel.stopPreReservation(context),
                    ),
                    SizedBox(width: kPaddingMiddleSize),
                    DesignedButton(
                      icon: Icons.play_arrow,
                      text: "예약 재개",
                      onPressed: () =>
                          progressViewmodel.restartPreReservation(context),
                    ),
                    SizedBox(width: kPaddingMiddleSize),
                    DesignedButton(
                      icon: Icons.refresh,
                      text: "예약 내역 초기화",
                      color: kPointColor,
                      onPressed: () =>
                          progressViewmodel.resetPreReservation(context),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        ResponsiveSizedBox(size: kLayoutGutterSize),
        ResponsiveWidget(
          wFlex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DesignedContainer(
                title: "사전 예약 설정 현황",
                actions: [
                  CustomIconButton(
                    icon: Icons.delete_forever,
                    onPressed: () => preViewmodel.cancelPreReservation(context),
                    hintMessage: "사전 예약 설정을 취소",
                  ),
                  const SizedBox(width: kWPaddingMiddleSize),
                  CustomIconButton(
                    icon: Icons.refresh,
                    onPressed: preViewmodel.getPreReservationStatus,
                    hintMessage: "사전 예약 설정 새로고침",
                  ),
                  const SizedBox(width: kWPaddingMiddleSize),
                  CustomIconButton(
                    icon: Icons.edit,
                    onPressed: () => preViewmodel.setPreReservation(context),
                    hintMessage: "사전 예약 설정",
                  ),
                ],
                child: Column(
                  children: [
                    TitledText(
                      title: '시작 일시',
                      text: toCurrentDay(
                        preViewmodel.preReservationStatus?.date,
                        preViewmodel.preReservationStatus?.time,
                      ),
                    ),
                    SizedBox(height: kPaddingMiddleSize),
                    TitledText(
                      title: '종료 일시',
                      text:
                          toNextMonth(preViewmodel.preReservationStatus?.date),
                    ),
                  ],
                ),
              ),
              SizedBox(height: kPaddingLargeSize),
              Text(
                " ·  사전 예약은 하나만 설정 가능 합니다.",
                style: kTextMainStyle.copyWith(fontSize: kTextSmallSize),
              ),
              Text(
                " ·  정식 예약은 매월 1일 00시에 자동으로 시작됩니다.",
                style: kTextMainStyle.copyWith(fontSize: kTextSmallSize),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
