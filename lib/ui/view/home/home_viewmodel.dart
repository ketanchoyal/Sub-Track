import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/app/app.router.dart';
import 'package:sub_track/ui/shared/mixins.dart';

class HomeViewModel extends BaseViewModel with $SharedVariables {
  bool haveSubscriptions = false;

  navigateToAddSub() {
    $navigationService.navigateTo(Routes.newSubscription);
  }
}
