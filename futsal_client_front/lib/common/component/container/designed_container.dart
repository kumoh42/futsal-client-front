import 'package:flutter/material.dart';
import 'package:flutter_client_front/common/styles/colors.dart';
import 'package:flutter_client_front/common/styles/sizes.dart';

import 'designed_container_title_bar.dart';

class DesignedContainer extends StatelessWidget {
  final String title;
  final List<Widget>? actions;
  final bool isChildInfinity;
  final Widget child;

  const DesignedContainer({
    Key? key,
    required this.title,
    this.actions,
    required this.child,
    this.isChildInfinity = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kBackgroundMainColor,
        border: Border.all(color: kDisabledColor, width: 3),
        borderRadius: BorderRadius.all(Radius.circular(kBorderRadiusSize)),
      ),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(kBorderRadiusSize)),
        child: Padding(
          padding: EdgeInsets.all(kPaddingLargeSize),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DesignedContainerTitleBar(title: title, actions: actions),
              SizedBox(height: kPaddingMiddleSize),
              isChildInfinity ? Expanded(child: child) : child,
            ],
          ),
        ),
      ),
    );
  }
}
