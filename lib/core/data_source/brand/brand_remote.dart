import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/core/data_source/brand/brand_abstract.dart';
import 'package:sub_track/core/data_source/brand/brand_local.dart';
import 'package:sub_track/core/models/brand/brand.dart';
import 'package:sub_track/core/services/brand_service.dart';

abstract class BrandRemoteDataSource implements BrandDataSource {}

class BrandRemoteDataSourceImpl with BrandRemoteDataSource {
  BrandService get _brandService => locator<BrandService>();

  @override
  List<Brand>? get brands => _brandService.brands;

  BrandLocalDataSourceImpl get _brandLocalDataSource =>
      locator<BrandLocalDataSource>() as BrandLocalDataSourceImpl;

  _cacheBrands() {
    if (brands != null) _brandLocalDataSource.updateCache(brands!);
  }

  @override
  fetchBrands() async {
    await _brandService.fetchBrands();
    _cacheBrands();
  }
}
