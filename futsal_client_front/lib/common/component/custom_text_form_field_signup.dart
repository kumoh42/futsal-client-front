import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_client_front/common/styles/colors.dart';
import 'package:flutter_client_front/common/styles/sizes.dart';
import 'package:flutter_client_front/common/styles/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormFieldSignup extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final fontSize = ResponsiveData.kIsMobile
        ? ResponsiveSize.M(kWTextLargeSize)
        : kWTextMiddleSize;
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? kBackgroundMainColor,
      ),
      child: Row( // 가로로 배치하기 위해 Row 위젯 사용
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (prefixIcon != null)
            Icon(
              prefixIcon,
              size: kWIconSmallSize,
              color: kSubColor,
            ),
          if (prefixIcon != null) const SizedBox(width: kWPaddingSmallSize),
          if (labelText != null)
            Container( // label text를 컨테이너로 감싸서 가운데 정렬
              width: 130, // label text의 고정된 너비
              child: Text(
                labelText!,
                style: kTextMainStyle.copyWith(fontSize: fontSize),
              ),
            ),
          SizedBox(width: contentPadding),
          Expanded( // TextFormField가 남은 공간을 채우도록 확장
            child: TextFormField(
              controller: controller,
              validator: validator,
              cursorColor: kTextMainColor,
              keyboardType: keyboardType,
              obscureText: keyboardType == TextInputType.visiblePassword,
              style: textStyle ?? kTextMainStyle.copyWith(fontSize: fontSize),
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r'\s')), // 공백 입력 방지
              ],
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.only(bottom: contentPadding),
                hintText: hintText,
                border: UnderlineInputBorder(borderSide: BorderSide(width: 1.0.w)),
                hintStyle: textStyle?.copyWith(
                  color: kTextMainColor.withOpacity(0.5),
                ) ??
                    kTextMainStyle.copyWith(
                      fontSize: fontSize,
                      color: kTextMainColor.withOpacity(0.5),
                    ),
                filled: true,
                fillColor: backgroundColor ?? kBackgroundMainColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
