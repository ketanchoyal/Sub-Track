import 'dart:convert';

class Subscription {
  Subscription({
    required this.hexColor,
    required this.id,
    required this.appName,
  }) {
    icon = "assets/appIcons/$id.png";
  }

  final String hexColor;
  final String id;
  final String appName;
  late final String icon;

  Subscription copyWith({
    String? hexColor,
    String? id,
    String? appName,
  }) =>
      Subscription(
        hexColor: hexColor ?? this.hexColor,
        id: id ?? this.id,
        appName: appName ?? this.appName,
      );

  factory Subscription.fromJson(String str) =>
      Subscription.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Subscription.fromMap(Map<String, dynamic> json) => Subscription(
        hexColor: json["hexColor"],
        id: json["id"],
        appName: json["appName"],
      );

  Map<String, dynamic> toMap() => {
        "hexColor": hexColor,
        "id": id,
        "appName": appName,
      };

  // List<Subscription> SubscriptionsFromMap(String str) => Map.from(
  //         json.decode(str))
  //     .map((k, v) => MapEntry<String, Subscription>(k, Subscription.fromMap(v)))
  //     .entries
  //     .map((entry) => entry.value)
  //     .toList();
}

class Subscriptions {
  final List<Subscription> subscriptions;

  Subscriptions({required this.subscriptions});

  factory Subscriptions.fromJson(String str) => Subscriptions(
      subscriptions: Map.from(json.decode(str))
          .map((k, v) =>
              MapEntry<String, Subscription>(k, Subscription.fromMap(v)))
          .entries
          .map((entry) => entry.value)
          .toList());
}
