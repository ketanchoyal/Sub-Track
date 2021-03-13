import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.locator.dart';
import 'package:sub_track/app/app.router.dart';

class StartUpViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  wait() async {
    await Future.delayed(Duration(seconds: 3));

    _navigationService.navigateTo(Routes.onBoardingView);
  }
}
