import 'brand.dart';
// String brandsToMap(Brands data) => json.encode(data.toMap());

class Brands {
  Brands({
    this.brands,
  });

  final List<Brand>? brands;

  factory Brands.fromMap(Map<String, dynamic> json) => Brands(
        brands: List<Brand>.from(json["icons"].map((x) => Brand.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "icons": List<dynamic>.from(brands!.map((x) => x.toMap())),
      };
}
