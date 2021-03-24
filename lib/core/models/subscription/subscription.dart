import 'package:sub_track/core/enums/enums.dart';
import 'package:sub_track/core/models/brand/brands.dart';

class Subscription {
  final Brand brand;
  final double cost;
  final String? description;

  final String subscriptionId;
  final RenewsEvery renewsEvery;
  final String? category;
  final int? sharedWith;
  final DateTime startedOn;
  final NotifyOn notificationOn;
  late final IconType iconType;
  late int? remaningDays;
  // TODO Research how to store amount paid until now with the date(hint: use map)

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
      iconType = IconType.EMOJI;
    }
  }

  String get renewsEveryValue => renewsEvery.value;
  String get renewsEveryInitial => renewsEvery.initial;
  String get notificationOnValue => notificationOn.value;

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
