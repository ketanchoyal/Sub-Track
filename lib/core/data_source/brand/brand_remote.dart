import 'package:sub_track/core/models/brand/brands.dart';

abstract class BrandRemoteDataSource {
  late Brands _brands;
  Brands get brands => _brands;
  fetchBrands();
  sendDataToLocalSource();
}
