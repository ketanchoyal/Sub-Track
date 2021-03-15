import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.locator.dart';
import 'package:sub_track/app/app.router.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  bool haveSubscriptions = false;

  navigateToDemo() {
    _navigationService.navigateTo(Routes.demoView);
  }
}
