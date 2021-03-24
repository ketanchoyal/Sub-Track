part of "brands.dart";

// NOTE ID for Custom brand has to be created at the time of creating custom brand
// while ID for brands from server can be defined ad there title
// REVIEW Do I really need id in Brand, Brand object can be stored in Subscription document?
// REVIEW Will it make any difference if I don't have id in brand
class Brand {
  Brand({
    required this.title,
    required this.hex,
    this.source,
    required this.iconName,
    required this.iconUrl,
    this.id,
  }) {
    if (id == null) {
      id = title;
    }
  }

  final String title;
  final String hex;
  final String? source;
  final String iconName;
  final String? iconUrl;
  late final String? id;

  Brand copyWith({
    String? title,
    String? hex,
    String? source,
    String? iconName,
    required String id,
    String? iconUrl,
  }) =>
      Brand(
        title: title ?? this.title,
        hex: hex ?? this.hex,
        id: id,
        source: source ?? this.source,
        iconName: iconName ?? this.iconName,
        iconUrl: iconUrl ?? this.iconUrl,
      );

  factory Brand.fromMap(Map<String, dynamic> json) => Brand(
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
