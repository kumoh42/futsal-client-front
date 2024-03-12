import 'package:flutter/material.dart';
import 'package:flutter_client_front/common/styles/colors.dart';
import 'package:flutter_client_front/common/styles/sizes.dart';
import 'package:flutter_client_front/common/styles/text_styles.dart';

class DesignedContainerTitleBar extends StatelessWidget {
  final String title;
  final List<Widget>? actions;

  const DesignedContainerTitleBar({
    Key? key,
    required this.title,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: kPaddingSmallSize),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: kDisabledColor, width: 1.0)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: kTextMainStyle.copyWith(fontSize: kTextLargeSize),
            ),
          ),
          ...actions ?? [],
        ],
      ),
    );
  }
}
