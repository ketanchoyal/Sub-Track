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

  RegisterViewModel() : super(successRoute: Routes.homeView, isNewUser: true);
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
    } else {
      nameTextFieldType = TextFieldType.VALID;
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
    if (passwordValue == null || passwordValue?.trim() == "") {
      passwordTextFieldType = TextFieldType.ERROR;
    } else {
      passwordTextFieldType = TextFieldType.VALID;
    }
    if ((emailTextFieldType == passwordTextFieldType) &&
        (emailTextFieldType == nameTextFieldType)) {
      super.saveData();
    }
  }

  back() {
    $navigationService.back();
  }

  @override
  Future<void> runAfterSuccessfullAuth() async {
    _setUserName();
  }

  @override
  Future<FirebaseAuthenticationResult> runAuthentication() =>
      firebaseAuthenticationService.createAccountWithEmail(
        email: emailValue!,
        password: passwordValue!,
      );

  _setUserName() async {
    await result.user!.updateProfile(displayName: nameValue);
  }
}
