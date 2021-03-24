import 'package:sub_track/core/models/brand/brands.dart';

abstract class BrandDataSource {
  Brands get brands;
  fetchBrands();
}
