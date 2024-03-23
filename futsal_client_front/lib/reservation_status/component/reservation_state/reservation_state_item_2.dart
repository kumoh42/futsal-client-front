import 'package:flutter/material.dart';
import 'package:flutter_client_front/common/styles/colors.dart';
import 'package:flutter_client_front/common/styles/sizes.dart';
import 'package:flutter_client_front/common/styles/text_styles.dart';
import 'package:flutter_client_front/common/utils/data_utils.dart';
import 'package:flutter_client_front/reservation_status/model/entity/reservation_entity.dart';
import 'package:flutter_client_front/reservation_status/type/reservation_type.dart';

class ReservationStateItem2 extends StatefulWidget {
  final ReservationStatusEntity entity;
  final void Function() onPressed;
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
