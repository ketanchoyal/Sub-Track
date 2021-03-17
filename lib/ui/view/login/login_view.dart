import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:sub_track/ui/dumb_widgets/buttons.dart';
import 'package:sub_track/ui/dumb_widgets/text_fields.dart';
import 'package:sub_track/ui/dumb_widgets/textfield_outline.dart';
import 'package:sub_track/ui/resources/resources.dart';
import 'package:sub_track/ui/shared/enums.dart';
import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/ui/theme/app_colors.dart';
import 'package:sub_track/ui/view/login/login_view.form.dart';
import './login_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'email'),
  FormTextField(name: 'password', isPassword: true),
])
class LoginView extends StatelessWidget with $LoginView {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      onModelReady: (model) {
        listenToFormUpdated(model);
      },
      builder: (context, model, child) => CupertinoPageScaffold(
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width * 0.35,
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
                            type: model.emailTextFieldType,
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
                            type: model.passwordTextFieldType,
                            controller: passwordController,
                            obscureText: true,
                            focusNode: passwordFocusNode,
                            onSubmitted: (_) => model.saveData(),
                          ),
                        ),
                        verticalSpaceSmall,
                        Text(
                          "Forgot Password?",
                          style: kLinkStyle,
                        ),
                        verticalSpaceMedium,
                        Row(
                          children: [
                            Expanded(
                              child: STButton(
                                onPressed: () {},
                                buttonText: "Login to my account",
                              ),
                            ),
                          ],
                        ),
                        verticalSpaceSmall,
                        verticalSpaceSmall,
                        Row(
                          children: [
                            Expanded(
                              child: STButton(
                                buttonType: ButtonType.TERTIARY,
                                onPressed: () {},
                                buttonText: "Mobile",
                              ),
                            ),
                            horizontalSpaceRegular,
                            Expanded(
                              child: STButton(
                                buttonType: ButtonType.TERTIARY,
                                onPressed: () {},
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
              alignment: Alignment(0.95, -1.0),
              child: SafeArea(
                child: Hero(
                  tag: "skip",
                  transitionOnUserGestures: true,
                  child: STButton(
                    buttonType: ButtonType.SECONDARY,
                    onPressed: model.skip,
                    buttonText: "Skip",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
