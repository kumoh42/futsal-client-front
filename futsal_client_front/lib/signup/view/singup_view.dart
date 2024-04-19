import 'package:flutter/material.dart';
import 'package:flutter_client_front/auth/viewmodel/login_viewmodel.dart';
import 'package:flutter_client_front/common/component/custum_dropdownbutton_form_feld.dart';
import 'package:flutter_client_front/common/styles/colors.dart';
import 'package:flutter_client_front/signup/model/state/member_info_state.dart';
import 'package:flutter_client_front/signup/model/state/member_state.dart';
import 'package:flutter_client_front/signup/viewmodel/member_info_viewmodel.dart';
import 'package:flutter_client_front/signup/viewmodel/member_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_client_front/common/component/custom_text_form_field_signup.dart';
import 'package:flutter_client_front/common/styles/sizes.dart';
import 'package:flutter_client_front/common/styles/text_styles.dart';
import 'package:flutter_client_front/common/const/information_const.dart';
import 'package:flutter_client_front/common/utils/validation_util.dart';

class SignupView extends ConsumerStatefulWidget {
  static String get routName => 'signup';
  final bool isSignup;
  const SignupView({
    Key? key,
    this.isSignup = true,
  }) : super(key: key);

  @override
  ConsumerState<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends ConsumerState<SignupView> {
  @override
  void initState() {
    super.initState();
    if (!widget.isSignup) {
      Future(() => ref.read(memberViewModelProvider.notifier).getUserInfo());
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final memberViewModel = ref.watch(memberViewModelProvider);
    final memberInfoViewModel = ref.watch(memberInfoViewModelProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: kBackgroundMainColor,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: kBackgroundMainColor,
                borderRadius: BorderRadius.circular(kBorderRadiusSize),
              ),
              constraints: ResponsiveData.kIsMobile
                  ? BoxConstraints(
                      maxWidth: ResponsiveSize.M(750),
                      //maxHeight: ResponsiveSize.M(750),
                    )
                  : const BoxConstraints(
                      maxWidth: 550, maxHeight: double.infinity),
              child: Padding(
                padding: EdgeInsets.all(
                  ResponsiveData.kIsMobile
                      ? ResponsiveSize.S(kWPaddingXLargeSize)
                      : kWPaddingXLargeSize,
                ).copyWith(top: 0),
                child: Form(
                  key: _formKey, // GlobalKey 설정
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _SignupTitle(isSignup: widget.isSignup),
                      const SizedBox(height: kWPaddingXLargeSize),
                      CustomTextFormFieldSignup(
                        labelText: "이름",
                        hintText: '이름을 입력해주세요',
                        controller: memberViewModel.nameTextController,
                        validator: validateMessage,
                      ),
                      if (widget.isSignup)
                        const SizedBox(height: kWPaddingXLargeSize),
                      if (widget.isSignup)
                        CustomTextFormFieldSignup(
                          labelText: "아이디",
                          hintText: '아이디를 입력해주세요',
                          controller: memberViewModel.idTextController,
                          validator: validateId,
                        ),
                      if (widget.isSignup)
                        const SizedBox(height: kWPaddingXLargeSize),
                      if (widget.isSignup)
                        CustomTextFormFieldSignup(
                          labelText: "비밀번호",
                          hintText: '비밀번호를 입력해주세요',
                          keyboardType: TextInputType.visiblePassword,
                          controller: memberViewModel.passwordTextController,
                          validator: validatePassword,
                        ),
                      if (widget.isSignup)
                        const SizedBox(height: kWPaddingXLargeSize),
                      if (widget.isSignup)
                        CustomTextFormFieldSignup(
                            labelText: "비밀번호 확인",
                            hintText: '비밀번호를 다시 입력해주세요',
                            keyboardType: TextInputType.visiblePassword,
                            controller:
                                memberViewModel.passwordCheckTextController,
                            validator: (value) {
                              if (value !=
                                  memberViewModel.passwordTextController.text) {
                                return "비밀번호가 일치하지 않습니다.";
                              }
                              return null;
                            }),
                      const SizedBox(height: kWPaddingXLargeSize),
                      if (!widget.isSignup)
                        infoRow("전공", memberViewModel.majorTextController.text),
                      if (widget.isSignup)
                        CustomDropDownButtonFormField(
                          memberViewModel: memberViewModel,
                          labelText: "전공",
                          hintText: "전공을 선택하세요",
                          list: majorListWithId,
                          value: 1,
                        ),
                      const SizedBox(height: kWPaddingXLargeSize),
                      CustomTextFormFieldSignup(
                        labelText: "학번",
                        hintText: '학번을 입력하세요',
                        controller: memberViewModel.studentNumTextController,
                        validator: validateNumeric,
                      ),
                      const SizedBox(height: kWPaddingXLargeSize),
                      if (!widget.isSignup)
                        infoRow(
                            "동아리", memberViewModel.circleTextController.text),
                      if (widget.isSignup)
                        CustomDropDownButtonFormField(
                          memberViewModel: memberViewModel,
                          labelText: "동아리",
                          hintText: "동아리를 선택하세요",
                          list: circleListWithId,
                          value: 2,
                        ),
                      const SizedBox(height: kWPaddingXLargeSize),
                      CustomTextFormFieldSignup(
                        labelText: "전화번호",
                        hintText: '-포함하여 입력하세요',
                        controller: memberViewModel.phoneTextController,
                        validator: validatePhoneNumber,
                      ),
                      const SizedBox(height: kWPaddingXLargeSize),
                      if ((memberViewModel.state is! MemberStateLoading) &&
                          (memberInfoViewModel.state
                              is! MemeberInfoStateLoading))
                        ElevatedButton(
                          onPressed: () {
                            if (widget.isSignup) {
                              if (_formKey.currentState!.validate()) {
                                memberViewModel.signup(context);
                              }
                            } else {
                              if (_formKey.currentState!.validate()) {
                                memberInfoViewModel.editMemberInfo(
                                  name: memberViewModel.nameTextController.text,
                                  phoneNumber:
                                      memberViewModel.phoneTextController.text,
                                  sNumber: int.parse(memberViewModel
                                      .studentNumTextController.text),
                                  context: context,
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kMainColor,
                            minimumSize: Size(
                              ResponsiveData.kIsMobile
                                  ? ResponsiveSize.M(200)
                                  : 176,
                              ResponsiveData.kIsMobile
                                  ? ResponsiveSize.M(80)
                                  : 60,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                kWBorderRadiusSize,
                              ),
                            ),
                          ),
                          child: Text(
                            widget.isSignup ? '회원가입' : '수정',
                            style: kTextReverseStyle.copyWith(
                              fontSize: ResponsiveData.kIsMobile
                                  ? ResponsiveSize.M(kWTextLargeSize)
                                  : kWTextMiddleSize,
                            ),
                          ),
                        ),
                      if ((memberViewModel.state is MemberStateLoading) ||
                          (memberInfoViewModel.state
                              is MemeberInfoStateLoading))
                        SizedBox(
                          width: ResponsiveData.kIsMobile
                              ? ResponsiveSize.M(76)
                              : 76,
                          height: ResponsiveData.kIsMobile
                              ? ResponsiveSize.M(76)
                              : 76,
                          child: const CircularProgressIndicator(
                              color: kMainColor),
                        )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget infoRow(String key, String value) {
  final fontSize = ResponsiveData.kIsMobile
      ? ResponsiveSize.M(kWTextLargeSize)
      : kWTextSmallSize;

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(
        width: ResponsiveData.kIsMobile ? ResponsiveSize.M(180) : 110,
        child: Text(
          key,
          style: kTextMainStyle.copyWith(
            fontSize: fontSize,
          ),
        ),
      ),
      SizedBox(width: kPaddingMiddleSize),
      Expanded(
          child: Text(
        value,
        style: kTextMainStyle.copyWith(fontSize: fontSize),
      ))
    ],
  );
}

class _SignupTitle extends StatelessWidget {
  final bool isSignup;
  const _SignupTitle({
    Key? key,
    this.isSignup = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: kWPaddingLargeSize),
        Row(
          children: [
            Image(
              image: const AssetImage("assets/image/black_logo.png"),
              width: ResponsiveData.kIsMobile ? ResponsiveSize.M(130) : 100,
              height: ResponsiveData.kIsMobile ? ResponsiveSize.M(130) : 100,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Text(
                isSignup ? 'User Signup\n- 체육시설 예약 시스템 -' : '회원 정보 수정',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: ResponsiveData.kIsMobile
                      ? ResponsiveSize.M(kWTextTitleSize)
                      : kWTextMiddleSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
