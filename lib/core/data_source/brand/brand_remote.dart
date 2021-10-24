import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/core/data_source/brand/brand_abstract.dart';
import 'package:sub_track/core/data_source/brand/brand_local.dart';
import 'package:sub_track/core/models/brand/brand.dart';
import 'package:sub_track/core/services/brand_service.dart';

final brandRemoteDataSourceP = Provider<BrandRemoteDataSource>(
  (ref) => BrandRemoteDataSourceImpl(ref),
  dependencies: [
    brandServiceP,
    brandLocalDataStorageP,
  ],
  name: 'brandRemoteDataSourceP',
);

/// Require
///
/// [BrandService]
///
/// [BrandLocalDataSource]
abstract class BrandRemoteDataSource implements BrandDataSource {}

class BrandRemoteDataSourceImpl implements BrandRemoteDataSource {
  final ProviderRef _ref;
  BrandRemoteDataSourceImpl(this._ref);
  BrandService get _brandService => _ref.read(brandServiceP);

  BrandLocalDataSourceImpl get _brandLocalDataSource =>
      _ref.read(brandLocalDataStorageP) as BrandLocalDataSourceImpl;

  @override
  List<Brand>? get brands => _brandService.brands;

  _cacheBrands() {
    if (brands != null) _brandLocalDataSource.updateCache(brands!);
  }

  @override
  fetchBrands() async {
    await _brandService.fetchBrands();
    _cacheBrands();
  }
}
