import 'package:dio/dio.dart';
import 'package:flutter_client_front/common/dio/dio.dart';
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
}
