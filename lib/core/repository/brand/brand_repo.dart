import 'package:sub_track/core/models/brand/brands.dart';

abstract class BrandRepo {
  late Brands _brands;
  Brands get brands => _brands;
  fetchBrands({bool forceFetch = false});
}

class BrandRepoImpl with BrandRepo {
  @override
  fetchBrands({bool forceFetch = false}) {}
}
