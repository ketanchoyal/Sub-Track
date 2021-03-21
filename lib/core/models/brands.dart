// String brandsToMap(Brands data) => json.encode(data.toMap());
class Brands {
  Brands({
    required this.icons,
  });

  final List<Brand> icons;

  factory Brands.fromMap(Map<String, dynamic> json) => Brands(
        icons: List<Brand>.from(json["icons"].map((x) => Brand.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "icons": List<dynamic>.from(icons.map((x) => x.toMap())),
      };
}

class Brand {
  Brand({
    required this.title,
    required this.hex,
    this.source,
    required this.iconName,
    required this.iconUrl,
  });

  final String title;
  final String hex;
  final String? source;
  final String iconName;
  final String iconUrl;

  Brand copyWith({
    String? title,
    String? hex,
    String? source,
    String? iconName,
    String? iconUrl,
  }) =>
      Brand(
        title: title ?? this.title,
        hex: hex ?? this.hex,
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
