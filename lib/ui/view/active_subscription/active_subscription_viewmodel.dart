import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/core/models/subscription/subscription.dart';
import 'package:sub_track/core/repository/subscription/subscription_repo.dart';
import 'package:sub_track/core/services/url_launch_service.dart';
import 'package:sub_track/ui/shared/mixins.dart';
import 'package:sub_track/ui/shared/base_viewmodel.dart';

class ActiveSubscriptionViewModel extends BaseViewModel with $SharedVariables {
  bool isDialogPopped = false;
  double scale = 2.0;
  SubscriptionRepo get _subscriptionRepo => locator<SubscriptionRepo>();
  UrlLaunchService get _urlLaunchService => locator<UrlLaunchService>();
  BottomSheetService get _bottomSheetService => locator<BottomSheetService>();
  late Subscription _selectedSub;
  Subscription get selectedSub => _selectedSub;
  Map<String, int?> _remaningDays = {};

  ActiveSubscriptionViewModel(String subscriptionId) {
    _selectedSub = subscriptions
        .where((element) => element.subscriptionId == subscriptionId)
        .first;
  }

  selectSub(Subscription sub) async {
    _selectedSub = sub;
    if (_selectedSub.payments == null) {
      setBusy(true);
      await $calculationService.calculateRemainingDays(_selectedSub);
      setBusy(false);
    } else {
      if (_selectedSub.payments!.isEmpty) {
        setBusy(true);
        await $calculationService.calculateRemainingDays(_selectedSub);
        setBusy(false);
      }
    }
    _selectedSub = subscriptions
        .where((element) => element.subscriptionId == sub.subscriptionId)
        .first;
    notifyListeners();
  }

  bool isCurrentSelected(Subscription sub) {
    return sub.subscriptionId == _selectedSub.subscriptionId;
  }

  List<Subscription> get subscriptions =>
      _subscriptionRepo.getSubscriptionsOnce();

  pop() {
    $navigationService.back();
  }

  deleteSub() async {
    SheetResponse? result = await _bottomSheetService.showBottomSheet(
      title: "Are you sure?",
      barrierDismissible: true,
      cancelButtonTitle: "Cancel",
      description: "This action cannot be undone",
      confirmButtonTitle: "Delete",
      enableDrag: true,
      isScrollControlled: true,
    );
    if (result != null) {
      if (result.confirmed) {
        await _subscriptionRepo.deleteSubscription(
            subscriptionId: _selectedSub.subscriptionId);
      }
    }
    selectSub(subscriptions.first);
    notifyListeners();
  }

  DateTime get startedOn {
    return _selectedSub.startedOn;
  }

  int? get remainingDays {
    if (!_remaningDays.containsKey(_selectedSub.subscriptionId)) {
      $calculationService.calculateRemainingDays(_selectedSub).then((value) {
        _remaningDays.addAll({_selectedSub.subscriptionId: value});
        notifyListeners();
      });
      return null;
    }
    return _remaningDays[_selectedSub.subscriptionId];
  }

  openLink() {
    if (_selectedSub.brand.source != null)
      _urlLaunchService.launchUrl(selectedSub.brand.source!);
  }
}
