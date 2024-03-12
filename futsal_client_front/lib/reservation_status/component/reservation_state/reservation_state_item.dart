import 'package:flutter/material.dart';
import 'package:flutter_client_front/common/component/custom_donut_paint.dart';
import 'package:flutter_client_front/common/component/custom_listview_background_paint.dart';
import 'package:flutter_client_front/common/styles/colors.dart';
import 'package:flutter_client_front/common/styles/sizes.dart';
import 'package:flutter_client_front/common/styles/text_styles.dart';
import 'package:flutter_client_front/common/utils/data_utils.dart';
import 'package:flutter_client_front/reservation_status/model/entity/reservation_entity.dart';

class ReservationStateItem extends StatelessWidget {
  final ReservationStatusEntity entity;
  final void Function(bool?) onPressed;
  final bool isChecked;
  final int index;
  final bool isLast;

  const ReservationStateItem({
    Key? key,
    required this.entity,
    required this.isChecked,
    required this.onPressed,
    required this.index,
    required this.isLast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color textColor = index % 2 == 0 ? kBackgroundMainColor : kMainColor;
    return LayoutBuilder(
      builder: (context, constraints) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: kPaddingSmallSize),
          CustomPaint(
            // 도넛 모양의 크기 설정
            size: Size(kIconMiddleSize, constraints.maxHeight),
            painter: CustomDonutPainter(isLast: isLast),
          ),
          SizedBox(width: kPaddingMiniSize),
          Padding(
            padding: EdgeInsets.only(left: kPaddingMiddleSize),
            child: Text(
              DataUtils.intToTimeRange(entity.time, 2),
              textAlign: TextAlign.center,
              style: kTextMainStyle.copyWith(fontSize: kTextSmallSize),
            ),
          ),
          SizedBox(width: kPaddingMiniSize),
          Expanded(
            child: CustomPaint(
              painter: CustomListViewBackgroundPaint(
                color: index % 2 == 0 ? kMainColor : kBackgroundMainColor,
              ),
              child: Padding(
                padding: EdgeInsets.only(right: kPaddingMiddleSize),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: SizedBox(width: kPaddingLargeSize),
                    ),
                    Expanded(
                      flex: 10,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: entity.major == null
                            ? entity.date
                                        .copyWith(hour: entity.time)
                                        .compareTo(DateTime.now()) ==
                                    -1
                                ? Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    // 예약 불가능일때
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "예약 불가능",
                                          style: kTextNormalStyle.copyWith(
                                            fontSize: kTextMiddleSize,
                                            color: textColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "예약 가능",
                                          style: kTextNormalStyle.copyWith(
                                            fontSize: kTextMiddleSize,
                                            color: textColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    // 누군가가 예약했을 때
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Text(
                                        entity.circle ?? "개인",
                                        style: kTextMainStyle.copyWith(
                                          fontSize: kTextLargeSize,
                                          color: textColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: kPaddingMiniSize),
                                      Text(
                                        entity.major ?? '',
                                        style: kTextReverseStyle.copyWith(
                                          fontSize: kTextMiniSize,
                                          color: textColor,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                      ),
                    ),
                    if (entity.major != null)
                      Transform.scale(
                        scale: ResponsiveSize.S(1.3),
                        child: Checkbox(
                          value: isChecked,
                          onChanged: onPressed,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                          side: MaterialStateBorderSide.resolveWith(
                            (states) => BorderSide(
                              width: 1.0,
                              color: textColor,
                            ),
                          ),
                        ),
                      ),
                    if (entity.major == null)
                      SizedBox(width: kPaddingMiddleSize),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
