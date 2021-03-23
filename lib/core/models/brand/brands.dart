// String brandsToMap(Brands data) => json.encode(data.toMap());
part 'brand.dart';

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
