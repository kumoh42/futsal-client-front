import 'package:flutter/material.dart';
import 'package:flutter_client_front/common/component/container/responsive_container.dart';
import 'package:flutter_client_front/common/styles/sizes.dart';
import 'package:flutter_client_front/common/styles/text_styles.dart';
import 'package:flutter_client_front/common/utils/date_utils.dart';
import 'package:flutter_client_front/reservation_status/component/custom_table_calendar.dart';
import 'package:flutter_client_front/reservation_status/component/designed_button.dart';
import 'package:flutter_client_front/common/component/base_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalendarSelectDialog extends ConsumerStatefulWidget {
  final Future Function(
    CustomTimeTableController controller,
    String startTime,
    String endTime,
  ) onPressed;
  late final ChangeNotifierProvider<CustomTimeTableController> provider;
  final List<String> startTimes;
  final List<String> endTimes;
  final String title;

  CalendarSelectDialog({
    Key? key,
    required this.onPressed,
    required CustomTimeTableController controller,
    required this.endTimes,
    required this.startTimes,
    required this.title,
  }) : super(key: key) {
    provider = ChangeNotifierProvider((ref) => controller);
  }

  @override
  ConsumerState<CalendarSelectDialog> createState() =>
      _ReservationBlockDialogState();
}

class _ReservationBlockDialogState<T>
    extends ConsumerState<CalendarSelectDialog> {
  late CustomTimeTableController controller;

  String _selectedStartTime = '';
  String _selectedEndTime = '';

  String toNextMonth(String? date) {
    if (date == null) return '-';
    DateTime dateTime = regDateMonthFormat.parse(date);
    DateTime result = DateTime(dateTime.year, dateTime.month + 1, 1);
    return regDateFormatK.format(result);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedStartTime = widget.startTimes[0];
      _selectedEndTime = widget.endTimes[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    controller = ref.watch(widget.provider);

    return BaseDialog(
      title: widget.title,
      child: SizedBox(
        height: ResponsiveData.kIsMobile
            ? ResponsiveSize.M(900)
            : ResponsiveSize.W(500),
        width: ResponsiveSize.W(850),
        child: ResponsiveContainer(
          children: [
            ResponsiveWidget(
              wFlex: 1,
              mFlex: 1,
              child: CustomTimeTable(
                controller: controller,
                textSize: kTextMiddleSize,
              ),
            ),
            ResponsiveSizedBox(size: kPaddingMiddleSize),
            const ResponsiveDivider(),
            ResponsiveSizedBox(size: kPaddingMiddleSize),
            ResponsiveWidget(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: kPaddingLargeSize),
                  buildDateTimeSelector(
                    title: "시작 일시",
                    content: controller.useRange
                        ? regDateFormatK.format(
                            controller.startDay ?? controller.selectedDay,
                          )
                        : regDateFormatK.format(
                            controller.selectedDay,
                          ),
                    selectedTime: _selectedStartTime,
                    times: widget.startTimes,
                    onChanged: (value) {
                      setState(() => _selectedStartTime = value!);
                    },
                  ),
                  buildDateTimeSelector(
                    title: "종료 일시",
                    content: controller.useRange
                        ? regDateFormatK
                            .format(controller.endDay ?? controller.selectedDay)
                        : toNextMonth(
                            regDateMonthFormat.format(controller.selectedDay),
                          ),
                    selectedTime: _selectedEndTime,
                    times: widget.endTimes,
                    onChanged: (value) {
                      setState(() => _selectedEndTime = value!);
                    },
                  ),
                  DesignedButton(
                    text: '저장',
                    icon: Icons.save,
                    onPressed: () async {
                      await widget.onPressed(
                        controller,
                        _selectedStartTime,
                        _selectedEndTime,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildDateTimeSelector({
  required String title,
  required String content,
  required String selectedTime,
  required List<String> times,
  required void Function(String?)? onChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: kTextDisabledStyle.copyWith(fontSize: kTextSmallSize),
      ),
      Row(
        children: [
          Text(
            content,
            style: kTextMainStyle.copyWith(fontSize: kTextMiddleSize),
          ),
          SizedBox(width: kPaddingMiddleSize),
          DropdownButton(
            value: selectedTime,
            items: times
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                      style: kTextMainStyle.copyWith(
                        fontSize: kTextMiddleSize,
                      ),
                    ),
                  ),
                )
                .toList(),
            onChanged: onChanged,
          )
        ],
      ),
    ],
  );
}
