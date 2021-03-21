import 'package:flutter/services.dart';
import 'package:sub_track/core/models/brands.dart';
import 'package:sub_track/ui/resources/resources.dart';

abstract class BrandService {
  Brands? _brands;

  Brands? get brands => _brands;

  bool _isNetworkAvailable = false;

  fetchBrands({bool forceFetch = false});

  _fetchFromLocal();

  _fetchFromServer();
}

class BrandServiceStub with BrandService {
  @override
  _fetchFromLocal() async {
    String data = await rootBundle.loadString(SubData.iconss);
    _brands = brandsFromMap(data);
  }

  @override
  _fetchFromServer() async {
    await Future.delayed(Duration(seconds: 2));
    String data = await rootBundle.loadString(SubData.iconss);
    _brands = brandsFromMap(data);
  }

  @override
  fetchBrands({bool forceFetch = false}) async {
    if (forceFetch) {
      if (_isNetworkAvailable)
        await _fetchFromServer();
      else
        await _fetchFromLocal();
    } else if (_brands == null) if (_isNetworkAvailable)
      await _fetchFromServer();
    else
      await _fetchFromLocal();
    return _brands;
  }
}
