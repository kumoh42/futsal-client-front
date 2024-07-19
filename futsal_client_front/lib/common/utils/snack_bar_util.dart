import 'package:flutter/material.dart';
import 'package:flutter_client_front/common/styles/colors.dart';

class SnackBarUtil {
  static GlobalKey<ScaffoldMessengerState> key =
      GlobalKey<ScaffoldMessengerState>();

  static void showError(String message, {TextStyle? textStyle}) {
    key.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(drawSnackBar(message, kPointColor, textStyle: textStyle));
  }

  static void showMessage(String message, {TextStyle? textStyle}) {
    key.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(drawSnackBar(message, kSubColor, textStyle: textStyle));
  }

  static void showSuccess(String message, {TextStyle? textStyle}) {
    key.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(drawSnackBar(message, kMainColor, textStyle: textStyle));
  }

  static SnackBar drawSnackBar(String message, Color color,
      {TextStyle? textStyle}) {
    return SnackBar(
      backgroundColor: color,
      content: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            softWrap: false,
            style: textStyle,
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(20.0),
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
