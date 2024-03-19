import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_client_front/auth/model/state/auth_state.dart';
import 'package:flutter_client_front/auth/view/login_view.dart';
import 'package:flutter_client_front/auth/viewmodel/login_viewmodel.dart';
import 'package:flutter_client_front/common/component/container/responsive_container.dart';
import 'package:flutter_client_front/common/styles/colors.dart';
import 'package:flutter_client_front/common/styles/sizes.dart';
import 'package:flutter_client_front/common/styles/text_styles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

class _DefaultLayoutAppBar extends ConsumerWidget
    implements PreferredSizeWidget {
  final String title;
  final Color color = kBackgroundMainColor;
  final List<Widget>? actions;

  const _DefaultLayoutAppBar({
    required this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appbarHeight =
        ResponsiveData.kIsMobile ? kToolbarHeight - 10 : kToolbarHeight;
    final viewModel = ref.watch(loginViewModelProvider);
    return Container(
      padding: EdgeInsets.only(bottom: kPaddingSmallSize),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: kDisabledColor, width: 1.0.w)),
        color: color,
      ),
      child: Center(
        child: _DefaultLayoutContainer(
          height: appbarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Transform.translate(
                    offset: Offset(-7.5.w, 3.w),
                    child: Image.asset(
                      'assets/image/black_logo.png',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  ResponsiveSizedBox(size: kPaddingSmallSize),
                  Padding(
                    padding: EdgeInsets.only(
                      top: kPaddingSmallSize / 2,
                    ),
                    child: Text(
                      viewModel.state is AuthStateSuccess
                          ? "반갑습니다 김정현님!"
                          : "풋살장 사용자 페이지",
                      style: kTextMainStyle.copyWith(fontSize: kTextTitleSize),
                      textAlign:
                          ResponsiveData.kIsMobile ? TextAlign.center : null,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  if (viewModel.state is! AuthStateSuccess)
                    Transform.translate(
                      offset: Offset(-7.5.w, 3.w),
                      child: TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const Dialog(
                                surfaceTintColor: Colors.transparent,
                                backgroundColor: kBackgroundMainColor,
                                child: SizedBox(
                                  width: 500,
                                  height: 500,
                                  child: LoginView(),
                                ),
                              );
                            },
                          );
                        },
                        child: Text(
                          "로그인",
                          style: kTextMainStyle.copyWith(
                            fontSize: kTextLargeSize,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  if (viewModel.state is AuthStateSuccess)
                    PopupMenuButton(
                      tooltip: "사용자 설정",
                      iconSize: kIconLargeSize,
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem(
                          onTap: () {},
                          child: Text(
                            "내 정보 수정",
                            style: kTextMainStyle.copyWith(
                                fontSize: kTextMiddleSize),
                          ),
                        ),
                        PopupMenuItem(
                          child: Text(
                            "로그아웃",
                            style: kTextMainStyle.copyWith(
                                fontSize: kTextMiddleSize),
                          ),
                          onTap: () => viewModel.logout(),
                        ),
                      ],
                      icon: const Icon(Icons.person),
                    ),
                ],
              ),
            ],
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
