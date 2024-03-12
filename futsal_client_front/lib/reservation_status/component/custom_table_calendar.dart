import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_client_front/common/styles/colors.dart';
import 'package:flutter_client_front/common/styles/sizes.dart';
import 'package:flutter_client_front/common/styles/text_styles.dart';
import 'package:flutter_client_front/common/utils/date_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomTimeTable extends ConsumerStatefulWidget {
  late final ChangeNotifierProvider<CustomTimeTableController> provider;
  late final double textSize;

  CustomTimeTable({
    Key? key,
    required CustomTimeTableController controller,
    double? textSize,
  }) : super(key: key) {
    provider = ChangeNotifierProvider((ref) => controller);
    this.textSize = textSize ?? kTextLargeSize;
  }

  @override
  ConsumerState<CustomTimeTable> createState() => _CustomTimeTableState();
}

class _CustomTimeTableState extends ConsumerState<CustomTimeTable> {
  late CustomTimeTableController controller;

  @override
  Widget build(BuildContext context) {
    controller = ref.watch(widget.provider);
    return LayoutBuilder(builder: (context, constraints) {
      final rowHeight = min(constraints.maxWidth, constraints.maxHeight) / 8;
      return TableCalendar(
        locale: 'ko_KR',
        sixWeekMonthsEnforced: true,
        daysOfWeekStyle: DaysOfWeekStyle(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: kDisabledColor, width: 0.5),
            ),
          ),
          weekendStyle: kTextNormalStyle.copyWith(fontSize: widget.textSize),
          weekdayStyle: kTextNormalStyle.copyWith(fontSize: widget.textSize),
        ),
        headerStyle: HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
          titleTextStyle: kTextMainStyle.copyWith(fontSize: widget.textSize),
          leftChevronPadding: EdgeInsets.zero,
          rightChevronPadding: EdgeInsets.zero,
          leftChevronMargin: EdgeInsets.zero,
          rightChevronMargin: EdgeInsets.zero,
          headerPadding: EdgeInsets.all(kPaddingSmallSize)
              .copyWith(top: kPaddingLargeSize),
          leftChevronIcon: Icon(Icons.chevron_left, size: kIconMiddleSize),
          rightChevronIcon: Icon(Icons.chevron_right, size: kIconMiddleSize),
        ),
        rangeStartDay: controller.startDay,
        rangeEndDay: controller.endDay,
        rowHeight: rowHeight,
        daysOfWeekHeight: rowHeight,
        firstDay: controller.firstDay,
        lastDay: controller.lastDay,
        focusedDay: controller.focusedDay,
        onDaySelected: controller.onDaySelected,
        selectedDayPredicate: controller.selectedDayPredicate,
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, dateTime, _) {
            return _cellBuilder(
              date: dateTime.day.toString(),
              textColor: dateTime.weekday == 6
                  ? Colors.blue
                  : dateTime.weekday == 7
                      ? Colors.red
                      : null,
              textSize: widget.textSize,
            );
          },
          rangeStartBuilder: (context, dateTime, focusedDay) => _cellBuilder(
            color: kMainColor,
            date: dateTime.day.toString(),
            textColor: kTextReverseColor,
            textSize: widget.textSize,
          ),

          withinRangeBuilder: (context, dateTime, focusedDay) => _cellBuilder(
            textSize: widget.textSize,
            textColor: kMainColor,
            date: dateTime.day.toString(),
          ),
          rangeEndBuilder: (context, dateTime, focusedDay) => _cellBuilder(
            color: kMainColor,
            date: dateTime.day.toString(),
            textColor: kTextReverseColor,
            textSize: widget.textSize,
          ),

          outsideBuilder: (context, dateTime, _) => _cellBuilder(
            textSize: widget.textSize,
            textColor: Colors.black.withOpacity(0.5),
            date: dateTime.day.toString(),
          ),

          // 오늘 날짜 셀의 빌더 함수
          todayBuilder: (context, dateTime, _) => _cellBuilder(
            textSize: widget.textSize,
            color: kBackgroundMainColor,
            date: dateTime.day.toString(),
            border: Border.all(
              color: kTextMainColor,
              width: 2,
            ),
          ),
          // 선택된 날짜 셀의 빌더 함수
          selectedBuilder: (context, dateTime, _) => _cellBuilder(
            color: kMainColor,
            date: dateTime.day.toString(),
            textColor: kTextReverseColor,
            textSize: widget.textSize,
          ),
        ),
        onPageChanged: controller.onPageChanged,
      );
    });
  }

  Widget _cellBuilder({
    Color? color,
    required String date,
    Color? textColor,
    BoxBorder? border,
    required double textSize,
  }) =>
      Center(
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(kBorderRadiusSize),
            border: border,
          ),
          width: textSize * 2,
          height: textSize * 2,
          child: Center(
            child: Text(
              date,
              style: kTextNormalStyle.copyWith(
                color: textColor,
                fontSize: textSize,
              ),
              softWrap: false,
            ),
          ),
        ),
      );
}

class CustomTimeTableController extends ChangeNotifier {
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  late final DateTime _firstDay;
  late final DateTime _lastDay;
  late DateTime? _startDay;
  late DateTime? _endDay;
  final Function()? onDayChange;
  final bool useRange;
  late bool isSelectableBeforeTime;

  int count = 0;
  bool toggle = true;

  DateTime get focusedDay => _focusedDay;

  DateTime get selectedDay => _focusedDay;

  DateTime get firstDay => _firstDay;

  DateTime get lastDay => _lastDay;

  DateTime? get startDay => _startDay;

  DateTime? get endDay => _endDay;

  CustomTimeTableController({
    this.useRange = false,
    this.isSelectableBeforeTime = true,
    DateTime? initDay,
    DateTime? firstDay,
    DateTime? lastDay,
    DateTime? startDay,
    DateTime? endDay,
    this.onDayChange,
  })  : _focusedDay = initDay ?? DateTime.now(),
        _selectedDay = initDay ?? DateTime.now(),
        _firstDay = firstDay ?? DateTime.utc(2010, 10, 16),
        _lastDay = lastDay ?? DateTime.utc(2030, 3, 14),
        _startDay = null,
        _endDay = null;

  void onDaySelected(
    DateTime selectedDay,
    DateTime focusedDay,
  ) {
    if (!isSelectableBeforeTime) {
      DateTime dateTimeNow = DateTime.now();
      String now = defaultDateFormat.format(dateTimeNow);
      if (now.compareTo(defaultDateFormat.format(selectedDay)) > 0) {
        return;
      }
    }
    _focusedDay = selectedDay;
    _selectedDay = selectedDay;

    if (useRange) {
      if (toggle) {
        _startDay = _selectedDay;
        _endDay = null;
      } else {
        _endDay = _selectedDay;
      }

      if (_startDay != null && _endDay != null) {
        if (_endDay!.isBefore(_startDay!)) {
          final temp = _endDay;
          _endDay = _startDay;
          _startDay = temp;
        }
      }
      toggle = !toggle;
    }

    if (onDayChange != null) onDayChange!();
    notifyListeners();
  }

  bool selectedDayPredicate(DateTime? day) => isSameDay(_selectedDay, day);

  void onPageChanged(DateTime dateTime) {
    if (isSelectableBeforeTime) {
      _startDay = null;
      _endDay = null;
      onDaySelected(dateTime, dateTime);
    }
  }
}
