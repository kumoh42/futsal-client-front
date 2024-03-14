import 'package:flutter/material.dart';
import 'package:flutter_client_front/common/component/container/designed_container_title_bar.dart';
import 'package:flutter_client_front/common/styles/sizes.dart';

class BaseDialog extends StatelessWidget {
  final String title;
  final Widget child;
  const BaseDialog({
    super.key,
    required this.child,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          titlePadding: EdgeInsets.all(kPaddingXLargeSize).copyWith(bottom: 0),
          contentPadding: EdgeInsets.all(kPaddingXLargeSize).copyWith(top: 0),
          title: DesignedContainerTitleBar(
            title: title,
            actions: [
              IconButton(
                onPressed: () {
                  if (context.mounted) Navigator.of(context).pop();
                },
                icon: Icon(Icons.close, size: kIconMiddleSize),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                splashRadius: kIconMiddleSize / 1.2,
              )
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(kBorderRadiusSize)),
          ),
          content: child,
        ),
      ),
    );
  }
}
