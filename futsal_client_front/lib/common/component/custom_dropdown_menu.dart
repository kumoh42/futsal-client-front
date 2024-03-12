import 'package:flutter/material.dart';
import 'package:flutter_client_front/common/styles/sizes.dart';
import 'package:flutter_client_front/common/styles/text_styles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomDropDownMenu extends ConsumerStatefulWidget {
  late final ChangeNotifierProvider<CustomDropDownMenuController> provider;
  final String title;
  final TextStyle? menuTextStyle;
  final TextStyle? titleTextStyle;

  CustomDropDownMenu({
    super.key,
    required CustomDropDownMenuController controller,
    required this.title,
    this.menuTextStyle,
    this.titleTextStyle,
  }) {
    provider = ChangeNotifierProvider((ref) => controller);
  }

  @override
  ConsumerState<CustomDropDownMenu> createState() => _CustomDropDownMenuState();
}

class _CustomDropDownMenuState extends ConsumerState<CustomDropDownMenu> {
  late CustomDropDownMenuController controller;

  @override
  Widget build(BuildContext context) {
    controller = ref.watch(widget.provider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          widget.title,
          style: widget.titleTextStyle ??
              kTextDisabledStyle.copyWith(
                fontSize: kTextMiniSize,
                fontWeight: FontWeight.w600,
              ),
        ),
        DropdownButton(
          borderRadius: BorderRadius.circular(10),
          isExpanded: true,
          value: controller.selected,
          items: controller.menuList
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e,
                    style: widget.menuTextStyle ??
                        kTextMainStyle.copyWith(
                          fontSize: kTextMiddleSize,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
              .toList(),
          onChanged: (value) {
            controller.onChanged(value as String);
          },
        )
      ],
    );
  }
}

class CustomDropDownMenuController extends ChangeNotifier {
  final List<String> menuList;
  late String selected;
  CustomDropDownMenuController({
    required this.menuList,
    this.selected = "",
  }) {
    if (!menuList.contains(selected)) {
      selected = menuList[0];
    }
  }
  void onChanged(String value) {
    selected = value;
    notifyListeners();
  }
}
