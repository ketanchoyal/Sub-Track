import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/app/app.router.dart';

class OnBoardingViewModel extends BaseViewModel {
  final NavigationService $navigationService = locator<NavigationService>();

  navigate(int index) {
    $navigationService.navigateTo(
      index == 1 ? OnBoardingViewRoutes.view2 : OnBoardingViewRoutes.view3,
      id: 1,
    );
  }

  skip() {
    $navigationService.navigateTo(Routes.loginView);
  }

  back() {
    $navigationService.back();
  }
}
