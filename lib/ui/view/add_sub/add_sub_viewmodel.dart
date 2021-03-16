import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.locator.dart';
import 'package:sub_track/app/app.router.dart';
import 'package:sub_track/core/models/subscription.dart';

class AddSubViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  bool haveSubscriptions = false;
  static double toppadding = 0;

  navigateToAddSub() {
    _navigationService.navigateTo(Routes.addSubView);
  }

  pop() {
    _navigationService.back();
  }

  // FIXME Subscription model is necessery
  navigateToAddDetails({Subscription? subscription}) async {
    toppadding = -10;
    notifyListeners();
    _navigationService.navigateTo(
      Routes.addSubDetailsView,
    );
  }
}
