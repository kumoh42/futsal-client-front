import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_client_front/common/styles/colors.dart';
import 'package:flutter_client_front/common/styles/sizes.dart';
import 'package:flutter_client_front/common/styles/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultContainer extends StatelessWidget {
  final Color backgroundColor;
  final String? title;
  final List<Widget>? actions;
  final Widget body;
  final bool isExpanded;

  const DefaultContainer({
    Key? key,
    this.backgroundColor = kBackgroundMainColor,
    this.title,
    this.actions,
    this.isExpanded = false,
    required this.body,
  })  : assert(title != null || actions == null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: title == null
          ? null
          : _DefaultLayoutAppBar(title: title!, actions: actions),
      endDrawer: ResponsiveData.kIsMobile
          ? Drawer(
              child: ListView(
                children: actions
                        ?.map((e) => SizedBox(height: 50, child: e))
                        .toList() ??
                    [],
              ),
            )
          : null,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: Center(
              child: _DefaultLayoutContainer(
                margin: EdgeInsets.symmetric(
                  vertical: kPaddingMiddleSize,
                ),
                height: (isExpanded
                        ? constraints.maxHeight
                        : min(
                            ResponsiveData.kIsMobile
                                ? constraints.maxWidth * 2
                                : constraints.maxWidth * 8 / 15,
                            850)) -
                    kLayoutMarginSize * 2,
                child: body,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DefaultLayoutContainer extends Container {
  _DefaultLayoutContainer({super.margin, super.child, required double height})
      : super(
          constraints: BoxConstraints(
            maxWidth: kLayoutMaxSize,
            maxHeight: height,
          ),
          padding: EdgeInsets.symmetric(horizontal: kLayoutMarginSize),
        );
}

class _DefaultLayoutAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final Color color = kBackgroundMainColor;
  final List<Widget>? actions;

  const _DefaultLayoutAppBar({
    required this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final appbarHeight =
        ResponsiveData.kIsMobile ? kToolbarHeight - 10 : kToolbarHeight;
    return Container(
      padding: EdgeInsets.only(bottom: kPaddingSmallSize),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: kDisabledColor, width: 1.0.w)),
        color: color,
      ),
      child: Center(
        child: _DefaultLayoutContainer(
          height: appbarHeight,
          child: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: false,
            backgroundColor: color,
            titleSpacing: 0,
            leading: Transform.translate(
              offset: Offset(-7.5.w, 3.w),
              child: Image.asset(
                'assets/image/black_logo.png',
                fit: BoxFit.fitHeight,
              ),
            ),
            elevation: 0,
            title: Text(
              title,
              style: kTextMainStyle.copyWith(fontSize: kTextTitleSize),
              textAlign: ResponsiveData.kIsMobile ? TextAlign.center : null,
            ),
            actions: ResponsiveData.kIsMobile
                ? [
                    IconButton(
                      padding: EdgeInsets.zero,
                      splashRadius: kIconLargeSize / 2,
                      onPressed: () => Scaffold.of(context).openEndDrawer(),
                      icon: Icon(Icons.menu, size: kIconLargeSize),
                    )
                  ]
                : actions?.expand(_addPadding).toList(),
            foregroundColor: Colors.black,
          ),
        ),
      ),
    );
  }

  Iterable<Widget> _addPadding(Widget element) =>
      [SizedBox(width: kPaddingMiddleSize), element];

  @override
  Size get preferredSize => Size.fromHeight(
      ResponsiveData.kIsMobile ? kToolbarHeight - 10 : kToolbarHeight);
}
