import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'ACCESS_TOKEN_KEY')
  static const String ACCESS_TOKEN_KEY = _Env.ACCESS_TOKEN_KEY;

  @EnviedField(varName: 'REFRESH_TOKEN_KEY')
  static const String REFRESH_TOKEN_KEY = _Env.REFRESH_TOKEN_KEY;

  @EnviedField(varName: 'KUMOH42_FIND_ACCOUNT')
  static const String KUMOH42_FIND_ACCOUNT = _Env.KUMOH42_FIND_ACCOUNT;

  @EnviedField(varName: 'KUMOH42_REGISTER')
  static const String KUMOH42_REGISTER = _Env.KUMOH42_REGISTER;

  @EnviedField(varName: 'IP')
  static const String IP = _Env.IP;
}
