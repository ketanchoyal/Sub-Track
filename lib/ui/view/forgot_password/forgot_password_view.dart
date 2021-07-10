import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:sub_track/ui/dumb_widgets/buttons.dart';
import 'package:sub_track/ui/dumb_widgets/text_fields.dart';
import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/ui/theme/app_colors.dart';
import './forgot_password_viewmodel.dart';

import './forgot_password_view.form.dart';

@FormView(fields: [
  FormTextField(name: 'email'),
])
class ForgotPasswordView extends StatelessWidget with $ForgotPasswordView {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ForgotPasswordViewModel>.reactive(
      viewModelBuilder: () => ForgotPasswordViewModel(),
      onDispose: (model) {
        disposeForm();
      },
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: GestureDetector(
                            onTap: model.back,
                            child: Icon(
                              Icons.arrow_back_ios_rounded,
                              size: 30,
                            ),
                          ),
                        ),
                        Expanded(child: Container()),
                      ],
                    ).padding(EdgeInsets.only(bottom: 10)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Reset Password",
                          style: kTitleStyle.copyWith(
                            color: AppColor.STDark,
                          ),
                        ),
                        Text(
                          "Enter your registered email to recover \nyour account",
                          style: kMediumStyle.copyWith(
                            color: AppColor.STDarkLight,
                          ),
                        ),
                      ],
                    ),
                    verticalSpaceRegular,
                    Container(
                      decoration: BoxDecoration(
                        color: AppColor.STPureWhite.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: STTextField(
                        placeholder: "yourname@something.com",
                        type: TextFieldType.DEFAULT,
                        controller: emailController,
                        focusNode: emailFocusNode,
                        onSubmitted: (value) {
                          // model.setFormStatus();
                          model.sendPasswordResetLink();
                        },
                      ).paddingH(5).paddingV(5),
                    ),
                    verticalSpaceRegular,
                    Row(
                      children: [
                        Expanded(child: Container()),
                        STButton(
                          buttonType: ButtonType.ICON,
                          icon: Center(
                            child: Icon(
                              Icons.arrow_forward_rounded,
                              size: 30,
                            ),
                          ),
                          onPressed: () {
                            model.sendPasswordResetLink();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
