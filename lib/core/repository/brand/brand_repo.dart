import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/core/data_source/brand/brand_local.dart';
import 'package:sub_track/core/data_source/brand/brand_remote.dart';
import 'package:sub_track/core/models/brand/brand.dart';
import 'package:sub_track/core/services/connectivity_service.dart';
import 'package:sub_track/core/services/stoppable_services.dart';

final brandRepoP = Provider<BrandRepo>(
  (ref) => BrandRepoImpl(
    remote: ref.watch(brandRemoteDataSourceP),
    local: ref.watch(brandLocalDataStorageP),
    connectivityService: ref.watch(connectivityServiceP),
  ),
  dependencies: [
    brandRemoteDataSourceP,
    brandLocalDataStorageP,
    connectivityServiceP,
  ],
  name: 'brandRepoP',
);

/// Require
/// [BrandLocalDataSource],
///
/// [BrandRemoteDataSource] and
///
/// [ConnectivityService]
abstract class BrandRepo {
  List<Brand>? get brands;
  Future fetchBrands({bool forceFetch = false});
}

class BrandRepoImpl implements BrandRepo {
  // BrandLocalDataSource get _brandLocalDataSource =>
  //     locator<BrandLocalDataSource>();
  // BrandRemoteDataSource get _brandRemoteDataSource =>
  //     locator<BrandRemoteDataSource>();

  // ConnectivityService get _connectivityService =>
  //     locator<StoppableService>() as ConnectivityService;

  final BrandLocalDataSource _brandLocalDataSource;
  final BrandRemoteDataSource _brandRemoteDataSource;
  final ConnectivityService _connectivityService;

  List<Brand>? _brands;

  BrandRepoImpl({
    required BrandLocalDataSource local,
    required BrandRemoteDataSource remote,
    required ConnectivityService connectivityService,
  })  : _brandLocalDataSource = local,
        _brandRemoteDataSource = remote,
        _connectivityService = connectivityService;

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
