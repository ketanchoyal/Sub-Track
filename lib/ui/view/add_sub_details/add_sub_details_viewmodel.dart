import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.locator.dart';
import 'package:sub_track/app/app.router.dart';
import 'package:sub_track/core/models/brands.dart';
import 'package:sub_track/core/models/subscription.dart';
import 'package:sub_track/ui/services/ui_services.dart';

class AddSubDetailsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _uiServices = locator<UIServices>();
  late Brand _brand;
  late Subsription _subsription;

  setBrand(Brand brand) {
    _brand = brand;
  }

  addSubScription() {}

  // FIXME Unhandled Exception: No MaterialLocalizations found cupertino app
  willPopDialog() {
    _dialogService.showDialog(
      title: "Should Close",
      barrierDismissible: false,
      buttonTitle: "Yes",
      cancelTitle: "No",
      dialogPlatform: DialogPlatform.Cupertino,
    );
  }

  navigateToSelectIcon() {
    _navigationService.navigateTo(
      NewSubscriptionRoutes.selectIconView,
      id: 2,
    );
  }

  navigateToSelectCategory() async {
    var category = await _navigationService.navigateTo(
      NewSubscriptionRoutes.selectCategoryView,
      id: 2,
    );
    print(category);
  }

  pop() {
    _navigationService.back(id: 2);
  }
}
