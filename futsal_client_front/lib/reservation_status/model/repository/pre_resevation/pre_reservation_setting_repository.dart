import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_client_front/common/dio/dio.dart';
import 'package:flutter_client_front/reservation_status/model/entity/block_reservation_entity.dart';
import 'package:flutter_client_front/reservation_status/model/entity/pre_reservation/pre_reservation_status_entity.dart';
import 'package:flutter_client_front/reservation_status/model/entity/pre_reservation/progress_reservation_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'pre_reservation_setting_repository.g.dart';

final preReservationSettingRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return PreReservationSettingRepository(dio);
});

@RestApi()
abstract class PreReservationSettingRepository {
  factory PreReservationSettingRepository(Dio dio, {String baseUrl}) =
      _PreReservationSettingRepository;

  @POST('/reservation/pre/time-setting')
  @Headers({'accessToken': 'true'})
  Future setPreReservation(
      @Body() ProgressReservationEntity progressReservationEntity);

  @GET('/reservation/pre/time-list')
  @Headers({'accessToken': 'true'})
  Future<List<PreReservationStatusEntity>> getPreReservation();

  @PATCH('/reservation/pre/time-delete')
  @Headers({'accessToken': 'true'})
  Future cancelPreReservation(
      @Body() PreReservationStatusEntity preReservationStatusEntity);

  @POST('/reservation/block')
  @Headers({'accessToken': 'true'})
  Future blockReservation(@Body() BlockReservationEntity blockReservation);

  @PATCH('reservation/pre/time-delete')
  @Headers({'accessToken': 'true'})
  Future<void> deletePreReservation(@Body() PreReservationStatusEntity entity);
}
