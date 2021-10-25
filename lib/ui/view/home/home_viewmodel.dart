import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/src/provider.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/app/app.router.dart';
import 'package:sub_track/core/data_source/subscription/sub_local.dart';
import 'package:sub_track/core/models/subscription/subscription.dart';
import 'package:sub_track/core/repository/subscription/subscription_repo.dart';
import 'package:sub_track/core/services/calculation_service.dart';
import 'package:sub_track/ui/shared/base_viewmodel.dart';
import 'package:sub_track/ui/shared/mixins.dart';

final homeViewModelCNP = ChangeNotifierProvider<HomeViewModel>(
  (ref) => HomeViewModel(ref),
  name: 'HomeViewModel',
);

class HomeViewModel extends BaseViewModel with $SharedVariables {
  // bool haveSubscriptions = false;
  SubscriptionRepo get _subscriptionRepo => _ref.read(subscriptionRepoP);
  SubscriptionLocalDataSource get _subscriptionLocalDataSource =>
      _ref.read(subscriptionLocalDataSourceP);

  final ProviderRefBase _ref;

  HomeViewModel(this._ref);

  @override
  ProviderRefBase get ref => _ref;

  List<Subscription> _subscriptions = [];
  List<Subscription> get subscriptions => _subscriptions;
  List<Subscription> get upcommings {
    List<Subscription> sortedSubs = _subscriptions;
    sortedSubs.sort((a, b) {
      int? r1 = remainingDays(subscription: a);
      int? r2 = remainingDays(subscription: b);
      if (r1 != null && r2 != null) {
        return r1.compareTo(r2);
      } else
        return 1000;
    });
    return sortedSubs.take(5).toList();
  }

  Map<String, int?> _remaningDays = {};

  double _currentMonthExpense = 0.0;
  String get currentMonthExpense => _currentMonthExpense.toStringAsFixed(2);

  double _average = 0.0;
  String get average => _average.toStringAsFixed(2);

  Map<DateTime, double> _graphData = {};
  Map<DateTime, double> get graphData => _graphData;
  bool _fetchFromServer = false;

  get animatorKey => $uiServices.animatorKey;

  int? remainingDays({required Subscription subscription}) {
    if (!_remaningDays.containsKey(subscription.subscriptionId)) {
      $calculationService.calculateRemainingDays(subscription).then((value) {
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
    fetchSubs();
    _getCurrentMonthExpense();
    _getCurentYearExpense();
    _getGraphData();
    notifyListeners();
  }

  fetchSubs({bool refresh = false}) async {
    if (!refresh) setBusy(true);
    // _subscriptions = _subscriptionRepo.getSubscriptionsOnce();
    await Future.delayed(Duration(seconds: 1));
    // if (_subscriptions.length == 0)
    _subscriptionRepo
        .fetchSubscriptions(forceFetch: _fetchFromServer)
        .listen((event) {
      _subscriptions = event;
      notifyListeners();
      if (event.length == 0) {
        if (!_fetchFromServer) {
          _fetchFromServer = true;
          startupTasks();
        } else {
          _fetchFromServer = false;
        }
      }
    });
    if (!refresh) setBusy(false);
  }

  _getCurrentMonthExpense() async {
    _currentMonthExpense = await $calculationService.getCurrentMonthExpense(
        fromRemote: _fetchFromServer);
    notifyListeners();
  }

  _getCurentYearExpense() async {
    double currentYearExpense =
        await $calculationService.getTotalExpense(fromRemote: _fetchFromServer);
    _average = currentYearExpense / DateTime.now().month;
    notifyListeners();
  }

  _getGraphData() async {
    _graphData =
        await $calculationService.getGraphData(fromRemote: _fetchFromServer);
    notifyListeners();
  }

  navigateToActiveSub({required String subId}) async {
    $navigationService.navigateTo(
      Routes.activeSubscriptionView,
      arguments: ActiveSubscriptionViewArguments(selectedSubId: subId),
    );
  }

  logout() async {
    await $firebaseAuthenticationService.logout();
    $navigationService.clearStackAndShow(Routes.onBoardingView);
  }

  navigateToSettingView() {
    $navigationService.navigateTo(Routes.settingView);
  }
}
