import 'package:sub_track/core/models/brand/brands.dart';

abstract class BrandLocalDataSource {
  Future init();
  late Brands _brands;
  Brands get brands => _brands;
  fetchBrands();
  updateCache(Brands brands);
}
