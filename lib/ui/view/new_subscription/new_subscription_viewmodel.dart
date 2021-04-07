import 'package:stacked/stacked.dart';
import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/ui/services/ui_services.dart';
import 'package:sub_track/ui/shared/mixins.dart';

class NewSubscriptionViewModel extends BaseViewModel with $SharedVariables {
  UIServices _uiServices = locator<UIServices>();
  bool isDialogPopped = false;

  pop() => $navigationService.back();

  set scrollController(value) => _uiServices.scrollController = value;
}
