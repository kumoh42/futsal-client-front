import 'package:flutter/material.dart';
import 'package:flutter_client_front/common/styles/colors.dart';
import 'package:flutter_client_front/common/styles/sizes.dart';
import 'package:flutter_client_front/common/styles/text_styles.dart';
import 'package:flutter_client_front/common/utils/data_utils.dart';
import 'package:flutter_client_front/reservation_status/model/entity/reservation_entity.dart';
import 'package:flutter_client_front/reservation_status/type/reservation_type.dart';

class ReservationStateItem2 extends StatefulWidget {
  final ReservationStatusEntity entity;
  final void Function(bool?) onPressed;
  final bool isChecked;
  final int index;
  final bool isLast;
  late final ReservationType type;

  ReservationStateItem2({
    Key? key,
    required this.entity,
    required this.isChecked,
    required this.onPressed,
    required this.index,
    required this.isLast,
  }) : super(key: key) {
    type = ReservationType.fromEntity(entity);
  }

  @override
  State<ReservationStateItem2> createState() => _ReservationStateItem2State();
}

class _ReservationStateItem2State extends State<ReservationStateItem2> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (value) {
        setState(() {
          isHovered = value;
        });
      },
      onTap: () {
        if (widget.type == ReservationType.able) {
          print("예약");
        }
      },
      child: LayoutBuilder(
        builder: (context, constraints) => Container(
          decoration: BoxDecoration(
            border: Border.all(color: kBorderColor),
            borderRadius: BorderRadius.circular(kBorderRadiusSize),
            color: widget.type == ReservationType.able
                ? isHovered
                    ? widget.type.color.withAlpha(170)
                    : widget.type.color
                : widget.type.color,
          ),
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
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    widget.entity.circle ?? "개인",
                                    style: kTextMainStyle.copyWith(
                                      fontSize: kTextLargeSize,
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
                    if (widget.type == ReservationType.able)
                      // Transform.scale(
                      //   scale: ResponsiveSize.S(1.4),
                      //   child: Padding(
                      //     padding: EdgeInsets.only(
                      //       right: kPaddingXLargeSize,
                      //     ),
                      //     child: ElevatedButton(
                      //       onPressed: () {
                      //         // TODO
                      //         // if(로그인된 사용자) 예약 확인 화면
                      //         // else 로그인 화면
                      //         // 사전예약 기간이라면 일반 사용자 예약 x
                      //         // 동아리 사용자만 예약 가능
                      //       },
                      //       style: ButtonStyle(
                      //         overlayColor:
                      //             MaterialStateProperty.all<Color>(kTextSubColor),
                      //         elevation: MaterialStateProperty.all<double>(2),
                      //         shape: MaterialStateProperty.all<
                      //             RoundedRectangleBorder>(
                      //           RoundedRectangleBorder(
                      //             borderRadius:
                      //                 BorderRadius.circular(kBorderRadiusSize),
                      //           ),
                      //         ),
                      //       ),
                      //       child: const Text(
                      //         "예약하기",
                      //         style: kTextNormalStyle,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(width: kPaddingLargeSize),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
