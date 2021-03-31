import 'package:hive/hive.dart';

part "brand.g.dart";

// NOTE ID for Custom brand has to be created at the time of creating custom brand
// while ID for brands from server can be defined as there title
// REVIEW Do I really need id in Brand, Brand object can be stored in Subscription document?
// REVIEW Will it make any difference if I don't have id in brand
@HiveType(typeId: 0)
class Brand extends HiveObject {
  // Brand({
  //   required this.title,
  //   required this.hex,
  //   this.source,
  //   required this.iconName,
  //   required this.iconUrl,
  //   // this.id,
  // }) : id = title;
  // {
  //   if (id == null) {
  //     id = title;
  //   }
  // }

  Brand({
    required this.title,
    required this.hex,
    this.source,
    required this.iconName,
    required this.iconUrl,
    // this.id,
  });

  @HiveField(0)
  final String title;
  @HiveField(1)
  final String hex;
  @HiveField(2)
  final String? source;
  @HiveField(3)
  final String iconName;
  @HiveField(4)
  final String? iconUrl;
  // final String? id;

  Brand copyWith({
    String? title,
    String? hex,
    String? source,
    String? iconName,
    // required String id,
    String? iconUrl,
  }) =>
      Brand(
        title: title ?? this.title,
        hex: hex ?? this.hex,
        // id: id,
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
