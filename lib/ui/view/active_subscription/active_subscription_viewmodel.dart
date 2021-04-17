import 'package:stacked/stacked.dart';
import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/core/models/subscription/subscription.dart';
import 'package:sub_track/core/repository/subscription/subscription_repo.dart';
import 'package:sub_track/ui/shared/mixins.dart';

class ActiveSubscriptionViewModel extends BaseViewModel with $SharedVariables {
  SubscriptionRepo _subscriptionRepo = locator<SubscriptionRepo>();
  // CalculationService _calculationService = locator<CalculationService>();

  List<Subscription> _subscriptions = [];
  List<Subscription> get subscriptions => _subscriptions;

  startupTasks() {
    _fetchSubs();
    notifyListeners();
  }

  _fetchSubs() async {
    if (_subscriptions.isEmpty)
      (await _subscriptionRepo.fetchSubscriptions()).listen((event) {
        _subscriptions = event;
        notifyListeners();
      });
  }

  pop() {
    $navigationService.back();
  }
}
