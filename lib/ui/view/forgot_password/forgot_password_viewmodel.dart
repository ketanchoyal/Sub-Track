import 'package:email_validator/email_validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.logger.dart';
import 'package:sub_track/core/services/auth_service.dart';
import 'package:sub_track/ui/shared/auth_viewmodel.dart';
import 'package:sub_track/ui/shared/mixins.dart';
import 'package:sub_track/ui/shared/snackbar_ui.dart';
import 'forgot_password_view.formx.dart';

final forgotPasswordViewModelCNP = ChangeNotifierProvider(
  (ref) => ForgotPasswordViewModel(ref),
  name: 'ForgotPasswordViewModel',
);

class ForgotPasswordViewModel extends FormViewModel with $SharedVariables {
  ForgotPasswordViewModel(this._ref);
  final Ref _ref;
  @override
  Ref get ref => _ref;

  var logger = getLogger("");
  SnackbarService get _snackbarService => _ref.read(snackbarServiceP);
  back() {
    $navigationService.back();
  }

  @override
  void setFormStatus() {}

  sendPasswordResetLink() async {
    if (hasEmail && (emailValue != null && emailValue != "")) {
      logger.d(emailValue);
      if (EmailValidator.validate(emailValue!)) {
        await _ref
            .read(firebaseAuthServiceP)
            .sendResetPasswordLink(emailValue!);
        _snackbarService.showCustomSnackBar(
          message: "Password reset link sent to $emailValue",
          duration: Duration(seconds: 2),
          variant: SnackbarType.Info,
        );
      }
    }
  }
}
