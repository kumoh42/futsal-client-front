import 'package:flutter/material.dart';
import 'package:flutter_client_front/auth/provider/auth_provider.dart';
import 'package:flutter_client_front/common/state/state.dart';
import 'package:flutter_client_front/common/utils/snack_bar_util.dart';
import 'package:flutter_client_front/signup/model/entity/member_edit_entity.dart';
import 'package:flutter_client_front/signup/model/service/member_info_service.dart';
import 'package:flutter_client_front/signup/model/state/member_info_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final memberInfoViewModelProvider =
    ChangeNotifierProvider((ref) => MemberInfoViewModel(ref));

class MemberInfoViewModel extends ChangeNotifier {
  final Ref ref;
  late MemberInfoState state;
  MemberInfoViewModel(this.ref) {
    state = ref.read(memberInfoServiceProvider);
    ref.listen(memberInfoServiceProvider, (previous, next) {
      if (previous != next) {
        state = next;
        if (state is ErrorState) {
          SnackBarUtil.showError((state as ErrorState).message);
        }
        notifyListeners();
      }
    });
  }
  void getMemberInfo() async {
    await ref.read(memberInfoServiceProvider.notifier).getMemberInfo();
  }

  void editMemberInfo({
    required String name,
    required String phoneNumber,
    required int sNumber,
    required BuildContext context,
  }) async {
    await ref
        .read(memberInfoServiceProvider.notifier)
        .editMemberInfo(MemberEditEntity(
          name: name,
          phoneNumber: phoneNumber,
          sNumber: sNumber,
        ));
    Navigator.of(context).pop();
    SnackBarUtil.showSuccess("정보를 수정하였습니다. 다시 로그인 해주세요");
    ref.read(authProvider).logout();
  }
}
