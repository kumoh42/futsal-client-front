import 'package:flutter/material.dart';
import 'package:flutter_client_front/common/const/tabs.dart';
import 'package:flutter_client_front/common/styles/colors.dart';
import 'package:flutter_client_front/common/styles/sizes.dart';
import 'package:flutter_client_front/common/styles/text_styles.dart';
import 'package:flutter_client_front/common/view/root_tab.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabButton extends ConsumerWidget {
  final TabInfo tabInfo;

  const TabButton({
    Key? key,
    required this.tabInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(rootTabIndexProvider);
    return TextButton(
      onPressed: () {
        ref.read(rootTabIndexProvider.notifier).state = TABS.indexOf(tabInfo);
        if (ResponsiveData.kIsMobile) Navigator.of(context).pop();
      },
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: TABS[currentIndex] == tabInfo
            ? LinearBorder.bottom(
                side: const BorderSide(color: kTextMainColor, width: 2.0),
              )
            : null,
      ),
      child: Text(
        tabInfo.label,
        style: TABS[currentIndex] == tabInfo
            ? kTextMainStyle.copyWith(fontSize: kTextMiddleSize)
            : kTextMainStyle.copyWith(
                fontSize: kTextMiddleSize,
                color: kDisabledColor,
              ),
      ),
    );
  }
}
