import 'package:flutter/material.dart';
import 'package:flutter_client_front/common/component/custum_dropdownbutton_form_feld.dart';
import 'package:flutter_client_front/common/styles/colors.dart';
import 'package:flutter_client_front/signup/controller/member_controller.dart';
import 'package:flutter_client_front/signup/model/state/member_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/component/custom_text_form_field_signup.dart';
import '../../common/styles/sizes.dart';
import '../../common/styles/text_styles.dart';
import '../../common/utils/information_utils.dart';
import '../../common/utils/validation_util.dart';

class SignupView extends ConsumerStatefulWidget {
  static String get routName => 'signup';

  const SignupView({Key? key}) : super(key: key);

  @override
  ConsumerState<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends ConsumerState<SignupView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final memberController = ref.watch(memberControllerProvider);
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
                      const _SignupTitle(),
                      const SizedBox(height: kWPaddingXLargeSize),
                      CustomTextFormFieldSignup(
                        labelText: "이름",
                        hintText: '이름을 입력해주세요',
                        controller: memberController.nameTextController,
                        validator: validateMessage,
                      ),
                      const SizedBox(height: kWPaddingXLargeSize),
                      CustomTextFormFieldSignup(
                        labelText: "아이디",
                        hintText: '아이디를 입력해주세요',
                        controller: memberController.idTextController,
                        validator: validateId,
                      ),
                      const SizedBox(height: kWPaddingXLargeSize),
                      CustomTextFormFieldSignup(
                        labelText: "비밀번호",
                        hintText: '비밀번호를 입력해주세요',
                        keyboardType: TextInputType.visiblePassword,
                        controller: memberController.passwordTextController,
                        validator: validatePassword,
                      ),
                      const SizedBox(height: kWPaddingXLargeSize),
                      CustomTextFormFieldSignup(
                        labelText: "비밀번호 확인",
                        hintText: '비밀번호를 다시 입력해주세요',
                        keyboardType: TextInputType.visiblePassword,
                        controller: memberController.passwordCheckTextController,
                        validator: (value) {
                          if (value != memberController.passwordTextController.text) {
                            return "비밀번호가 일치하지 않습니다.";
                          }
                          return null;
                        }
                      ),
                      const SizedBox(height: kWPaddingXLargeSize),
                      CustomDropDownButtonFormField(memberController: memberController,
                        labelText: "전공",
                        hintText: "전공을 선택하세요",
                        list: majorListWithId,
                        value: 1,
                      ),
                      const SizedBox(height: kWPaddingXLargeSize),
                      CustomTextFormFieldSignup(
                        labelText: "학번",
                        hintText: '학번을 입력하세요',
                        controller: memberController.studentNumTextController,
                        validator: validateNumeric,
                      ),
                      const SizedBox(height: kWPaddingXLargeSize),
                      CustomDropDownButtonFormField(memberController: memberController,
                        labelText: "동아리",
                        hintText: "동아리를 선택하세요",
                        list: circleListWithId,
                        value: 2,
                      ),
                      const SizedBox(height: kWPaddingXLargeSize),
                      CustomTextFormFieldSignup(
                        labelText: "전화번호",
                        hintText: '-포함하여 입력하세요',
                        controller: memberController.phoneTextController,
                        validator: validatePhoneNumber,
                      ),
                      const SizedBox(height: kWPaddingXLargeSize),
                      if(memberController.state is! MemberStateLoading)
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            memberController.signup(context);
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
                          '회원가입',
                          style: kTextReverseStyle.copyWith(
                            fontSize: ResponsiveData.kIsMobile
                                ? ResponsiveSize.M(kWTextLargeSize)
                                : kWTextMiddleSize,
                          ),
                        ),
                      ),
                      if(memberController.state is MemberStateLoading)
                        SizedBox(
                          width: ResponsiveData.kIsMobile
                              ? ResponsiveSize.M(76)
                              : 76,
                          height: ResponsiveData.kIsMobile
                              ? ResponsiveSize.M(76)
                              : 76,
                          child:
                          const CircularProgressIndicator(color: kMainColor),
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

class _SignupTitle extends StatelessWidget {
  const _SignupTitle({Key? key}) : super(key: key);

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
                'User Signup\n- 체육시설 예약 시스템 -',
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
