import 'package:flutter/material.dart';
import 'package:flutter_client_front/common/styles/sizes.dart';
import 'package:flutter_client_front/common/styles/text_styles.dart';

class CustomTextButton extends StatelessWidget {
  final void Function()? onPressed;

  final String text;
  final TextAlign textAlign;

  const CustomTextButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.textAlign = TextAlign.center})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fontSize = ResponsiveData.kIsMobile
        ? ResponsiveSize.M(kWTextLargeSize)
        : kWTextSmallSize;
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        alignment: Alignment.centerLeft,
        minimumSize: Size.fromHeight(fontSize),
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        text,
        textAlign: textAlign,
        style: kTextDisabledStyle.copyWith(fontSize: fontSize),
      ),
    );
  }
}
