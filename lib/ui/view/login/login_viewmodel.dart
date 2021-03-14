import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.locator.dart';
import 'package:sub_track/app/app.router.dart';
import 'package:sub_track/ui/shared/enums.dart';

import 'login_view.form.dart';

class LoginViewModel extends FormViewModel {
  final _navigationService = locator<NavigationService>();
  TextFieldType emailTextFieldType = TextFieldType.DEFAULT;
  TextFieldType passwordTextFieldType = TextFieldType.DEFAULT;
  @override
  void setFormStatus() {
    // TODO change form type here
    // if (emailValue.length > 0) {
    //   if (emailValue.contains("@")) {
    //     emailTextFieldType = TextFieldType.VALID;
    //   } else {
    //     emailTextFieldType = TextFieldType.ERROR;
    //   }
    // }
    // notifyListeners();
  }

  Future? saveData() {
    // here we can run custom functionality to save to our api
  }

  void register() {
    _navigationService.navigateTo(Routes.registerView);
  }

  void skip() {
    // TODO Anonymous Login here
    _navigationService.navigateTo(Routes.homeView);
  }
}
