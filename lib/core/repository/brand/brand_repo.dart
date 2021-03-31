import 'package:sub_track/core/models/brand/brands.dart';

abstract class BrandRepo {
  late Brands _brands;
  Brands get brands => _brands;
  fetchBrands({bool forceFetch = false});
}

class BrandRepoStub with BrandRepo {
  @override
  fetchBrands({bool forceFetch = false}) {}
}
