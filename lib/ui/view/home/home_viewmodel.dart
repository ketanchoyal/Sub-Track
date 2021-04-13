import 'package:stacked/stacked.dart';
import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/app/app.router.dart';
import 'package:sub_track/core/data_source/subscription/sub_local.dart';
import 'package:sub_track/core/models/subscription/subscription.dart';
import 'package:sub_track/core/repository/subscription/subscription_repo.dart';
import 'package:sub_track/core/services/calculation_service.dart';
import 'package:sub_track/ui/shared/mixins.dart';

class HomeViewModel extends BaseViewModel with $SharedVariables {
  bool haveSubscriptions = false;
  SubscriptionRepo _subscriptionRepo = locator<SubscriptionRepo>();
  SubscriptionLocalDataSource _subscriptionLocalDataSource =
      locator<SubscriptionLocalDataSource>();
  CalculationService _calculationService = locator<CalculationService>();

  List<Subscription> _subscriptions = [];
  List<Subscription> get subscriptions => _subscriptions;

  double _totalExpense = 0.0;
  String get totalExpense => _totalExpense.toStringAsFixed(2);

  navigateToAddSub() {
    $navigationService.navigateTo(Routes.newSubscription);
  }

  clean() {
    _subscriptionLocalDataSource.cleanEverything();
  }

  startupTasks() {
    _fetchSubs();
    _getTotalExpense();
    notifyListeners();
  }

  _fetchSubs() async {
    (await _subscriptionRepo.fetchSubscriptions()).listen((event) {
      _subscriptions = event;
      notifyListeners();
    });
  }

  _getTotalExpense() {
    _calculationService.getTotalExpense().listen((event) {
      _totalExpense = event;
      notifyListeners();
    });
  }
}
