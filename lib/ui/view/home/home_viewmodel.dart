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
  Map<String, int?> _remaningDays = {};

  double _currentMonthExpense = 0.0;
  String get currentMonthExpense => _currentMonthExpense.toStringAsFixed(2);

  double _average = 0.0;
  String get average => _average.toStringAsFixed(2);

  Map<DateTime, double> _graphData = {};
  Map<DateTime, double> get graphData => _graphData;

  get animatorKey => $uiServices.animatorKey;

  int? remainingDays({required Subscription subscription}) {
    if (!_remaningDays.containsKey(subscription.subscriptionId)) {
      _calculationService.calculateRemainingDays(subscription).then((value) {
        _remaningDays.addAll({subscription.subscriptionId: value});
        notifyListeners();
      });
      return null;
    }
    return _remaningDays[subscription.subscriptionId];
  }

  navigateToAddSub() {
    $uiServices.forward();
    $navigationService.navigateTo(Routes.newSubscription);
  }

  clean() {
    _subscriptionLocalDataSource.cleanEverything();
  }

  startupTasks() {
    _fetchSubs();
    _getCurrentMonthExpense();
    _getGraphData();
    notifyListeners();
  }

  _fetchSubs() async {
    if (_subscriptions.isEmpty)
      (await _subscriptionRepo.fetchSubscriptions()).listen((event) {
        _subscriptions = event;
        notifyListeners();
      });
  }

  _getCurrentMonthExpense() async {
    _currentMonthExpense = await _calculationService.getCurrentMonthExpense();
    _average = _currentMonthExpense / DateTime.now().month;
    notifyListeners();
  }

  _getGraphData() async {
    _graphData = await _calculationService.getGraphData();
    notifyListeners();
  }
}
