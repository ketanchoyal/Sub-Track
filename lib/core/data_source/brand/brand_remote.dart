import 'package:sub_track/core/data_source/brand/brand_abstract.dart';
import 'package:sub_track/core/models/brand/brands.dart';

abstract class BrandRemoteDataSource implements BrandDataSource {
  late Brands _brands;
  @override
  Brands get brands => _brands;
  sendDataToLocalSource();
}

class BrandRemoteDataSourceImpl with BrandRemoteDataSource {
  @override
  fetchBrands() {
    // TODO: implement fetchBrands
    throw UnimplementedError();
  }

  @override
  sendDataToLocalSource() {
    // TODO: implement sendDataToLocalSource
    throw UnimplementedError();
  }
}
