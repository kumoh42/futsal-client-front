import 'package:dio/dio.dart';
import 'package:flutter_client_front/auth/provider/auth_provider.dart';
import 'package:flutter_client_front/common/env/env.dart';
import 'package:flutter_client_front/common/local_storage/local_storage.dart';
import 'package:flutter_client_front/common/utils/data_utils.dart';
import 'package:flutter_client_front/common/utils/snack_bar_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider((ref) {
  final dio = Dio();
  final storage = ref.watch(localStorageProvider);
  dio.interceptors.add(CustomInterceptor(storage: storage, ref: ref));
  dio.options = options;
  return dio;
});

final options = BaseOptions(
  baseUrl: Env.IP,
);

class CustomInterceptor extends Interceptor {
  final LocalStorage storage;
  final Ref ref;

  CustomInterceptor({required this.storage, required this.ref});

  // 1) 요청을 보낼때
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.headers['accessToken'] == 'true') {
      options.headers.remove('accessToken');
      final token = await storage.read(key: Env.ACCESS_TOKEN_KEY);
      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }

    if (options.headers['refreshToken'] == 'true') {
      options.headers.remove('accessToken');
      final token = await storage.read(key: Env.REFRESH_TOKEN_KEY);
      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }

    super.onRequest(options, handler);
  }

  // 2) 응답을 받을때
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.requestOptions.path == '/auth') {
      try {
        await _saveToken(response);
      } on DioException catch (e) {
        return handler.reject(e);
      }
    }

    super.onResponse(response, handler);
  }

  // 3) 에러가 났을떄
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final refreshToken = await storage.read(key: Env.REFRESH_TOKEN_KEY);

    if (refreshToken == null) return handler.reject(err);

    final isStatus401 = err.response?.statusCode == 401;
    final isPathRefresh = err.requestOptions.path == '/auth/token';

    if (isStatus401 && !isPathRefresh) {
      final dio = Dio();

      try {
        final refreshResponse = await dio.post(
          DataUtils.pathToUrl('/auth/token'),
          options: Options(headers: {
            'authorization': 'Bearer $refreshToken',
          }),
        );

        await _saveToken(refreshResponse);

        final token = await storage.read(key: Env.ACCESS_TOKEN_KEY);
        final options = err.requestOptions;
        options.headers.addAll({
          'authorization': 'Bearer $token',
        });

        final response = await dio.fetch(options);
        handler.resolve(response);
      } on DioException catch (e) {
        ref.read(authProvider.notifier).logout();
        SnackBarUtil.showError("로그인 인증이 만료되었습니다. 다시 로그인 해 주세요");
        return handler.reject(e);
      }
    }
    super.onError(err, handler);
  }

  Future _saveToken(Response response) async {
    final accessToken = response.headers.value(Env.ACCESS_TOKEN_KEY);
    final refreshToken = response.headers.value(Env.REFRESH_TOKEN_KEY);

    if (accessToken == null || refreshToken == null) {
      throw DioException(
        requestOptions: response.requestOptions,
        type: DioExceptionType.badResponse,
        message: "토큰 정보를 가져오지 못했습니다.",
        response: response,
      );
    }

    try {
      Future.wait([
        storage.write(
          key: Env.ACCESS_TOKEN_KEY,
          value: accessToken.replaceFirst("Bearer ", ""),
        ),
        storage.write(
          key: Env.REFRESH_TOKEN_KEY,
          value: refreshToken.replaceFirst("Bearer ", ""),
        ),
      ]);
    } catch (e) {
      rethrow;
    }
  }
}
