import 'package:flutter/material.dart';
import 'package:flutter_client_front/auth/provider/auth_provider.dart';
import 'package:flutter_client_front/common/component/default_container.dart';
import 'package:flutter_client_front/common/component/tab_button.dart';
import 'package:flutter_client_front/common/const/tabs.dart';
import 'package:flutter_client_front/common/styles/sizes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final rootTabIndexProvider = StateProvider((ref) => 0);

class RootTab extends ConsumerStatefulWidget {
  static String get routeName => 'home';

  const RootTab({Key? key}) : super(key: key);

  @override
  ConsumerState<RootTab> createState() => _RootTabState();
}

class _RootTabState extends ConsumerState<RootTab>
    with TickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(
      length: TABS.length,
      animationDuration: Duration.zero,
      vsync: this,
      initialIndex: ref.read(rootTabIndexProvider),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      rootTabIndexProvider,
      (previous, next) => controller.animateTo(next),
    );
    return DefaultContainer(
      title: "풋살장 예약 시스템 관리자 페이지",
      actions: [
        ...TABS.map((e) => TabButton(tabInfo: e)),
        Tooltip(
          message: "로그아웃",
          child: IconButton(
            padding: EdgeInsets.zero,
            splashRadius: kIconLargeSize / 2,
            onPressed: () => ref.read(authProvider.notifier).logout(),
            icon: Icon(Icons.person, size: kIconLargeSize),
          ),
        )
      ],
      body: TabBarView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: TABS.map((e) => e.tab).toList(),
      ),
    );
  }
}
