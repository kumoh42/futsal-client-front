import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_client_front/signup/model/entity/member_entity.dart';
import 'package:flutter_client_front/signup/model/service/member_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/state/state.dart';
import '../../common/utils/information_utils.dart';
import '../../common/utils/snack_bar_util.dart';
import '../model/state/member_state.dart';

final memberControllerProvider =
ChangeNotifierProvider((ref) => MemberController(ref));

class MemberController extends ChangeNotifier{
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


  MemberController(this.ref){
    state = ref.read(memberServiceProvider);
    ref.listen(memberServiceProvider, (previous, next) {
      if(previous != next) {
        state = next;
        if(state is ErrorState) {
          SnackBarUtil.showError((state as ErrorState).message);
        }
        notifyListeners();
      }
    });
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
      if(state is MemberStateSuccess) {
        Navigator.of(context).pop();
      }
  }
}
