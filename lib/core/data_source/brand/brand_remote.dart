import 'package:sub_track/core/data_source/brand/brand_abstract.dart';
import 'package:sub_track/core/models/brand/brand.dart';

abstract class BrandRemoteDataSource implements BrandDataSource {
  late List<Brand>? _brands;
  @override
  List<Brand>? get brands => _brands;
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
