import 'package:flutter/material.dart';
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
  }
  void getMemberInfo() async {
    await ref.read(memberInfoServiceProvider.notifier).getMemberInfo();
  }
}
