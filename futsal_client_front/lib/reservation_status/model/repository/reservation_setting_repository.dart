import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_client_front/common/dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'reservation_setting_repository.g.dart';

final reservationSettingRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return ReservationSettingRepository(dio);
});

@RestApi()
abstract class ReservationSettingRepository {
  factory ReservationSettingRepository(Dio dio, {String baseUrl}) =
      _ReservationSettingRepository;

  @PUT('/reservation/pre')
  @Headers({'accessToken': 'true'})
  Future setPreReservationState(@Query("state") String state);
}
