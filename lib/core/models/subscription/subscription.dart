import 'package:hive/hive.dart';
import 'package:sub_track/core/enums/enums.dart';
import 'package:sub_track/core/models/brand/brand.dart';
part 'subscription.gx.dart';

@HiveType(typeId: 1)
class Subscription {
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
  @HiveField(9)
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
      if (brand.iconName == null)
        iconType = IconType.NONE;
      else
        iconType = IconType.EMOJI;
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
