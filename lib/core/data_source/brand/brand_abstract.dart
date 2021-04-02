import 'package:sub_track/core/models/brand/brand.dart';

abstract class BrandDataSource {
  List<Brand>? get brands;
  Future fetchBrands();
}
