import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/app/app.router.dart';
import 'package:sub_track/ui/shared/base_viewmodel.dart';

final onBoardingViewModelCNP =
    ChangeNotifierProvider((ref) => OnBoardingViewModel(ref));

class OnBoardingViewModel extends BaseViewModel {
  NavigationService get _navigationService => _ref.read(navigationServiceP);

  final ProviderRefBase _ref;

  OnBoardingViewModel(this._ref);

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
