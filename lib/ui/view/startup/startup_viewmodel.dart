import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/app/app.router.dart';

class StartUpViewModel extends BaseViewModel {
  final NavigationService $navigationService = locator<NavigationService>();

  wait() async {
    await Future.delayed(Duration(seconds: 1));

    $navigationService.navigateTo(Routes.onBoardingView);
  }
}
