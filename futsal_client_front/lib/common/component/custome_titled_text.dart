import 'package:flutter/material.dart';
import 'package:flutter_client_front/common/styles/sizes.dart';
import 'package:flutter_client_front/common/styles/text_styles.dart';

class CustomTitledText extends StatelessWidget {
  final String title;
  final Widget content;
  const CustomTitledText({
    super.key,
    required this.content,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: kTextDisabledStyle.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: kTextMiniSize,
          ),
        ),
        content,
      ],
    );
  }
}
