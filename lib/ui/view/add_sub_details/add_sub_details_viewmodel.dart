import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/app/app.router.dart';
import 'package:sub_track/core/models/brand/brand.dart';
import 'package:sub_track/core/models/subscription/subscription.dart';
import 'package:sub_track/ui/services/ui_services.dart';
import 'package:sub_track/ui/shared/mixins.dart';
import 'package:sub_track/ui/shared/shared.dart';

class AddSubDetailsViewModel extends FormViewModel with $SharedVariables {
  final _dialogService = locator<DialogService>();
  final _uiServices = locator<UIServices>();
  final DateFormat _dateFormatter = DateFormat('yyyy-MM-dd');
  late final ValueNotifier<Color> colorChangeNotifier;
  late Brand _brand;
  late Subscription _subsription;
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
    colorChangeNotifier = ValueNotifier(brand.hex.toColor()!);
    notifyListeners();
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
    $navigationService.navigateTo(
      NewSubscriptionRoutes.selectIconView,
      id: 2,
    );
  }

  navigateToSelectCategory() async {
    var category = await $navigationService.navigateTo(
      NewSubscriptionRoutes.selectCategoryView,
      id: 2,
    );
    print(category);
  }

  navigateToOtherSelectView({required OtherDetailSelectType type}) async {
    var result;
    result = await $navigationService.navigateTo(
      NewSubscriptionRoutes.otherSelectView,
      id: 2,
      arguments: OtherSelectViewArguments(type: type),
    );
    print(result);
  }

  // navigateToRenewSelect() async {
  //   print(renewsEvery);
  // }

  pop() {
    $navigationService.back(id: 2);
  }

  @override
  void setFormStatus() {}

  Future? saveData() {
    // here we can run custom functionality to save to our api
  }
}
