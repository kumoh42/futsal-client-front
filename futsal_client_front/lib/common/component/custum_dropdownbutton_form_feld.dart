import 'package:flutter/material.dart';
import 'package:flutter_client_front/common/styles/colors.dart';
import 'package:flutter_client_front/common/styles/sizes.dart';
import 'package:flutter_client_front/signup/viewmodel/member_viewmodel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_client_front/common/styles/text_styles.dart';

class CustomDropDownButtonFormField extends StatefulWidget {
  final String labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextStyle? textStyle;
  late final double contentPadding;
  final Color? backgroundColor;
  final Map<String, int>? list;
  final MemberViewModel memberViewModel;
  final int value;

  CustomDropDownButtonFormField({
    Key? key,
    required this.labelText,
    this.hintText,
    this.prefixIcon,
    this.validator,
    this.controller,
    this.textStyle,
    double? contentPadding,
    this.backgroundColor,
    this.list,
    required this.memberViewModel,
    required this.value,
  })   : contentPadding = contentPadding ?? kWPaddingMiddleSize,
        super(key: key);

  @override
  _CustomDropDownButtonFormFieldState createState() =>
      _CustomDropDownButtonFormFieldState();
}

class _CustomDropDownButtonFormFieldState
    extends State<CustomDropDownButtonFormField> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value == 1
        ? widget.memberViewModel.selectedMajor
        : widget.memberViewModel.selectedCircle;
  }

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
          SizedBox(
            width: ResponsiveData.kIsMobile
                ? ResponsiveSize.M(180)
                : 110,
            child: Text(
              widget.labelText,
              style: kTextMainStyle.copyWith(fontSize: fontSize),
            ),
          ),
          SizedBox(width: widget.contentPadding),
          Expanded(
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                hintText: widget.hintText,
                isDense: true,
                contentPadding: EdgeInsets.only(bottom: widget.contentPadding),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(width: 1.0.w),
                ),
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
              value: _selectedValue,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedValue = newValue;
                  widget.value == 1
                      ? widget.memberViewModel.selectedMajor = newValue
                      : widget.memberViewModel.selectedCircle = newValue;
                });
              },
              items: widget.list?.keys
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '값을 선택해주세요.';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
