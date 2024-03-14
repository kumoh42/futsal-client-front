import 'package:flutter_client_front/common/styles/colors.dart';

enum ReservationSettingType {
  started,
  closed;
}

extension ReservationSettingTypeParsing on ReservationSettingType {
  get color {
    switch (this) {
      case ReservationSettingType.started:
        return kMainColor;
      case ReservationSettingType.closed:
        return kPointColor;
    }
  }

  get value {
    switch (this) {
      case ReservationSettingType.started:
        return "시작됨";
      case ReservationSettingType.closed:
        return "종료됨";
    }
  }
}
