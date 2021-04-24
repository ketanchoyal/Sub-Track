import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/core/models/subscription/subscription.dart';
import 'package:sub_track/core/repository/subscription/subscription_repo.dart';
import 'package:sub_track/ui/shared/mixins.dart';

class ActiveSubscriptionViewModel extends BaseViewModel with $SharedVariables {
  bool isDialogPopped = false;
  double scale = 1.0;
  DragUpdateDetails details = DragUpdateDetails(globalPosition: Offset(0, 0));
  SubscriptionRepo _subscriptionRepo = locator<SubscriptionRepo>();
  // CalculationService _calculationService = locator<CalculationService>();

  List<Subscription> get subscriptions =>
      _subscriptionRepo.getSubscriptionsOnce();

  pop() {
    $navigationService.back();
  }

  onDragUpdate(DragUpdateDetails details) {
    this.details = details;
    notifyListeners();
  }
}
