import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:sub_track/ui/dumb_widgets/buttons.dart';
import 'package:sub_track/ui/dumb_widgets/text_fields.dart';
import 'package:sub_track/ui/dumb_widgets/textfield_outline.dart';
import 'package:sub_track/ui/resources/resources.dart';

import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/ui/theme/app_colors.dart';
import 'package:sub_track/ui/view/register/register_view.form.dart';
import './register_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: "name"),
  FormTextField(name: 'email'),
  FormTextField(name: 'password', isPassword: true),
])
class RegisterView extends StatelessWidget with $RegisterView {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.reactive(
      viewModelBuilder: () => RegisterViewModel(),
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
                              "Hello!",
                              style: kTitleStyle.copyWith(
                                color: AppColor.STDark,
                              ),
                            ),
                            Text(
                              "Enter details to get started",
                              style: kMediumStyle.copyWith(
                                color: AppColor.STDarkLight,
                              ),
                            ),
                          ],
                        ),
                        verticalSpaceRegular,
                        STTextFieldOutline(
                          title: "Name",
                          child: STTextField(
                            placeholder: "",
                            type: model.nameTextFieldType,
                            controller: nameController,
                            focusNode: nameFocusNode,
                            nextFocusNode: emailFocusNode,
                          ),
                        ),
                        verticalSpaceRegular,
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
                          helperText: "at least 7 characters",
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
                        GestureDetector(
                          onTap: () {
                            model.back();
                          },
                          child: Text(
                            "Already registered?",
                            style: kLinkStyle,
                          ),
                        ),
                        verticalSpaceRegular,
                        Row(
                          children: [
                            Expanded(
                              child: STButton(
                                onPressed: () {},
                                buttonText: "Create account",
                              ),
                            ),
                          ],
                        ),
                        verticalSpaceSmall,
                        verticalSpaceSmall,
                        Row(
                          children: [
                            if (Platform.isIOS)
                              Expanded(
                                child: STButton(
                                  buttonType: ButtonType.TERTIARY,
                                  onPressed: () {},
                                  icon: Image.asset(
                                    AppIconsAssets.apple,
                                    color: Colors.black,
                                  ),
                                  buttonText: "Apple",
                                ),
                              ),
                            if (Platform.isIOS) horizontalSpaceRegular,
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Align(
                alignment: Alignment.topLeft,
                child: Hero(
                  tag: "back",
                  transitionOnUserGestures: true,
                  child: STButton(
                    buttonType: ButtonType.SECONDARY,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    buttonText: "Back",
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
