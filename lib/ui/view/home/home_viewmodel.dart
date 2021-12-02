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

final _forceFetchToggleSP = StateProvider(
  (ref) => false,
);

final isSubscriptionListEmptySP = StateProvider((ref) => false);

final allSubscriptionStreamProvider = StreamProvider<List<Subscription>>(
  (ref) {
    final repo = ref.watch(subscriptionRepoP);
    final forceFetchToggle = ref.watch(_forceFetchToggleSP);
    return repo.fetchSubscriptions(
      forceFetch: forceFetchToggle,
    )..listen(
        (event) {
          if (event.isEmpty) {
            ref.read(isSubscriptionListEmptySP.notifier).state = true;
            ref.read(_forceFetchToggleSP.notifier).state = true;
          } else {
            ref.read(isSubscriptionListEmptySP.notifier).state = false;
          }
        },
      );
  },
  name: 'allSubscriptionStreamProvider',
);

final upCommingSubscriptionsFutureProvider = FutureProvider<List<Subscription>>(
  (ref) async {
    final repo = ref.watch(subscriptionRepoP);
    final allSubscriptions = repo.getSubscriptionsOnce();
    final sortedSubs = allSubscriptions;

    sortedSubs.sort((a, b) {
      int? r1 = ref.read(calculateRemaningDaysFutureProvider(a)).asData?.value;
      int? r2 = ref.read(calculateRemaningDaysFutureProvider(b)).asData?.value;
      if (r1 != null && r2 != null) {
        return r1.compareTo(r2);
      } else
        return 1000;
    });

    return sortedSubs.take(5).toList();
  },
  name: 'upCommingSubscriptionsFutureProvider',
);

final calculateRemaningDaysFutureProvider =
    FutureProvider.family<int?, Subscription>(
  (ref, sub) async {
    final calculateionService = ref.watch(calculationServiceP);

    return calculateionService.calculateRemainingDays(sub);
  },
  name: 'calculateRemaningDaysFutureProvider',
);

final currentMonthExpenseFutureProvider = FutureProvider<String>(
  (ref) async {
    final calculateionService = ref.watch(calculationServiceP);
    final forceFetchToggle = ref.watch(_forceFetchToggleSP);
    final currentMonthExpense =
        await calculateionService.getCurrentMonthExpense(
      fromRemote: forceFetchToggle,
    );
    return currentMonthExpense.toStringAsFixed(2);
  },
  name: 'currentMonthExpenseFutureProvider',
);

final currentYearExpenseAverageFutureProvider = FutureProvider<String>(
  (ref) async {
    final calculateionService = ref.watch(calculationServiceP);
    final forceFetchToggle = ref.watch(_forceFetchToggleSP);
    final currentYearExpense = await calculateionService.getTotalExpense(
      fromRemote: forceFetchToggle,
    );
    final average = currentYearExpense / DateTime.now().month;
    return average.toStringAsFixed(2);
  },
  name: 'currentYearExpenseFutureProvider',
);

final graphDataFutureProvider = FutureProvider<Map<DateTime, double>>(
  (ref) async {
    final calculateionService = ref.watch(calculationServiceP);
    final forceFetchToggle = ref.watch(_forceFetchToggleSP);
    return calculateionService.getGraphData(
      fromRemote: forceFetchToggle,
    );
  },
  name: 'graphDataFutureProvider',
);

final homeViewModelCNP = ChangeNotifierProvider<HomeViewModel>(
  (ref) => HomeViewModel(ref),
  name: 'HomeViewModel',
);

class HomeViewModel extends BaseViewModel with $SharedVariables {
  // bool haveSubscriptions = false;
  // SubscriptionRepo get _subscriptionRepo => _ref.read(subscriptionRepoP);
  SubscriptionLocalDataSource get _subscriptionLocalDataSource =>
      _ref.read(subscriptionLocalDataSourceP);

  final Ref _ref;

  HomeViewModel(this._ref);

  @override
  Ref get ref => _ref;

  get animatorKey => $uiServices.animatorKey;

  navigateToAddSub() {
    $uiServices.forward();
    $navigationService.navigateTo(Routes.newSubscription);
  }

  clean() {
    _subscriptionLocalDataSource.cleanEverything();
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
