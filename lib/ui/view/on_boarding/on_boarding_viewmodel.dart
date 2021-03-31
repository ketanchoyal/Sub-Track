import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/app/app.router.dart';

class OnBoardingViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  navigate(int index) {
    _navigationService.navigateTo(
      index == 1 ? OnBoardingViewRoutes.view2 : OnBoardingViewRoutes.view3,
      id: 1,
    );
  }

  skip() {
    _navigationService.navigateTo(Routes.loginView);
  }

  back() {
    _navigationService.back();
  }
}
