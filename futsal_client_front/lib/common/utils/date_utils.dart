import 'package:intl/intl.dart';

final DateFormat settingDateFormat =
    DateFormat("yyyy-MM-dd EEEE\nhh : mm : ss a", 'ko');
final DateFormat defaultDateFormat = DateFormat("yyyy-MM-dd");

final DateFormat regDateFormat = DateFormat("yyyy-MM-dd");
final DateFormat regDateFormatK = DateFormat("yyyy년 MM월 dd일");

final DateFormat regDateMonthFormat = DateFormat("yyyy-MM");

final DateFormat regDateTimeFormat = DateFormat("yyyy-MM-dd HH:mm:00");
final DateFormat regDateTimeFormatK = DateFormat("yyyy년 MM월 dd일 HH:mm:00");

String getDayOfWeek(DateTime date) => DateFormat('EEEE', 'ko_KR').format(date);
