import 'package:sub_track/core/models/brands.dart';
import 'package:sub_track/ui/resources/resources.dart';

abstract class BrandService {
  late Brands _brands;

  Brands get brands => _brands;

  bool _isNetworkAvailable = true;

  fetchBrands();

  _fetchFromLocal();

  _fetchFromServer();
}

class BrandServiceStub with BrandService {
  @override
  _fetchFromLocal() async {
    _brands = brandsFromMap(SubData.iconss);
  }

  @override
  _fetchFromServer() async {
    await Future.delayed(Duration(seconds: 2));
    _brands = brandsFromMap(SubData.iconss);
  }

  @override
  fetchBrands() async {
    if (_isNetworkAvailable)
      await _fetchFromServer();
    else
      await _fetchFromLocal();
    return _brands;
  }
}
