import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_client_front/common/styles/colors.dart';
import 'package:flutter_client_front/common/styles/sizes.dart';
import 'package:flutter_client_front/common/styles/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormFieldSignup extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextStyle? textStyle;
  late final double contentPadding;
  final Color? backgroundColor;

  CustomTextFormFieldSignup({
    Key? key,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.controller,
    this.textStyle,
    double? contentPadding,
    this.backgroundColor,
  }) : super(key: key) {
    this.contentPadding = contentPadding ?? kWPaddingMiddleSize;
  }

  @override
  _CustomTextFormFieldSignupState createState() =>
      _CustomTextFormFieldSignupState();
}

class _CustomTextFormFieldSignupState extends State<CustomTextFormFieldSignup> {
  String? _errorMessage;

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final fontSize = ResponsiveData.kIsMobile
        ? ResponsiveSize.M(kWTextLargeSize)
        : kWTextSmallSize;
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? kBackgroundMainColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (widget.prefixIcon != null)
            Icon(
              widget.prefixIcon,
              size: kWIconSmallSize,
              color: kSubColor,
            ),
          if (widget.prefixIcon != null)
            const SizedBox(width: kWPaddingSmallSize),
          if (widget.labelText != null)
            SizedBox(
              width: ResponsiveData.kIsMobile ? ResponsiveSize.M(180) : 110,
              child: Text(
                widget.labelText!,
                style: kTextMainStyle.copyWith(fontSize: fontSize),
              ),
            ),
          SizedBox(width: widget.contentPadding),
          Expanded(
            child: RawKeyboardListener(
              focusNode: _focusNode,
              onKey: (RawKeyEvent event) {
                if (event is RawKeyDownEvent) {
                  if (event.logicalKey == LogicalKeyboardKey.tab) {
                    return;
                  }
                }
              },
              child: TextFormField(
                controller: widget.controller,
                validator: (value) {
                  setState(() {
                    _errorMessage = widget.validator!(value);
                  });
                  return widget.validator!(value);
                },
                cursorColor: kTextMainColor,
                keyboardType: widget.keyboardType,
                obscureText:
                    widget.keyboardType == TextInputType.visiblePassword,
                style: widget.textStyle ??
                    kTextMainStyle.copyWith(fontSize: fontSize),
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                ],
                decoration: InputDecoration(
                  errorText: _errorMessage,
                  isDense: true,
                  contentPadding:
                      EdgeInsets.only(bottom: widget.contentPadding),
                  hintText: widget.hintText,
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(width: 1.0.w)),
                  hintStyle: widget.textStyle?.copyWith(
                        color: kTextMainColor.withOpacity(0.5),
                      ) ??
                      kTextMainStyle.copyWith(
                        fontSize: fontSize,
                        color: kTextMainColor.withOpacity(0.5),
                      ),
                  filled: true,
                  fillColor: widget.backgroundColor ?? kBackgroundMainColor,
                  errorStyle: kTextMainStyle.copyWith(
                    color: kPointColor, // 에러 텍스트의 색상을 설정
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
