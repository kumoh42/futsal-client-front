import 'package:flutter/material.dart';
import 'package:flutter_client_front/common/styles/sizes.dart';

class ResponsiveDivider extends StatelessWidget {
  const ResponsiveDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveData.kIsMobile ? const Divider() : const VerticalDivider();
  }
}

class ResponsiveSizedBox extends StatelessWidget {
  final double size;

  const ResponsiveSizedBox({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(width: size, height: size);
}

class ResponsiveWidget extends StatelessWidget {
  final int? mFlex;
  final int? wFlex;
  final Widget child;

  const ResponsiveWidget({
    Key? key,
    this.mFlex,
    this.wFlex,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => child;
}

class ResponsiveContainer extends StatelessWidget {
  final List<Widget> children;

  const ResponsiveContainer({
    Key? key,
    required this.children,
  }) : super(key: key);

  Widget M(Widget widget) {
    if (widget is ResponsiveWidget) {
      int? flex = ResponsiveData.kIsMobile ? widget.mFlex : widget.wFlex;
      if (flex == null) return widget;
      return Expanded(flex: flex, child: widget);
    }
    if (widget is ResponsiveSizedBox) {
      return SizedBox(
        width: ResponsiveData.kIsMobile ? 0 : widget.size,
        height: ResponsiveData.kIsMobile ? widget.size : 0,
      );
    }
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    final children = this.children.map(M).toList();
    return ResponsiveData.kIsMobile
        ? Column(children: children)
        : Row(crossAxisAlignment: CrossAxisAlignment.start, children: children);
  }
}
