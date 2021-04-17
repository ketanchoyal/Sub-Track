import 'package:stacked/stacked.dart';
import 'package:sub_track/ui/shared/mixins.dart';

class NewSubscriptionViewModel extends BaseViewModel with $SharedVariables {
  bool isDialogPopped = false;

  pop() {
    $uiServices.animateBackToZero();
    $navigationService.back();
  }

  get animator => $uiServices.animatorKey;

  set scrollController(value) => $uiServices.scrollController = value;
}
