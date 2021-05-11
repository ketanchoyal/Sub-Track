import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emojis/emoji.dart';
import 'package:hive/hive.dart';
import 'package:sub_track/core/enums/enums.dart';
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
  @HiveField(9)
  final Map<DateTime, double>? payments;
  @HiveField(10)
  final int? remaningDays;

  late final SubIconType iconType;

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
    this.payments,
    this.remaningDays,
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
    Map<DateTime, double>? payments,
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
        remaningDays: remaningDays,
        payments: payments,
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
    String? subscriptionId,
    NotifyOn? notificationOn,
    Map<DateTime, double>? payments,
    int? remaningDays,
  }) =>
      Subscription(
        brand: brand ?? this.brand,
        cost: cost ?? this.cost,
        description: description ?? this.description,
        renewsEvery: renewsEvery ?? this.renewsEvery,
        category: category ?? this.category,
        sharedWith: sharedWith ?? this.sharedWith,
        startedOn: startedOn ?? this.startedOn,
        subscriptionId: subscriptionId ?? this.subscriptionId,
        notificationOn: notificationOn ?? this.notificationOn,
        payments: payments ?? this.payments,
        remaningDays: remaningDays ?? this.remaningDays,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "category": category,
        "description": description,
        "sharedWith": sharedWith,
        "brand": brand.toMap(),
        "cost": cost,
        "renewsEvery": renewsEveryValue,
        "subscriptionId": subscriptionId,
        "startedOn": startedOn,
        "notificationOn": notificationOnValue,
        "remaningDays": remaningDays,
        "payments": payments?.map<String, double>(
            (key, value) => MapEntry(key.toString().split(" ")[0], value)),
      };

  factory Subscription.fromJson(Map<String, dynamic> json) =>
      Subscription.noEnum(
        brand: Brand.fromMap(json['brand']),
        cost: json['cost'] as double,
        description: json['description'] as String?,
        subscriptionId: json['subscriptionId'] as String,
        renewsEvery: json['renewsEvery'] as String,
        category: json['category'] as String?,
        sharedWith: json['sharedWith'] as int?,
        startedOn: (json['startedOn'] as Timestamp).toDate(),
        notificationOn: json['notificationOn'] as String,
        payments: (json['payments'] as Map?)
            ?.cast<String, double>()
            .map<DateTime, double>(
                (key, value) => MapEntry(DateTime.parse(key), value)),
        remaningDays: json['remaningDays'] as int?,
      );
}

extension SubscriptionX on Subscription {
  DateTime? nextSubOn(int? days) {
    return days == null ? null : DateTime.now().add(Duration(days: days));
  }
}
