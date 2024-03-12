import 'package:flutter/material.dart';
import 'package:flutter_client_front/common/styles/colors.dart';
import 'package:flutter_client_front/common/styles/sizes.dart';

class StackContainer extends StatelessWidget {
  final Widget child;
  const StackContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final padding = kPaddingMiddleSize;
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        return Stack(
          children: [
            Positioned(
              top: padding * 2,
              width: width,
              height: height - padding * 4,
              child: Container(
                decoration: BoxDecoration(
                  color: kShadowColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(kBorderRadiusSize),
                  ),
                ),
              ),
            ),
            Positioned(
              top: padding,
              width: width - padding,
              height: height - padding * 2,
              child: Container(
                decoration: BoxDecoration(
                  color: kDisabledColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(kBorderRadiusSize),
                  ),
                ),
              ),
            ),
            Positioned(
              width: width - padding * 2,
              height: height,
              child: Container(
                decoration: BoxDecoration(
                  color: kBackgroundMainColor,
                  border: Border.all(color: kDisabledColor, width: 3),
                  borderRadius: BorderRadius.all(
                    Radius.circular(kBorderRadiusSize),
                  ),
                ),
                padding: EdgeInsets.all(kPaddingLargeSize),
                child: child,
              ),
            ),
          ],
        );
      },
    );
  }
}
