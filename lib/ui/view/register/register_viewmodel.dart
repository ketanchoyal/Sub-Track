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
    notifyListeners();
  }

  @override
  Future<void> saveData() async {
    if (passwordValue == null) {
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
  Future<FirebaseAuthenticationResult> runAuthentication() async {
    await firebaseAuthenticationService.createAccountWithEmail(
      email: emailValue!,
      password: passwordValue!,
    );
    if (result.user != null) result.user!.updateProfile(displayName: nameValue);
    return result;
  }
}
