import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.locator.dart';
import 'package:sub_track/ui/shared/enums.dart';

class RegisterViewModel extends FormViewModel {
  final _navigationService = locator<NavigationService>();
  TextFieldType emailTextFieldType = TextFieldType.DEFAULT;
  TextFieldType passwordTextFieldType = TextFieldType.DEFAULT;
  TextFieldType nameTextFieldType = TextFieldType.DEFAULT;
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
}
