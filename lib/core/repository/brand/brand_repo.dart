import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/core/data_source/brand/brand_local.dart';
import 'package:sub_track/core/data_source/brand/brand_remote.dart';
import 'package:sub_track/core/models/brand/brand.dart';
import 'package:sub_track/core/services/connectivity_service.dart';

abstract class BrandRepo {
  List<Brand>? get brands;
  Future fetchBrands({bool forceFetch = false});
}

class BrandRepoImpl implements BrandRepo {
  BrandLocalDataSource get _brandLocalDataSource =>
      locator<BrandLocalDataSource>();
  BrandRemoteDataSource get _brandRemoteDataSource =>
      locator<BrandRemoteDataSource>();

  ConnectivityService get _connectivityService =>
      locator<ConnectivityService>();

  List<Brand>? _brands;

  @override
  List<Brand>? get brands => _brands;

  @override
  fetchBrands({bool forceFetch = false}) async {
    if (await _connectivityService.checkConnectivity() && forceFetch) {
      await _brandRemoteDataSource.fetchBrands();
      _brands = _brandRemoteDataSource.brands;
      if (_brands == null) fetchBrands(forceFetch: false);
    } else {
      await _brandLocalDataSource.fetchBrands();
      _brands = _brandLocalDataSource.brands;
    }
  }
}
