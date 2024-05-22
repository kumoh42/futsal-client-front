import 'package:flutter/material.dart';
import 'package:flutter_client_front/auth/model/state/auth_state.dart';
import 'package:flutter_client_front/auth/viewmodel/login_viewmodel.dart';
import 'package:flutter_client_front/common/styles/colors.dart';
import 'package:flutter_client_front/common/styles/sizes.dart';
import 'package:flutter_client_front/common/styles/text_styles.dart';
import 'package:flutter_client_front/common/utils/data_utils.dart';
import 'package:flutter_client_front/common/utils/date_utils.dart';
import 'package:flutter_client_front/reservation_status/component/designed_button.dart';
import 'package:flutter_client_front/reservation_status/model/entity/reservation_entity.dart';
import 'package:flutter_client_front/reservation_status/type/reservation_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReservationStateItem2 extends ConsumerStatefulWidget {
  final ReservationStatusEntity entity;
  final void Function() onPressed;
  final bool isChecked;
  final int index;
  final bool isLast;
  late final ReservationType type;
  final void Function()? onCancelPressed;

  ReservationStateItem2({
    Key? key,
    required this.entity,
    required this.isChecked,
    required this.onPressed,
    required this.index,
    required this.isLast,
    this.onCancelPressed,
  }) : super(key: key) {
    type = ReservationType.fromEntity(entity);
  }

  @override
  ConsumerState<ReservationStateItem2> createState() =>
      _ReservationStateItem2State();
}

class _ReservationStateItem2State extends ConsumerState<ReservationStateItem2> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(loginViewModelProvider);

    return InkWell(
      onHover: (value) {
        setState(() {
          isHovered = value;
        });
      },
      onTap: () {
        setState(() {
          isHovered = true;
        });
        widget.onPressed();
        Future.delayed(const Duration(milliseconds: 200), () {
          setState(() {
            isHovered = false;
          });
        });
      },
      child: LayoutBuilder(
        builder: (context, constraints) => AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kBorderRadiusSize),
            color: widget.type == ReservationType.able
                ? isHovered
                    ? kSelectColor
                    : widget.type.color
                : widget.type.color,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: kPaddingLargeSize),
                SizedBox(
                  width: kIconMiddleSize,
                  height: kIconMiddleSize,
                  child: widget.type.icon,
                ),
                SizedBox(width: kPaddingLargeSize),
                Text(
                  DataUtils.intToTimeRange(widget.entity.time, 2),
                  textAlign: TextAlign.center,
                  style: kTextReverseStyle.copyWith(fontSize: kTextMiddleSize),
                ),
                SizedBox(width: kPaddingLargeSize),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: widget.type == ReservationType.reserved
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      widget.entity.circle ?? "개인",
                                      style: kTextMainStyle.copyWith(
                                        fontSize:
                                            (kTextLargeSize + kTextMiddleSize) /
                                                2,
                                        color: kTextReverseColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: kPaddingMiniSize),
                                    Text(
                                      widget.entity.major ?? '',
                                      style: kTextReverseStyle.copyWith(
                                        fontSize: kTextMiniSize,
                                        color: kTextReverseColor,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                )
                              : widget.type.contents,
                        ),
                      ),
                      SizedBox(width: kPaddingLargeSize),
                      if ((viewModel.state is AuthStateSuccess) &&
                          (viewModel.state as AuthStateSuccess)
                                  .data
                                  .member_srl ==
                              widget.entity.member_srl)
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: kIconMiddleSize,
                          ),
                          child: IconButton(
                            iconSize: kIconMiddleSize,
                            color: kBackgroundMainColor,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    actions: [
                                      DesignedButton(
                                        color: kPointColor,
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        icon: Icons.close,
                                        text: "닫기",
                                      ),
                                      DesignedButton(
                                        onPressed: () async {
                                          if (widget.onCancelPressed != null) {
                                            widget.onCancelPressed!();
                                          }
                                        },
                                        icon: Icons.check,
                                        text: "확인",
                                      ),
                                    ],
                                    title: Text(
                                      "예약 취소",
                                      style: kTextMainStyle.copyWith(
                                        fontSize: kTextSmallSize,
                                      ),
                                    ),
                                    content: Padding(
                                      padding: EdgeInsets.only(
                                          top: kPaddingLargeSize,
                                          left: kPaddingLargeSize,
                                          right: kPaddingLargeSize),
                                      child: Text(
                                        "취소 날짜: ${regDateFormatK.format(widget.entity.date)} ${widget.entity.time.toString().padLeft(2, "0")}시~${(widget.entity.time + 2).toString().padLeft(2, "0")}시\n정말 취소 하시겠습니까?",
                                        style: kTextMainStyle.copyWith(
                                          fontSize: kTextMiddleSize,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.close,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
