import 'package:flutter/material.dart';
import 'package:flutter_client_front/auth/model/repository/auth_repository.dart';
import 'package:flutter_client_front/auth/provider/auth_provider.dart';
import 'package:flutter_client_front/signup/model/entity/member_entity.dart';
import 'package:flutter_client_front/signup/model/repository/member_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/utils/information_utils.dart';

final memberControllerProvider =
    ChangeNotifierProvider((ref) {
      final memberRepository = ref.watch(memberRepositoryProvider);
      return MemberController(memberRepository, ref);
    });

class MemberController extends ChangeNotifier{
  String? selectedMajor;
  String? selectedCircle;
  final idTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final nameTextController = TextEditingController();
  final passwordCheckTextController = TextEditingController();
  final studentNumTextController = TextEditingController();
  final phoneTextController = TextEditingController();

  final MemberRepository _memberRepository; // MemberRepository 인스턴스 필드 추가
  final Ref ref;

  MemberController(this._memberRepository, this.ref){
    notifyListeners();
  }

  Future<void> signup() async {
    notifyListeners();
    try {
      // MemberEntity 생성
      MemberEntity member = MemberEntity(
        name: nameTextController.text,
        id: idTextController.text,
        password: passwordTextController.text,
        sNumber: int.parse(studentNumTextController.text),
        major: majorListWithId[selectedMajor]!,
        circle: circleListWithId[selectedCircle]!,
        phoneNumber: phoneTextController.text,
      );

      // 회원가입 요청 보내기
      await _memberRepository.signup(member);
      print('회원가입이 성공적으로 완료되었습니다!');
    } catch (e) {
      print('회원가입 중 오류 발생: $e');
    }
  }
}
