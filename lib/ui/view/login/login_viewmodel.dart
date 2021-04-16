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

  LoginViewModel() : super(successRoute: Routes.homeView);
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
    notifyListeners();
  }

  void register() {
    $navigationService.navigateTo(Routes.registerView);
  }

  @override
  Future<FirebaseAuthenticationResult> runAuthentication() =>
      firebaseAuthenticationService.loginWithEmail(
        email: emailValue!,
        password: passwordValue!,
      );
}
