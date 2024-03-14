import 'package:flutter_client_front/common/env/env.dart';

class DataUtils {
  static pathToUrl(String value) => '${Env.IP}$value';

  static urlToPath(String value) => value.substring(7 + Env.IP.length);

  static intToTimeRange(int value, int range) =>
      "${value.toString().padLeft(2, '0')}:00 ~ ${(value + range).toString().padLeft(2, '0')}:00";
}
