import 'package:email_validator/email_validator.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:sub_track/app/app.router.dart';
import 'package:sub_track/ui/shared/auth_viewmodel.dart';
import 'package:sub_track/ui/shared/shared.dart';
import 'register_view.form.dart';

class RegisterViewModel extends AuthenticationViewModel {
  TextFieldType emailTextFieldType = TextFieldType.DEFAULT;
  TextFieldType passwordTextFieldType = TextFieldType.DEFAULT;
  TextFieldType nameTextFieldType = TextFieldType.DEFAULT;

  RegisterViewModel() : super(successRoute: Routes.homeView);
  @override
  void setFormStatus() {
    if (emailValue != null) {
      if (EmailValidator.validate(emailValue!))
        emailTextFieldType = TextFieldType.VALID;
      else
        emailTextFieldType = TextFieldType.ERROR;
    } else {
      emailTextFieldType = TextFieldType.ERROR;
    }

    if (nameValue != null && nameValue == "") {
      nameTextFieldType = TextFieldType.ERROR;
    }
    notifyListeners();
  }

  back() {
    $navigationService.back();
  }

  void skip() {
    $navigationService.clearStackAndShow(Routes.homeView);
  }

  @override
  Future<FirebaseAuthenticationResult> runAuthentication() =>
      firebaseAuthenticationService.createAccountWithEmail(
        email: emailValue!,
        password: passwordValue!,
      );
}
