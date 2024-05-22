import 'package:flutter/material.dart';
import 'package:flutter_client_front/auth/model/state/auth_state.dart';
import 'package:flutter_client_front/auth/viewmodel/login_viewmodel.dart';
import 'package:flutter_client_front/signup/model/entity/member_entity.dart';
import 'package:flutter_client_front/signup/model/service/member_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_client_front/common/state/state.dart';
import 'package:flutter_client_front/common/const/information_const.dart';
import 'package:flutter_client_front/common/utils/snack_bar_util.dart';
import 'package:flutter_client_front/signup/model/state/member_state.dart';

final memberViewModelProvider =
    ChangeNotifierProvider((ref) => MemberViewModel(ref));

class MemberViewModel extends ChangeNotifier {
  final Ref ref;
  late MemberState state;

  String? selectedMajor;
  String? selectedCircle;
  final idTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final nameTextController = TextEditingController();
  final passwordCheckTextController = TextEditingController();
  final studentNumTextController = TextEditingController();
  final phoneTextController = TextEditingController();
  final majorTextController = TextEditingController();
  final circleTextController = TextEditingController();
  MemberViewModel(this.ref) {
    state = ref.read(memberServiceProvider);
    ref.listen(memberServiceProvider, (previous, next) {
      if (previous != next) {
        state = next;
        if (state is ErrorState) {
          SnackBarUtil.showError((state as ErrorState).message);
        }
        notifyListeners();
      }
    });
  }
  Future getUserInfo() async {
    if (ref.read(loginViewModelProvider.notifier).state is AuthStateSuccess) {
      final loginState =
          (ref.read(loginViewModelProvider.notifier).state) as AuthStateSuccess;
      nameTextController.text = loginState.data.user_name;
      studentNumTextController.text =
          loginState.data.user_student_number.toString();
      phoneTextController.text = loginState.data.phone_number;
      majorTextController.text =
          findKeyByValue(loginState.data.major_srl, majorListWithId);
      circleTextController.text =
          findKeyByValue(loginState.data.circle_srl, circleListWithId);
      notifyListeners();
    }
  }

  void reset() {
    idTextController.clear();
    passwordTextController.clear();
    nameTextController.clear();
    passwordCheckTextController.clear();
    studentNumTextController.clear();
    phoneTextController.clear();
    majorTextController.clear();
    circleTextController.clear();
    selectedMajor = null;
    selectedCircle = null;
    notifyListeners();
  }

  Future<void> signup(BuildContext context) async {
    MemberEntity member = MemberEntity(
      name: nameTextController.text,
      id: idTextController.text,
      password: passwordTextController.text,
      sNumber: int.parse(studentNumTextController.text),
      major: majorListWithId[selectedMajor]!,
      circle: circleListWithId[selectedCircle]!,
      phoneNumber: phoneTextController.text,
    );
    await ref.read(memberServiceProvider.notifier).signup(memberEntity: member);
    if (state is MemberStateSuccess) {
      Navigator.of(context).pop();
      SnackBarUtil.showSuccess("회원가입을 완료했습니다.");
    }
  }
}
