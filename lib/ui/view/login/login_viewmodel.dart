// ignore: implementation_imports
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:sub_track/app/app.router.dart';
import 'package:sub_track/ui/shared/auth_viewmodel.dart';
import 'package:sub_track/ui/shared/shared.dart';
import 'package:email_validator/email_validator.dart';
import 'login_view.form.dart';

class LoginViewModel extends AuthenticationViewModel {
  // final $navigationService = locator<NavigationService>();
  TextFieldType emailTextFieldType = TextFieldType.DEFAULT;
  TextFieldType passwordTextFieldType = TextFieldType.DEFAULT;

  LoginViewModel() : super(successRoute: Routes.homeView, isNewUser: false);
  @override
  setFormStatus() {
    if (emailValue != null) {
      if (EmailValidator.validate(emailValue!))
        emailTextFieldType = TextFieldType.VALID;
      else
        emailTextFieldType = TextFieldType.ERROR;
    } else {
      emailTextFieldType = TextFieldType.ERROR;
    }

    if (passwordValue == null || passwordValue?.trim() == "") {
      passwordTextFieldType = TextFieldType.ERROR;
    } else {
      passwordTextFieldType = TextFieldType.DEFAULT;
    }
    notifyListeners();
  }

  @override
  Future<void> saveData() async {
    if (passwordValue == null) {
      passwordTextFieldType = TextFieldType.ERROR;
    } else if (emailTextFieldType == TextFieldType.VALID &&
        passwordTextFieldType != TextFieldType.ERROR) {
      super.saveData();
    }
  }

  register() {
    $navigationService.navigateTo(Routes.registerView);
  }

  @override
  Future<FirebaseAuthenticationResult> runAuthentication() =>
      firebaseAuthenticationService.loginWithEmail(
        email: emailValue!,
        password: passwordValue!,
      );

  forgotPassword() {
    $navigationService.navigateTo(Routes.forgotPasswordView);
  }
}
