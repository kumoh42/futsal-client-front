import 'package:flutter/material.dart';
import 'package:flutter_client_front/common/styles/sizes.dart';
import 'package:flutter_client_front/common/styles/text_styles.dart';
import 'package:flutter_client_front/common/state/state.dart';
import 'package:flutter_client_front/common/utils/custom_dialog_utils.dart';
import 'package:flutter_client_front/common/utils/snack_bar_util.dart';
import 'package:flutter_client_front/reservation_status/model/entity/pre_reservation/progress_reservation_entity.dart';
import 'package:flutter_client_front/reservation_status/model/service/pre_reservation/progress_reservation_service.dart';
import 'package:flutter_client_front/reservation_status/model/state/pre_reservation/progress_reservation_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final progressReservationViewModelProvider =
    ChangeNotifierProvider((ref) => ProgressReservationViewModel(ref));

class ProgressReservationViewModel extends ChangeNotifier {
  final Ref ref;
  late ProgressReservationState state;

  ProgressReservationViewModel(this.ref) {
    state = ref.watch(progressResrvationServiceProvider);
  }

  ProgressReservationEntity? get progressReservationStatus =>
      state is SuccessState
          ? (state as ProgressReservationStateSuccess).data
          : null;

  void getProgressReservation() async {
    await ref
        .read(progressResrvationServiceProvider.notifier)
        .getProgressReservation();
  }

  void stopPreReservation(BuildContext context) async {
    if (state is! ProgressReservationStateSuccess) return;
    if (!(state as ProgressReservationStateSuccess).data.isPre) {
      SnackBarUtil.showError("정규예약은 중단할 수 없습니다!");
      return;
    }

    CustomDialogUtil.showCustomDialog(
        dialog: CustomDialog(
          title: Text(
            "사전예약 중단 확인",
            style: kTextMainStyle.copyWith(fontSize: kTextMiddleSize),
          ),
          content: Text(
            '${(state as ProgressReservationStateSuccess).data.date} ${(state as ProgressReservationStateSuccess).data.time}시\n예약을 중지하시겠습니까?',
            style: kTextNormalStyle.copyWith(fontSize: kTextLargeSize),
          ),
          onPressed: () async {
            await ref
                .read(progressResrvationServiceProvider.notifier)
                .stopPreReservation();

            SnackBarUtil.showSuccess("예약을 중단하였습니다!");

            if (context.mounted) Navigator.of(context).pop();
          },
        ),
        context: context);
  }

  void restartPreReservation(BuildContext context) async {
    if (state is ProgressReservationStateSuccess) {
      if (!(state as ProgressReservationStateSuccess).data.isPre) {
        SnackBarUtil.showError("정규예약은 재개 할 수 없습니다!");
        return;
      }
    }
    await ref
        .read(progressResrvationServiceProvider.notifier)
        .restartPreReservation();

    // CustomDialogUtil.showCustomDialog(
    //     dialog: CustomDialog(
    //       title: Text(
    //         "사전예약 재개 확인",
    //         style: kTextMainStyle.copyWith(fontSize: kTextMiddleSize),
    //       ),
    //       content: Text(
    //         '${(state as ProgressReservationStateSuccess).data.date} ${(state as ProgressReservationStateSuccess).data.time}\n예약을 재개하시겠습니까?',
    //         style: kTextNormalStyle.copyWith(fontSize: kTextLargeSize),
    //       ),
    //       onPressed: () async {
    //         await ref
    //             .read(progressResrvationServiceProvider.notifier)
    //             .restartPreReservation();

    //         SnackBarUtil.showSuccess("예약을 재개하였습니다!");

    //         if (context.mounted) Navigator.of(context).pop();
    //       },
    //     ),
    //     context: context);
  }

  void resetPreReservation(BuildContext context) async {
    if (state is! ProgressReservationStateSuccess) return;
    if (!(state as ProgressReservationStateSuccess).data.isPre) {
      SnackBarUtil.showError("정규예약은 초기화 할 수 없습니다!");
      return;
    }

    CustomDialogUtil.showCustomDialog(
        dialog: CustomDialog(
          content: Text(
            '${(state as ProgressReservationStateSuccess).data.date} ${(state as ProgressReservationStateSuccess).data.time}시에 시작된\n사전예약 중 예약된 내역을 \n모두 삭제하시겠습니까?',
            style: kTextNormalStyle.copyWith(fontSize: kTextLargeSize),
          ),
          onPressed: () async {
            await ref
                .read(progressResrvationServiceProvider.notifier)
                .resetPreReservation();
            SnackBarUtil.showSuccess("예약을 초기화하였습니다!");

            if (context.mounted) Navigator.of(context).pop();
          },
        ),
        context: context);
  }
}
