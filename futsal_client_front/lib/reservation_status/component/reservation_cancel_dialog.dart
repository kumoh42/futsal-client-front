import 'package:flutter/material.dart';
import 'package:flutter_client_front/common/component/custom_icon_button.dart';
import 'package:flutter_client_front/common/component/titled_text.dart';
import 'package:flutter_client_front/common/styles/colors.dart';
import 'package:flutter_client_front/common/styles/sizes.dart';
import 'package:flutter_client_front/common/styles/text_styles.dart';
import 'package:flutter_client_front/common/utils/date_utils.dart';
import 'package:flutter_client_front/reservation_status/model/entity/reservation_entity.dart';

class ReservationCancelDialog extends StatelessWidget {
  final List<ReservationStatusEntity> entities;
  final Future Function(ReservationStatusEntity) onPressed;

  const ReservationCancelDialog({
    Key? key,
    required this.entities,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return AlertDialog(
      title: Row(
        children: [
          const Expanded(child: Text('예약 취소 확인')),
          CustomIconButton(
            icon: Icons.close,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      titleTextStyle: kTextMainStyle.copyWith(fontSize: kTextLargeSize),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(kBorderRadiusSize),
        ),
      ),
      content: SingleChildScrollView(
        child: Container(
          width: width * 0.3,
          constraints: const BoxConstraints(minWidth: 500, maxWidth: 700),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: kPaddingMiddleSize),
              for (var e in entities)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TitledText(
                      title: '예약 날짜',
                      text: defaultDateFormat.format(e.date),
                    ),
                    SizedBox(width: kPaddingLargeSize),
                    TitledText(
                      title: '예약 시간',
                      text: '${e.time}시~${e.time + 2}시',
                    ),
                  ],
                ),
              SizedBox(height: kPaddingMiddleSize),
              Text(
                '예약을 취소하시겠습니까?',
                style: kTextMainStyle.copyWith(fontSize: kTextSmallSize),
              ),
              SizedBox(height: kPaddingMiddleSize),
              Text(
                '사전 안내 없이 임의로 취소하여 문제가 발생할 경우\n\'금오사이\'에서는 챔임지지 않습니다.',
                style: kTextMainStyle.copyWith(fontSize: kTextSmallSize),
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            await onPressed(entities[0]);
            if (context.mounted) Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: kMainColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: kPaddingLargeSize,
              vertical: kPaddingMiddleSize,
            ),
          ),
          child: Row(
            children: [
              const Icon(Icons.check),
              Expanded(
                child: Center(
                  child: Text(
                    '확인 및 예약 취소',
                    style: kTextMainStyle.copyWith(
                      fontSize: kTextMiddleSize,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
