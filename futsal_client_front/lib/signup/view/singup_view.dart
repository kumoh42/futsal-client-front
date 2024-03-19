import 'package:flutter/material.dart';
import 'package:flutter_client_front/common/component/custum_dropdownbutton_form_feld.dart';
import 'package:flutter_client_front/common/styles/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/component/custom_text_form_field_signup.dart';
import '../../common/styles/sizes.dart';
import '../../common/styles/text_styles.dart';
import '../../common/utils/information_utils.dart';
import '../../common/utils/validation_util.dart';
import '../viewmodel/signup_viewmodel.dart';

class SignupView extends ConsumerStatefulWidget {
  static String get routName => 'signup';

  const SignupView({Key? key}) : super(key: key);

  @override
  ConsumerState<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends ConsumerState<SignupView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(signupViewModelProvider);
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
                  //key: ,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _SignupTitle(),
                      const SizedBox(height: kWPaddingLargeSize),
                      CustomTextFormFieldSignup(
                        labelText: "이름",
                        hintText: '이름을 입력해주세요',
                        controller: viewModel.nameTextController,
                        //validator: validateId,
                      ),
                      const SizedBox(height: kWPaddingXLargeSize),
                      CustomTextFormFieldSignup(
                        labelText: "아이디",
                        hintText: '아이디를 입력해주세요',
                        controller: viewModel.idTextController,
                        validator: validateId,
                      ),
                      const SizedBox(height: kWPaddingXLargeSize),
                      CustomTextFormFieldSignup(
                        labelText: "비밀번호",
                        hintText: '비밀번호를 입력해주세요',
                        keyboardType: TextInputType.visiblePassword,
                        controller: viewModel.passwordTextController,
                        validator: validatePassword,
                      ),
                      const SizedBox(height: kWPaddingXLargeSize),
                      CustomTextFormFieldSignup(
                        labelText: "비밀번호 확인",
                        hintText: '비밀번호를 다시 입력해주세요',
                        keyboardType: TextInputType.visiblePassword,
                        controller: viewModel.passwordCheckTextController,
                        validator: validatePassword,
                      ),
                      const SizedBox(height: kWPaddingXLargeSize),
                      CustomDropDownButtonFormField(viewModel: viewModel,
                        labelText: "전공",
                        hintText: "전공을 선택하세요",
                        list: majorListWithId,
                        value: 1,
                      ),
                      const SizedBox(height: kWPaddingXLargeSize),
                      CustomTextFormFieldSignup(
                        labelText: "학번",
                        hintText: '학번을 입력하세요',
                        controller: viewModel.studentNumTextController,
                        //validator: validateId,
                      ),
                      const SizedBox(height: kWPaddingXLargeSize),
                      CustomDropDownButtonFormField(viewModel: viewModel,
                      labelText: "동아리",
                      hintText: "동아리를 선택하세요",
                      list: circleListWithId,
                        value: 2,
                      ),
                      const SizedBox(height: kWPaddingXLargeSize),
                      CustomTextFormFieldSignup(
                        labelText: "전화번호",
                        hintText: '-없이 입력하세요',
                        controller: viewModel.phoneTextController,
                        //validator: validateId,
                      ),
                      const SizedBox(height: kWPaddingXLargeSize),
                      ElevatedButton(
                        onPressed: viewModel.signup,
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
        const SizedBox(height: kWPaddingMiddleSize),
        Row(
          children: [
            Image(
              image: const AssetImage("assets/image/black_logo.png"),
              width: ResponsiveData.kIsMobile ? ResponsiveSize.M(150) : 100,
              height: ResponsiveData.kIsMobile ? ResponsiveSize.M(150) : 100,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Text(
                'Administrator Signup\n- 체육시설 예약 시스템 -',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: ResponsiveData.kIsMobile
                      ? ResponsiveSize.M(kWTextLargeSize)
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
