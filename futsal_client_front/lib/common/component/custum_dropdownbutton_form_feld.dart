import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_client_front/common/styles/colors.dart';
import 'package:flutter_client_front/common/styles/sizes.dart';
import 'package:flutter_client_front/common/styles/text_styles.dart';
import 'package:flutter_client_front/signup/controller/member_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDownButtonFormField extends StatelessWidget {
  final String labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextStyle? textStyle;
  late final double contentPadding;
  final Color? backgroundColor;
  final Map<String, int>? list;
  final MemberController memberController;
  final int value;

  CustomDropDownButtonFormField(
      {Key? key,
      required this.labelText,
      this.hintText,
      this.prefixIcon,
      this.keyboardType = TextInputType.text,
      this.validator,
      this.controller,
      this.textStyle,
      double? contentPadding,
      this.backgroundColor,
      this.list,
      required this.memberController,
      required this.value})
      : super(key: key) {
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
      child: Row(
        // 가로로 배치하기 위해 Row 위젯 사용
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (prefixIcon != null)
            Icon(
              prefixIcon,
              size: kWIconSmallSize,
              color: kSubColor,
            ),
          if (prefixIcon != null) const SizedBox(width: kWPaddingSmallSize),
          Container(
            // label text를 컨테이너로 감싸서 가운데 정렬
            width: 130, // label text의 고정된 너비
            child: Text(
              labelText!,
              style: kTextMainStyle.copyWith(fontSize: fontSize),
            ),
          ),
          SizedBox(width: contentPadding),
          Expanded(
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                hintText: hintText,
                isDense: true,
                // TextFormField와 같이 밀집된 모양으로 만들기 위해 추가
                contentPadding: EdgeInsets.only(bottom: contentPadding),
                // TextFormField와 같은 패딩 설정
                border:
                    UnderlineInputBorder(borderSide: BorderSide(width: 1.0.w)),
                // TextFormField와 같은 border 설정
                hintStyle: textStyle?.copyWith(
                      color: kTextMainColor.withOpacity(0.5),
                    ) ??
                    kTextMainStyle.copyWith(
                      fontSize: fontSize,
                      color: kTextMainColor.withOpacity(0.5),
                    ),
                // TextFormField와 같은 hintStyle 설정
                filled: true,
                // TextFormField와 같이 배경색 채우기
                fillColor: backgroundColor ??
                    kBackgroundMainColor, // TextFormField와 같은 배경색 설정
              ),
              value: value == 1 ? memberController.selectedMajor : memberController.selectedCircle,
              onChanged: (String? newValue) {
                value == 1 ? memberController.selectedMajor = newValue!: memberController.selectedCircle = newValue!;
              },
              items: list?.keys.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
