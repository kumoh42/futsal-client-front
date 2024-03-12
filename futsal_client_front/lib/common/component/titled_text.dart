import 'package:flutter/material.dart';
import 'package:flutter_client_front/common/styles/colors.dart';
import 'package:flutter_client_front/common/styles/sizes.dart';
import 'package:flutter_client_front/common/styles/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitledText extends StatelessWidget {
  final String? title;
  final String? text;

  final IconData? prefixIcon;

  const TitledText({
    Key? key,
    this.title,
    this.text,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: kMainColor, width: 1.0.w)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (prefixIcon != null)
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: kPaddingMiddleSize,
                  ),
                  child: Icon(
                    prefixIcon,
                    size: kIconMiddleSize,
                    color: kMainColor,
                  ),
                ),
              Text(
                title ?? "",
                style: kTextMainStyle.copyWith(fontSize: kTextSmallSize),
              ),
            ],
          ),
          Text(
            text ?? "",
            style: kTextMainStyle.copyWith(fontSize: kTextSmallSize),
          ),
        ],
      ),
    );
  }
}
