import 'package:flutter/material.dart';
import 'package:flutter_client_front/common/styles/colors.dart';
import 'package:flutter_client_front/common/styles/sizes.dart';
import 'package:flutter_client_front/common/styles/text_styles.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? hintMessage;
  final IconData icon;
  const CustomIconButton({
    super.key,
    this.hintMessage = "",
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: hintMessage,
      textStyle: kTextNormalStyle.copyWith(
        fontSize: kTextSmallSize,
        color: kTextReverseColor,
        fontWeight: FontWeight.w400,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, size: kIconMiddleSize),
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        splashRadius: kIconMiddleSize / 1.2,
      ),
    );
  }
}
