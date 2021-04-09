import 'package:emojis/emoji.dart';
import 'package:hive/hive.dart';
import 'package:sub_track/core/enums/enums.dart';
import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/core/models/brand/brand.dart';
// import 'package:time/time.dart';
// import 'package:dart_date/dart_date.dart' show addMonths;
part 'subscription.gx.dart';

@HiveType(typeId: 1)
class Subscription extends HiveObject {
  @HiveField(0)
  final Brand brand;
  @HiveField(1)
  final double cost;
  @HiveField(2)
  final String? description;

  @HiveField(3)
  final String subscriptionId;
  @HiveField(4)
  final RenewsEvery renewsEvery;

  @HiveField(5)
  final String? category;
  @HiveField(6)
  final int? sharedWith;
  @HiveField(7)
  final DateTime startedOn;
  @HiveField(8)
  final NotifyOn notificationOn;

  late final SubIconType iconType;
  late int? remaningDays;
  Map<DateTime, double> _payments = {};

  calculatePayments() async {
    double paidCost = cost;
    if (sharedWith != null) {
      if (sharedWith == 0) {
        paidCost = cost;
      } else {
        paidCost = (cost / sharedWith!);
      }
    }

    switch (renewsEvery) {
      case RenewsEvery.Never:
        _payments.addAll({startedOn.date: paidCost});
        break;
      case RenewsEvery.Daily:
        // Shows Latest Upcomming RENEW: yes
        Duration duration = DateTime.now().difference(startedOn);
        int noOfPaymentsMadeUntilNow = duration.inDays.abs();
        for (int i = 0; i <= noOfPaymentsMadeUntilNow; i++) {
          _payments.addAll({startedOn.add(Duration(days: i)).date: paidCost});
        }
        break;
      case RenewsEvery.Weekly:
        // Shows Latest Upcomming RENEW: yes
        Duration duration = DateTime.now().difference(startedOn);
        int noOfPaymentsMadeUntilNow = duration.inWeeks.abs();
        for (int i = 0; i <= noOfPaymentsMadeUntilNow; i++) {
          _payments
              .addAll({startedOn.add(Duration(days: i * 7)).date: paidCost});
        }
        break;
      case RenewsEvery.Biweekly:
        // Shows Latest Upcomming RENEW: yes
        Duration duration = DateTime.now().difference(startedOn);
        int noOfPaymentsMadeUntilNow = duration.inBiWeekly.abs();
        for (int i = 0; i <= noOfPaymentsMadeUntilNow; i++) {
          _payments
              .addAll({startedOn.add(Duration(days: i * 14)).date: paidCost});
        }
        break;
      case RenewsEvery.Monthly:
        // Shows Latest Upcomming RENEW: yes
        DateTime temp = startedOn.addMonths(-1);
        do {
          temp = temp.addMonths(1);
          _payments.addAll({temp.date: paidCost});
        } while (!temp.isAtSameMonthAs(DateTime.now()) && !temp.isToday);
        break;
      case RenewsEvery.Quarterly:
        // Shows Latest Upcomming RENEW: yes
        DateTime temp = startedOn.addQuarters(-1);
        do {
          temp = temp.addQuarters(1);
          _payments.addAll({temp.date: paidCost});
        } while (temp.difference(DateTime.now()).isNegative &&
            !temp.isAtSameMonthAs(DateTime.now()));
        break;
      case RenewsEvery.Half_yearly:
        // Shows Latest Upcomming RENEW: no
        DateTime temp = startedOn.addHalfYear(-1);
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
        DateTime temp = startedOn.addYears(-1);
        do {
          temp = temp.addYears(1);
          _payments.addAll({temp.date: paidCost});
        } while (!temp.isAtSameMonthAs(DateTime.now()) &&
            !temp.isToday &&
            !temp.isAtSameYearAs(DateTime.now()));
        break;
    }
  }

  calculateRemaningDays() async {
    if (_payments.isEmpty) await calculatePayments();

    DateTime latestPayment = _payments.entries.last.key;
    remaningDays = latestPayment.difference(DateTime.now().date).inDays.abs();
  }

  Subscription({
    required this.brand,
    required this.cost,
    this.description,
    required this.renewsEvery,
    this.category,
    this.sharedWith,
    required this.subscriptionId,
    required this.startedOn,
    required this.notificationOn,
  }) {
    if (brand.iconUrl == null) {
      if (brand.iconName == null)
        iconType = SubIconType.NONE;
      else
        iconType = Emoji.isEmoji(brand.iconName!)
            ? SubIconType.EMOJI
            : SubIconType.NONE;
    } else {
      iconType = SubIconType.SVG;
    }
  }

  /// Meant to only use by Hive Adaptor
  factory Subscription.noEnum({
    required Brand brand,
    required double cost,
    String? description,
    required String subscriptionId,
    required String renewsEvery,
    String? category,
    int? sharedWith,
    required DateTime startedOn,
    required String notificationOn,
    String? iconType,
    int? remaningDays,
  }) =>
      Subscription(
        category: category,
        description: description,
        sharedWith: sharedWith,
        brand: brand,
        cost: cost,
        renewsEvery: renewsEvery.enumRE,
        subscriptionId: subscriptionId,
        startedOn: startedOn,
        notificationOn: notificationOn.enumNO,
      );

  String get renewsEveryValue => renewsEvery.value;
  String get renewsEveryInitial => renewsEvery.initial;
  String get notificationOnValue => notificationOn.value;
  String get iconTypeValue => iconType.value;

  Subscription copyWith({
    Brand? brand,
    double? cost,
    String? description,
    RenewsEvery? renewsEvery,
    String? category,
    int? sharedWith,
    DateTime? startedOn,
    required String subscriptionId,
    NotifyOn? notificationOn,
  }) =>
      Subscription(
        brand: brand ?? this.brand,
        cost: cost ?? this.cost,
        description: description ?? this.description,
        renewsEvery: renewsEvery ?? this.renewsEvery,
        category: category ?? this.category,
        sharedWith: sharedWith ?? this.sharedWith,
        startedOn: startedOn ?? this.startedOn,
        subscriptionId: subscriptionId,
        notificationOn: notificationOn ?? this.notificationOn,
      );
}
