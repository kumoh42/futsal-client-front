import 'package:flutter/material.dart';
import 'package:flutter_client_front/auth/model/service/auth_service.dart';
import 'package:flutter_client_front/auth/model/state/auth_state.dart';
import 'package:flutter_client_front/common/state/state.dart';
import 'package:flutter_client_front/common/utils/snack_bar_util.dart';
import 'package:flutter_client_front/signup/model/service/member_info_service.dart';
import 'package:flutter_client_front/signup/model/state/member_info_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

final loginViewModelProvider =
    ChangeNotifierProvider((ref) => LoginViewModel(ref));

class LoginViewModel extends ChangeNotifier {
  final Ref ref;
  late AuthState state;
  late MemberInfoState memberInfoState;
  final idTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  final loginKey = GlobalKey<FormState>();

  LoginViewModel(this.ref) {
    state = ref.read(authServiceProvider);
    memberInfoState = ref.watch(memberInfoServiceProvider);
    ref.listen<AuthState>(authServiceProvider, (previous, next) {
      if (previous != next) {
        state = next;
        if (state is ErrorState) {
          SnackBarUtil.showError((state as ErrorState).message);
        }
        notifyListeners();
      }
    });
  }

  Future login(BuildContext context) async {
    if (!(loginKey.currentState?.validate() ?? false)) return;
    await ref.read(authServiceProvider.notifier).login(
          id: idTextController.text,
          password: passwordTextController.text,
        );
    if (state is AuthStateSuccess) {
      Navigator.of(context).pop();
    }
  }

  Future logout() async {
    await ref.read(authServiceProvider.notifier).logout();
  }

  Future<void> launch(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      SnackBarUtil.showError("$uri에 연결할 수 없습니다.");
    }
  }
}
