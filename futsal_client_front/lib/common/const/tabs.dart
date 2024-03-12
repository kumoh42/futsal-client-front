import 'package:flutter/material.dart';
import 'package:flutter_client_front/reservation_status/view/pre_reservation_setting_view.dart';
import 'package:flutter_client_front/reservation_status/view/reservation_status_view.dart';

class TabInfo {
  final String label;
  final Widget tab;

  const TabInfo({required this.label, required this.tab});
}

const TABS = [
  TabInfo(label: '예약 현황 관리', tab: ReservationStatusView()),
  TabInfo(label: '사전 예약 설정', tab: PreReservationSettingView()),
];
