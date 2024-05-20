import 'package:flutter/material.dart';
import 'package:flutter_client_front/auth/model/state/auth_state.dart';
import 'package:flutter_client_front/auth/viewmodel/login_viewmodel.dart';
import 'package:flutter_client_front/common/component/custom_text_button.dart';
import 'package:flutter_client_front/common/component/custom_text_form_field.dart';
import 'package:flutter_client_front/common/state/state.dart';
import 'package:flutter_client_front/common/styles/colors.dart';
import 'package:flutter_client_front/common/styles/sizes.dart';
import 'package:flutter_client_front/common/styles/text_styles.dart';
import 'package:flutter_client_front/common/utils/validation_util.dart';
import 'package:flutter_client_front/signup/view/singup_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginView extends ConsumerStatefulWidget {
  static String get routeName => 'login';

  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(loginViewModelProvider);

    void attemptLogin() async {
      await viewModel.login();
      if (viewModel.state is AuthStateSuccess) {
        Navigator.of(context).pop();
      }
    }

    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: kBackgroundMainColor,
          borderRadius: BorderRadius.circular(kBorderRadiusSize),
        ),
        constraints: ResponsiveData.kIsMobile
            ? BoxConstraints(
                maxWidth: ResponsiveSize.M(750),
                maxHeight: ResponsiveSize.M(750),
              )
            : const BoxConstraints(maxWidth: 500, maxHeight: 500),
        child: Padding(
          padding: EdgeInsets.all(
            ResponsiveData.kIsMobile
                ? ResponsiveSize.S(kWPaddingXLargeSize)
                : kWPaddingXLargeSize,
          ).copyWith(top: 0),
          child: Form(
            key: viewModel.loginKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                vertical: ResponsiveData.kIsMobile
                    ? ResponsiveSize.S(kWPaddingLargeSize)
                    : kWPaddingLargeSize,
                horizontal: ResponsiveData.kIsMobile
                    ? ResponsiveSize.S(kWPaddingXLargeSize)
                    : kWPaddingXLargeSize,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const _Title(),
                  const SizedBox(height: kWPaddingLargeSize),
                  CustomTextFormField(
                    labelText: "아이디",
                    hintText: '아이디를 입력해주세요',
                    controller: viewModel.idTextController,
                    validator: validateId,
                    onFieldSubmitted: (value) => attemptLogin(),
                  ),
                  const SizedBox(height: kWPaddingLargeSize),
                  CustomTextFormField(
                    labelText: "비밀번호",
                    hintText: '비밀번호를 입력해주세요',
                    keyboardType: TextInputType.visiblePassword,
                    controller: viewModel.passwordTextController,
                    validator: validatePassword,
                    onFieldSubmitted: (value) => attemptLogin(),
                  ),
                  const SizedBox(height: kWPaddingXLargeSize),
                  if (viewModel.state is LoadingState)
                    SizedBox(
                      width:
                          ResponsiveData.kIsMobile ? ResponsiveSize.M(76) : 76,
                      height:
                          ResponsiveData.kIsMobile ? ResponsiveSize.M(76) : 76,
                      child: const CircularProgressIndicator(color: kMainColor),
                    )
                  else
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              CustomTextButton(
                                onPressed: () {
                                  // TODO 관리자에게 문의
                                },
                                text: '관리자에게 문의하기',
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(height: kWPaddingSmallSize),
                              CustomTextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const SignupView(),
                                    ),
                                  );
                                },
                                text: '회원가입',
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(height: kWPaddingSmallSize),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: attemptLogin,
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
                            '로그인',
                            style: kTextReverseStyle.copyWith(
                              fontSize: ResponsiveData.kIsMobile
                                  ? ResponsiveSize.M(kWTextLargeSize)
                                  : kWTextMiddleSize,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image(
          image: const AssetImage("assets/image/black_logo.png"),
          width: ResponsiveData.kIsMobile ? ResponsiveSize.M(150) : 100,
          height: ResponsiveData.kIsMobile ? ResponsiveSize.M(150) : 100,
          fit: BoxFit.cover,
        ),
        Expanded(
          child: Text(
            'User Login\n- 체육시설 예약 시스템 -',
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
    );
  }
}
