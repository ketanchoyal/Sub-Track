import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sub_track/core/models/subscription/subscription.dart';
import 'package:sub_track/core/repository/subscription/subscription_repo.dart';
import 'package:sub_track/core/enums/enums.dart';
import 'package:sub_track/ui/shared/shared.dart';

final calculationServiceP = Provider<CalculationService>(
  (ref) => CalculationServiceImpl(
    subscriptionRepo: ref.watch(subscriptionRepoP),
  ),
  dependencies: [subscriptionRepoP],
  name: "calculationServiceP",
);

/// Require
///
/// [SubscriptionRepo]
abstract class CalculationService {
  Future<double> getTotalExpense(
      {bool currentYear = true, bool fromRemote = false});
  Future<double> getCurrentMonthExpense({bool fromRemote = false});
  Future<Map<DateTime, double>> getGraphData({bool fromRemote = false});
  Future<double> getExpenseOf(
      {required DateTime month, bool fromRemote = false});
  Future<int?> calculateRemainingDays(Subscription subscription);
}

class CalculationServiceImpl implements CalculationService {
  final SubscriptionRepo _subscriptionRepo;

  CalculationServiceImpl({required SubscriptionRepo subscriptionRepo})
      : _subscriptionRepo = subscriptionRepo;

  @override
  Future<Map<DateTime, double>> getGraphData({bool fromRemote = false}) async {
    final Stream<List<Subscription>> subStream =
        (await _subscriptionRepo.fetchSubscriptions(forceFetch: fromRemote));

    await for (List<Subscription> subs in subStream) {
      Map<DateTime, double> data = {};
      await Future.forEach<Subscription>(subs, (oldsubscription) async {
        Subscription subscription = oldsubscription;
        if (subscription.payments == null) {
          subscription = await _calculatePayments(subscription);
        }
        if (subscription.payments != null) {
          subscription.payments!.forEach((key, newValue) {
            if (key.isBefore(DateTime.now()))
              data.update(
                key.date,
                (value) => value + newValue,
                ifAbsent: () => newValue,
              );
          });
        }
      });
      return data;
    }
    return {};
  }

  @override
  Future<double> getExpenseOf(
      {required DateTime month, bool fromRemote = false}) async {
    final Stream<List<Subscription>> subStream =
        (await _subscriptionRepo.fetchSubscriptions(forceFetch: fromRemote));

    await for (List<Subscription> subs in subStream) {
      double totalExpense = 0;
      await Future.forEach<Subscription>(subs, (subscription) async {
        double singleExpense = await _getTotalExpenseOfSingleSubscriptionOf(
          month: DateTime.now(),
          subscription: subscription,
        );
        totalExpense += singleExpense;
      });
      return totalExpense;
    }
    return 0;
  }

  //NOTE needs testing
  @override
  Future<double> getCurrentMonthExpense({bool fromRemote = false}) async {
    final Stream<List<Subscription>> subStream =
        (await _subscriptionRepo.fetchSubscriptions(forceFetch: fromRemote));

    await for (List<Subscription> subs in subStream) {
      double totalExpense = 0;
      await Future.forEach<Subscription>(subs, (subscription) async {
        double singleExpense = await _getTotalExpenseOfSingleSubscriptionOf(
          month: DateTime.now(),
          subscription: subscription,
        );
        totalExpense += singleExpense;
      });
      return totalExpense;
    }
    return 0.0;
  }

  Future<double> _getTotalExpenseOfSingleSubscriptionOf(
      {required DateTime month, required Subscription subscription}) async {
    double totalExpense = 0.0;
    if (subscription.payments != null && subscription.payments!.isNotEmpty) {
      await Future.forEach<MapEntry<DateTime, double>>(
          subscription.payments!.entries, (element) async {
        if (!element.key.isAfter(DateTime.now()) &&
            element.key.isAtSameMonthAs(month)) totalExpense += element.value;
      });
    }
    print(
        "Calculating _getTotalExpenseOfSingleSubscriptionOfCurrentMonth of ${subscription.brand.title} : $totalExpense");
    return totalExpense;
  }

  //NOTE needs testing
  @override
  Future<double> getTotalExpense(
      {bool currentYear = true, bool fromRemote = false}) async {
    final Stream<List<Subscription>> subStream =
        await _subscriptionRepo.fetchSubscriptions(forceFetch: fromRemote);
    print("Subscribed to getTotalExpense");
    print("setting totalExpense : 0");
    double totalExpense = 0;
    await for (List<Subscription> subs in subStream) {
      await Future.forEach<Subscription>(subs, (subscription) async {
        double singleExpense = await _getTotalExpenseOfSingleSubscription(
            subscription, currentYear);
        print("singleExpense : $singleExpense");
        totalExpense += singleExpense;
        print("totalExpense: $totalExpense");
      });
      print("yield totalExpense : $totalExpense");
      return totalExpense;
    }
    return 0.0;
  }

  Future<double> _getTotalExpenseOfSingleSubscription(
      Subscription oldsubscription,
      [bool currentYear = true]) async {
    Subscription subscription = oldsubscription;
    double totalExpense = 0.0;
    if (subscription.payments == null) {
      subscription = await _calculatePayments(subscription);
    }
    DateTime latestPayment = subscription.payments!.entries.last.key;
    if (latestPayment.isAfter(DateTime.now())) {
      subscription = await _calculatePayments(subscription);
    }

    if (subscription.payments != null && subscription.payments!.isNotEmpty) {
      await Future.forEach<MapEntry<DateTime, double>>(
          subscription.payments!.entries, (element) async {
        if (currentYear) {
          if (!element.key.isAfter(DateTime.now()) &&
              element.key.isAtSameYearAs(DateTime.now()))
            totalExpense += element.value;
        } else {
          if (!element.key.isAfter(DateTime.now()))
            totalExpense += element.value;
        }
      });
    }
    print(
        "Calculating _getTotalExpenseOfSingleSubscription of ${subscription.brand.title} : $totalExpense");
    return totalExpense;
  }

  // FIXME Subscription are renews every 30 day so instead of adding month add 30days
  // Reference: https://transform-hq.helpscoutdocs.com/article/21-exact-interval-for-a-monthly-subscription
  Future<Subscription> _calculatePayments(Subscription subscription) async {
    print("Calculating payments for ${subscription.brand.title}");
    Map<DateTime, double> _payments = {};
    double paidCost = subscription.cost;
    if (subscription.sharedWith != null) {
      if (subscription.sharedWith == 0) {
        paidCost = subscription.cost;
      } else {
        paidCost = (subscription.cost / subscription.sharedWith!);
      }
    }

    switch (subscription.renewsEvery) {
      case RenewsEvery.Never:
        _payments.addAll({subscription.startedOn.date: paidCost});
        break;
      case RenewsEvery.Daily:
        // Shows Latest Upcomming RENEW: yes
        Duration duration = DateTime.now().difference(subscription.startedOn);
        int noOfPaymentsMadeUntilNow = duration.inDays.abs();
        for (int i = 0; i <= noOfPaymentsMadeUntilNow; i++) {
          _payments.addAll(
              {subscription.startedOn.add(Duration(days: i)).date: paidCost});
        }
        break;
      case RenewsEvery.Weekly:
        // Shows Latest Upcomming RENEW: yes
        Duration duration = DateTime.now().difference(subscription.startedOn);
        int noOfPaymentsMadeUntilNow = duration.inWeeks.abs();
        for (int i = 0; i <= noOfPaymentsMadeUntilNow; i++) {
          _payments.addAll({
            subscription.startedOn.add(Duration(days: i * 7)).date: paidCost
          });
        }
        break;
      case RenewsEvery.Biweekly:
        // Shows Latest Upcomming RENEW: yes
        Duration duration = DateTime.now().difference(subscription.startedOn);
        int noOfPaymentsMadeUntilNow = duration.inBiWeekly.abs();
        for (int i = 0; i <= noOfPaymentsMadeUntilNow; i++) {
          _payments.addAll({
            subscription.startedOn.add(Duration(days: i * 14)).date: paidCost
          });
        }
        break;
      case RenewsEvery.Monthly:
        // Shows Latest Upcomming RENEW: yes
        DateTime temp = subscription.startedOn.addMonths(-1);
        do {
          temp = temp.addMonths(1);
          _payments.addAll({temp.date: paidCost});
        } while (!temp.isAtSameMonthAs(DateTime.now()) && !temp.isToday);
        break;
      case RenewsEvery.Quarterly:
        // Shows Latest Upcomming RENEW: yes
        DateTime temp = subscription.startedOn.addQuarters(-1);
        do {
          temp = temp.addQuarters(1);
          _payments.addAll({temp.date: paidCost});
        } while (temp.difference(DateTime.now()).isNegative &&
            !temp.isAtSameMonthAs(DateTime.now()));
        break;
      case RenewsEvery.Half_yearly:
        // Shows Latest Upcomming RENEW: no
        DateTime temp = subscription.startedOn.addHalfYear(-1);
        do {
          temp = temp.addHalfYear(1);
          _payments.addAll({temp.date: paidCost});
        } while (!temp.isAtSameMonthAs(DateTime.now()) &&
            !temp.isToday &&
            !temp.isAtSameYearAs(DateTime.now()));
        break;
      case RenewsEvery.Yearly:
        // Shows Latest or Upcomming RENEW: yes
        //(set condition if latest Subscription has happened or not)
        DateTime temp = subscription.startedOn.addYears(-1);
        do {
          temp = temp.addYears(1);
          _payments.addAll({temp.date: paidCost});
        } while (!temp.isAtSameMonthAs(DateTime.now()) &&
            !temp.isToday &&
            !temp.isAtSameYearAs(DateTime.now()));
        break;
    }
    Subscription updatesSubscription =
        subscription.copyWith(payments: _payments);
    await _subscriptionRepo.updateSubscription(
        subscription: updatesSubscription);
    return updatesSubscription;
  }

  @override
  Future<int?> calculateRemainingDays(Subscription oldSubscription) async {
    Subscription subscription = oldSubscription;
    print("Calculating Remaning Days for : ${subscription.brand.title}");
    if (subscription.renewsEvery == RenewsEvery.Never) {
      return null;
    }
    if (subscription.renewsEvery == RenewsEvery.Daily) {
      return 1;
    }
    if (subscription.payments == null) {
      subscription = await _calculatePayments(subscription);
    }
    if (subscription.payments!.entries.last.key.isBefore(DateTime.now())) {
      subscription = await _calculatePayments(subscription);
    }
    if (subscription.payments != null && subscription.payments!.isNotEmpty) {
      DateTime latestPayment = subscription.payments!.entries.last.key;
      print(latestPayment);
      int remaningDays = latestPayment.difference(DateTime.now().date).inDays;
      print(latestPayment.difference(DateTime.now().date).inDays);
      // NOTE check if this latest payment has happened or not (id negative than sub is happened)
      if (remaningDays.isNegative || remaningDays == 0) {
        if (subscription.renewsEvery == RenewsEvery.Monthly) {
          latestPayment = latestPayment.addMonths(1);
        }
        if (subscription.renewsEvery == RenewsEvery.Yearly) {
          latestPayment = latestPayment.addYears(1);
        }
        if (subscription.renewsEvery == RenewsEvery.Weekly) {
          latestPayment = latestPayment.add(Duration(days: 7));
        }
        if (subscription.renewsEvery == RenewsEvery.Biweekly) {
          latestPayment = latestPayment.add(Duration(days: 14));
        }
      }
      remaningDays = latestPayment.difference(DateTime.now().date).inDays;
      if (subscription.remaningDays != remaningDays) {
        await _subscriptionRepo.updateSubscription(
            subscription: subscription.copyWith(remaningDays: remaningDays));
      }
      return remaningDays;
    } else {
      return null;
    }
  }
}
