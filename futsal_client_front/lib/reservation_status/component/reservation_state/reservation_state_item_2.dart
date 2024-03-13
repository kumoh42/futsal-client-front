import 'package:flutter/material.dart';
import 'package:flutter_client_front/common/styles/colors.dart';
import 'package:flutter_client_front/common/styles/sizes.dart';
import 'package:flutter_client_front/common/styles/text_styles.dart';
import 'package:flutter_client_front/common/utils/data_utils.dart';
import 'package:flutter_client_front/reservation_status/model/entity/reservation_entity.dart';
import 'package:flutter_client_front/reservation_status/type/reservation_type.dart';

class ReservationStateItem2 extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kBorderRadiusSize),
          color: type.color,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: kPaddingLargeSize),
            SizedBox(
              width: kIconMiddleSize,
              height: kIconMiddleSize,
              child: type.icon,
            ),
            SizedBox(width: kPaddingLargeSize),
            Text(
              DataUtils.intToTimeRange(entity.time, 2),
              textAlign: TextAlign.center,
              style: kTextReverseStyle.copyWith(fontSize: kTextSmallSize),
            ),
            SizedBox(width: kPaddingLargeSize),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: type == ReservationType.reserved
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  entity.circle ?? "개인",
                                  style: kTextMainStyle.copyWith(
                                    fontSize: kTextLargeSize,
                                    color: kTextReverseColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: kPaddingMiniSize),
                                Text(
                                  entity.major ?? '',
                                  style: kTextReverseStyle.copyWith(
                                    fontSize: kTextMiniSize,
                                    color: kTextReverseColor,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            )
                          : type.contents,
                    ),
                  ),
                  if (type == ReservationType.able)
                    Transform.scale(
                      scale: ResponsiveSize.S(1.3),
                      child: ElevatedButton(
                          onPressed: () {}, child: const Text("예약하기")),
                    ),
                  SizedBox(width: kPaddingLargeSize),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
