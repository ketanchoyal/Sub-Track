import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.locator.dart';
import 'package:sub_track/app/app.router.dart';
import 'package:sub_track/core/models/subscription.dart';
import 'package:sub_track/ui/services/ui_services.dart';

class AddSubViewModel extends StreamViewModel<double> {
  final _navigationService = locator<NavigationService>();
  final _uiServices = locator<UIServices>();

  bool haveSubscriptions = false;

  // navigateToAddSub() {
  //   _navigationService.navigateTo(NewSubscriptionRoutes.addSubView, id: 2);
  // }

  pop() {
    _navigationService.back();
  }

  // resetpadding() {
  //   _uiServices.setExtraPadding(0);
  // }

  // FIXME Subscription model is necessery
  navigateToAddDetails({Subscription? subscription}) async {
    // await _uiServices.setExtraPadding(-10);
    _navigationService.navigateTo(
      NewSubscriptionRoutes.addSubDetailsView,
      id: 2,
    );
  }

  @override
  Stream<double> get stream => _uiServices.getExtraPadding;
}
