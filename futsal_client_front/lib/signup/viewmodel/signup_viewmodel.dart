import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_client_front/common/utils/information_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/state/state.dart';
import '../../common/utils/snack_bar_util.dart';
import '../model/service/member_service.dart';
import '../model/state/member_state.dart';

final signupViewModelProvider = ChangeNotifierProvider((ref) => SignupViewModel(ref));

class SignupViewModel extends ChangeNotifier {
  final Ref ref;
  late MemberState state;

  String? selectedMajor; // 수정된 부분
  String? selectedCircle; // 수정된 부분

  final idTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final nameTextController = TextEditingController();
  final passwordCheckTextController = TextEditingController();
  final majorTextController = TextEditingController();
  final studentNumTextController = TextEditingController();
  final clubTextController = TextEditingController();
  final phoneTextController = TextEditingController();

  final loginKey = GlobalKey<FormState>();

  SignupViewModel(this.ref) {
    state = ref.read(memberServiceProvider);
    ref.listen<MemberState>(memberServiceProvider, (previous, next) {
      if (previous != next) {
        state = next;
        if (state is ErrorState) {
          SnackBarUtil.showError((state as ErrorState).message);
        }
        notifyListeners();
      }
    });
  }

  Future<void> signup() async {
    print('Signup Info:');
    print(jsonEncode({
      'name': nameTextController.text,
      'id': idTextController.text,
      'password': passwordTextController.text,
      'studentNum': int.parse(studentNumTextController.text),
      'major': majorListWithId[selectedMajor]!,
      'club': circleListWithId[selectedCircle]!,
      'phone': int.parse(phoneTextController.text),
    }));

    if (!(loginKey.currentState?.validate() ?? false)) return;
    await ref.read(memberServiceProvider.notifier).signup(
      name: nameTextController.text,
      id: idTextController.text,
      password: passwordTextController.text,
      studentNum: int.parse(studentNumTextController.text),
      major: majorListWithId[selectedMajor]!, // 수정된 부분
      club: circleListWithId[selectedCircle]!, // 수정된 부분
      phone: int.parse(phoneTextController.text),
    );
  }

  Future<void> launch(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      SnackBarUtil.showError("$uri에 연결할 수 없습니다.");
    }
  }
}
