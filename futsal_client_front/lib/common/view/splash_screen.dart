import 'package:flutter/material.dart';
import 'package:flutter_client_front/common/component/default_container.dart';
import 'package:flutter_client_front/common/styles/colors.dart';
import 'package:flutter_client_front/common/styles/sizes.dart';

class SplashScreen extends StatelessWidget {
  static String get routeName => 'splash';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultContainer(
      isExpanded: true,
      backgroundColor: kMainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/image/white_logo.png',
            width: ResponsiveSize.S(500),
          ),
          SizedBox(height: kPaddingLargeSize),
          SizedBox(
            width: ResponsiveSize.S(100),
            height: ResponsiveSize.S(100),
            child: const CircularProgressIndicator(color: kTextReverseColor),
          ),
        ],
      ),
    );
  }
}
