// To parse this JSON data, do
//
//     final subscriptions = subscriptionsFromMap(jsonString);

import 'dart:convert';

Subscriptions subscriptionsFromMap(String str) =>
    Subscriptions.fromMap(json.decode(str));

String subscriptionsToMap(Subscriptions data) => json.encode(data.toMap());

class Subscriptions {
  Subscriptions({
    required this.icons,
  });

  final List<Subscription> icons;

  factory Subscriptions.fromMap(Map<String, dynamic> json) => Subscriptions(
        icons: List<Subscription>.from(
            json["icons"].map((x) => Subscription.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "icons": List<dynamic>.from(icons.map((x) => x.toMap())),
      };
}

class Subscription {
  Subscription({
    required this.title,
    required this.hex,
    required this.source,
    required this.iconName,
    required this.iconUrl,
  });

  final String title;
  final String hex;
  final String source;
  final String iconName;
  final String iconUrl;

  Subscription copyWith({
    String? title,
    String? hex,
    String? source,
    String? iconName,
    String? iconUrl,
  }) =>
      Subscription(
        title: title ?? this.title,
        hex: hex ?? this.hex,
        source: source ?? this.source,
        iconName: iconName ?? this.iconName,
        iconUrl: iconUrl ?? this.iconUrl,
      );

  factory Subscription.fromMap(Map<String, dynamic> json) => Subscription(
        title: json["title"],
        hex: json["hex"],
        source: json["source"],
        iconName: json["iconName"],
        iconUrl: json["iconUrl"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "hex": hex,
        "source": source,
        "iconName": iconName,
        "iconUrl": iconUrl,
      };
}
