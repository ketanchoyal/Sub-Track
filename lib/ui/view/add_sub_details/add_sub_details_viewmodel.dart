import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.locator.dart';
import 'package:sub_track/app/app.router.dart';
import 'package:sub_track/ui/services/ui_services.dart';
import 'package:sub_track/ui/view/add_sub/add_sub_viewmodel.dart';

class AddSubDetailsViewModel extends StreamViewModel<double> {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _uiServices = locator<UIServices>();

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

  pop() {
    resetpadding();
    _navigationService.back();
  }

  resetpadding() async {
    await _uiServices.setExtraPadding(0);
  }

  @override
  Stream<double> get stream => _uiServices.getExtraPadding;
}
