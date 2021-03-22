import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.locator.dart';
import 'package:sub_track/app/app.router.dart';
import 'package:sub_track/core/models/brands.dart';
import 'package:sub_track/core/models/subscription.dart';
import 'package:sub_track/ui/services/ui_services.dart';
import 'package:sub_track/ui/shared/shared.dart';

class AddSubDetailsViewModel extends FormViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _uiServices = locator<UIServices>();
  final DateFormat _dateFormatter = DateFormat('yyyy-MM-dd');
  late Brand _brand;
  late Subsription _subsription;
  DateTime _date = DateTime.now();
  bool _isExpanded = false;

  bool get isExpanded => _isExpanded;

  String get date => _dateFormatter.format(_date);

  toggleIsExpanded() {
    _isExpanded = !_isExpanded;
    notifyListeners();
  }

  setBrand(Brand brand) {
    _brand = brand;
  }

  addSubScription() {}

  setDate(DateTime date) {
    _date = date;
    notifyListeners();
  }

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

  navigateToOtherSelectView({required OtherDetailSelectType type}) async {
    var result;
    result = await _navigationService.navigateTo(
      NewSubscriptionRoutes.otherSelectViewView,
      id: 2,
      arguments: OtherSelectViewArguments(type: type),
    );
    print(result);
  }

  // navigateToRenewSelect() async {
  //   print(renewsEvery);
  // }

  pop() {
    _navigationService.back(id: 2);
  }

  @override
  void setFormStatus() {}
}
