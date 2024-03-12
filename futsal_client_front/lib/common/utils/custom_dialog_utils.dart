import 'package:flutter/material.dart';
import 'package:flutter_client_front/common/styles/sizes.dart';
import 'package:flutter_client_front/common/styles/text_styles.dart';

class CustomDialogUtil {
  static void showCustomDialog(
      {required CustomDialog dialog, required BuildContext context}) {
    showDialog(
      context: context,
      builder: (context) => dialog,
    );
  }
}

class CustomDialog extends StatelessWidget {
  final Widget? title;
  final Widget? content;
  final String? cancel;
  final String? accept;
  final VoidCallback onPressed;
  const CustomDialog({
    super.key,
    this.content,
    this.cancel,
    this.accept,
    this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: content,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            cancel ?? "cancel",
            style: kTextMainStyle.copyWith(fontSize: kTextSmallSize),
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            accept ?? "ok",
            style: kTextMainStyle.copyWith(fontSize: kTextSmallSize),
          ),
        ),
      ],
    );
  }
}
