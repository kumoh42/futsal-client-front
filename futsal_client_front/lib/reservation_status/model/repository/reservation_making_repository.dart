import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_client_front/common/dio/dio.dart';
import 'package:flutter_client_front/reservation_status/model/entity/reservation_making_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'reservation_making_repository.g.dart';

final reservationMakingRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return ReservationMakingRepository(dio);
});

@RestApi()
abstract class ReservationMakingRepository {
  factory ReservationMakingRepository(Dio dio, {String baseUrl}) =
      _ReservationMakingRepository;

  @POST('/user/reservation')
  @Headers({'accessToken': 'true'})
  Future makeReservation(@Body() ReservationMakingEntity entity);

  @DELETE('/user/reservation')
  @Headers({'accessToken': 'true'})
  Future cancelReservation(@Body() ReservationMakingEntity entity);
}
