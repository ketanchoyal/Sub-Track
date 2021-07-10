import 'package:email_validator/email_validator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/app/app.logger.dart';
import 'package:sub_track/ui/shared/mixins.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sub_track/ui/shared/snackbar_ui.dart';
import './forgot_password_view.form.dart';

// NOTE: Should I make seperate Service for Password reset function
class ForgotPasswordViewModel extends FormViewModel with $SharedVariables {
  var logger = getLogger("");
  SnackbarService get _snackbarService => locator<SnackbarService>();
  back() {
    $navigationService.back();
  }

  @override
  void setFormStatus() {}

  sendPasswordResetLink() async {
    if (hasEmail && (emailValue != null && emailValue != "")) {
      logger.d(emailValue);
      if (EmailValidator.validate(emailValue!)) {
        FirebaseAuth.instance.sendPasswordResetEmail(email: emailValue!).then(
              (value) => {
                _snackbarService.showCustomSnackBar(
                  message: "Password reset link sent to $emailValue",
                  duration: Duration(seconds: 2),
                  variant: SnackbarType.Info,
                )
              },
            );
      }
    }
  }
}
