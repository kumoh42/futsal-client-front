import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../common/state/state.dart';
import '../service/member_service.dart';
import '../state/member_state.dart';


final memberProvider =
ChangeNotifierProvider<MemberProvider>((ref) => MemberProvider(ref: ref));

class MemberProvider extends ChangeNotifier {
  final Ref ref;

  MemberProvider({
    required this.ref,
  }) {
    ref.listen<MemberState>(memberServiceProvider, (previous, next) {
      if (previous != next) notifyListeners();
    });
  }

  String? redirectLogic(BuildContext context, GoRouterState state) {
    final MemberState memberState = ref.read(memberServiceProvider);
    final isLoginScreen = state.location == 'signup';

    if (memberState is NoneState) {
      return isLoginScreen ? null : '/signup';
    }

    if (memberState is SuccessState) {
      return isLoginScreen || state.location == '/splash' ? '/' : null;
    }

    if (memberState is ErrorState) {
      return !isLoginScreen ? '/signup' : null;
    }

    return null;
  }
}
