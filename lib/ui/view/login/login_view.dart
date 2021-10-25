// import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/ui/dumb_widgets/buttons.dart';
import 'package:sub_track/ui/dumb_widgets/text_fields.dart';
import 'package:sub_track/ui/dumb_widgets/textfield_outline.dart';
import 'package:sub_track/ui/resources/resources.dart';

import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/ui/theme/app_colors.dart';
import 'package:sub_track/ui/view/login/login_view.formx.dart';
import './login_viewmodel.dart';

class LoginView extends ConsumerStatefulWidget {
  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> with $LoginView {
  @override
  void initState() {
    super.initState();
    listenToFormUpdated();
  }

  @override
  void dispose() {
    super.dispose();
    disposeForm();
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.read(loginViewModelCNP);
    final emailTextFieldType = ref
        .watch(loginViewModelCNP.select((value) => value.emailTextFieldType));
    final passwordTextFieldType = ref.watch(
        loginViewModelCNP.select((value) => value.passwordTextFieldType));
    return CupertinoPageScaffold(
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: screenHeight(context),
                width: screenWidth(context) * 0.35,
                color: AppColor.STPureWhite.withOpacity(0.5),
              ),
            ],
          ),
          Center(
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Welcome back!",
                            style: kTitleStyle.copyWith(
                              color: AppColor.STDark,
                            ),
                          ),
                          Text(
                            "Use your credentials below and login \nto your account",
                            style: kMediumStyle.copyWith(
                              color: AppColor.STDarkLight,
                            ),
                          ),
                        ],
                      ),
                      verticalSpaceMedium,
                      STTextFieldOutline(
                        title: "Email",
                        icon: Icons.email_outlined,
                        child: STTextField(
                          placeholder: "yourname@something.com",
                          type: emailTextFieldType,
                          controller: emailController,
                          focusNode: emailFocusNode,
                          nextFocusNode: passwordFocusNode,
                        ),
                      ),
                      verticalSpaceRegular,
                      STTextFieldOutline(
                        title: "Password",
                        icon: Icons.lock_outline_rounded,
                        child: STTextField(
                          placeholder: "********",
                          type: passwordTextFieldType,
                          controller: passwordController,
                          obscureText: true,
                          focusNode: passwordFocusNode,
                          onSubmitted: (_) => model.saveData(),
                        ),
                      ),
                      verticalSpaceSmall,
                      GestureDetector(
                        onTap: model.forgotPassword,
                        child: Text(
                          "Forgot Password?",
                          style: kLinkStyle,
                        ),
                      ),
                      verticalSpaceMedium,
                      Row(
                        children: [
                          Expanded(
                            child: STButton(
                              onPressed: model.saveData,
                              buttonText: "Login to my account",
                            ),
                          ),
                        ],
                      ),
                      verticalSpaceSmall,
                      verticalSpaceSmall,
                      Row(
                        children: [
                          if ((GetPlatform.isIOS || GetPlatform.isMacOS))
                            Expanded(
                              child: STButton(
                                buttonType: ButtonType.TERTIARY,
                                onPressed: model.useAppleAuthentication,
                                icon: Image.asset(
                                  AppIconsAssets.apple,
                                  color: Colors.black,
                                ),
                                buttonText: "Apple",
                              ),
                            ),
                          if ((GetPlatform.isIOS || GetPlatform.isMacOS))
                            horizontalSpaceRegular,
                          Expanded(
                            child: STButton(
                              buttonType: ButtonType.TERTIARY,
                              onPressed: model.useGoogleAuthentication,
                              icon: Image.asset(AppIconsAssets.google),
                              buttonText: "Google",
                            ),
                          ),
                        ],
                      ),
                      verticalSpaceRegular,
                      Row(
                        children: [
                          Expanded(
                            child: STButton(
                              buttonType: ButtonType.TERTIARY,
                              onPressed: () {
                                model.register();
                              },
                              buttonText: "Create a New Account",
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
          Align(
            alignment: Alignment.topRight,
            child: SafeArea(
              child: Hero(
                tag: "skip",
                transitionOnUserGestures: true,
                child: STButton(
                  buttonType: ButtonType.SECONDARY,
                  onPressed: model.useAnonymousLogin,
                  buttonText: "Skip",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
