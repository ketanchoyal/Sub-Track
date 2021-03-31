import 'package:sub_track/core/data_source/brand/brand_abstract.dart';
import 'package:sub_track/core/models/brand/brands.dart';

abstract class BrandLocalDataSource implements BrandDataSource {
  Future init();
  late Brands _brands;
  @override
  Brands get brands => _brands;
  updateCache(Brands brands);
}

class BrandLocalDataSourceImpl with BrandLocalDataSource {
  @override
  fetchBrands() {
    // TODO: implement fetchBrands
    throw UnimplementedError();
  }

  @override
  Future init() {
    // TODO: implement init
    throw UnimplementedError();
  }

  @override
  updateCache(Brands brands) {
    // TODO: implement updateCache
    throw UnimplementedError();
  }
}
