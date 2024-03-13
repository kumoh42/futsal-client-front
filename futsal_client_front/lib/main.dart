import 'package:flutter/material.dart';
import 'package:flutter_client_front/common/component/default_container.dart';
import 'package:flutter_client_front/common/styles/sizes.dart';
import 'package:flutter_client_front/common/utils/snack_bar_util.dart';
import 'package:flutter_client_front/reservation_status/view/reservation_status_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await initializeDateFormatting();
  runApp(ProviderScope(
    child: ScreenUtilInit(
      designSize: const Size(1920, 1080),
      rebuildFactor: RebuildFactors.always,
      builder: (context, child) => const MyApp(),
    ),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ResponsiveData.kIsMobile =
        MediaQuery.of(context).size.width <= kMobileTrigger;
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 표시 지우기
      scaffoldMessengerKey: SnackBarUtil.key,
      title: 'Kumoh42 Futsal Reservation System',
      home: const DefaultContainer(
        title: "풋살장 예약 페이지",
        body: ReservationStatusView(),
      ),
    );
  }
}
