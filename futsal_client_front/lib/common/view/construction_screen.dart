import 'package:flutter/material.dart';
import 'package:flutter_client_front/common/component/default_container.dart';
import 'package:flutter_client_front/common/styles/sizes.dart';
import 'package:flutter_client_front/common/styles/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConstructionScreen extends StatelessWidget {
  const ConstructionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultContainer(
      isExpanded: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/image/black_logo.png",
            width: 300.w,
            height: 300.w,
          ),
          Text(
            "해당 기능은 공사중 입니다.\n빠른시일 내에 오픈하겠습니다.",
            style: kTextMainStyle.copyWith(fontSize: kTextLargeSize),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: kPaddingXLargeSize),
        ],
      ),
    );
  }
}
