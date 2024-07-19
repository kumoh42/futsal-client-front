import 'package:flutter/material.dart';
import 'package:flutter_client_front/common/styles/colors.dart';
import 'package:flutter_client_front/common/styles/sizes.dart';
import 'package:flutter_client_front/common/styles/text_styles.dart';
import 'package:flutter_client_front/reservation_status/model/entity/reservation_entity.dart';

enum ReservationType {
  able,
  disable,
  reserved;

  factory ReservationType.fromEntity(ReservationStatusEntity entity) =>
      entity.major != null
          ? ReservationType.reserved
          : entity.date.copyWith(hour: entity.time).compareTo(DateTime.now()) ==
                  -1
              ? ReservationType.disable
              : ReservationType.able;
}

extension ReservationTypeData on ReservationType {
  Color get color {
    switch (this) {
      case ReservationType.able:
        return kAbleColor;
      case ReservationType.disable:
        return kMainColor;
      case ReservationType.reserved:
        return kMainColor;
    }
  }

  Widget get icon {
    switch (this) {
      case ReservationType.able:
        return Icon(
          Icons.check,
          color: kTextReverseColor,
          size: kIconMiddleSize,
        );
      case ReservationType.disable:
        return Icon(
          Icons.close,
          color: kTextReverseColor,
          size: kIconMiddleSize,
        );
      case ReservationType.reserved:
        return Icon(
          Icons.circle,
          color: kTextReverseColor,
          size: kIconSmallSize,
        );
    }
  }

  Widget? get contents {
    switch (this) {
      case ReservationType.able:
        return Text(
          "예약 가능",
          style: kTextNormalStyle.copyWith(
            fontSize: (kTextMiddleSize + kTextLargeSize) / 2,
            color: kTextReverseColor,
            fontWeight: FontWeight.w900,
          ),
        );
      case ReservationType.disable:
        return Text(
          "예약 불가능",
          style: kTextNormalStyle.copyWith(
            fontSize: (kTextMiddleSize + kTextLargeSize) / 2,
            color: kTextReverseColor,
            fontWeight: FontWeight.w900,
          ),
        );
      case ReservationType.reserved:
        return null;
    }
  }
}
