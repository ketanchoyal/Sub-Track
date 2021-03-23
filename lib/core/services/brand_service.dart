import 'package:flutter/services.dart';
import 'package:sub_track/core/models/brand/brands.dart';
import 'package:sub_track/ui/resources/resources.dart';
import 'dart:convert';

abstract class BrandService {
  Brands? _brands;

  Brands? get brands => _brands;

  bool _isNetworkAvailable = false;

  fetchBrands({bool forceFetch = false});

  Brands _brandsFromJson(String str);

  addCustomBrand(Brand brand);

  _addCustomBrandToLocal(Brand brand);

  _addCustomBrandToServer(Brand brand);

  fetchCustomBrands();

  _fetchFromLocal();

  _fetchFromServer();
}

class BrandServiceStub with BrandService {
  @override
  _fetchFromLocal() async {
    String data = await rootBundle.loadString(SubData.iconss);
    _brands = _brandsFromJson(data);
  }

  @override
  _fetchFromServer() async {
    await Future.delayed(Duration(seconds: 2));
    String data = await rootBundle.loadString(SubData.iconss);
    _brands = _brandsFromJson(data);
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

  @override
  Brands _brandsFromJson(String str) => Brands.fromMap(json.decode(str));

  @override
  _addCustomBrandToLocal(Brand brand) {
    // TODO: implement _addCustomBrandToLocal
    throw UnimplementedError();
  }

  @override
  _addCustomBrandToServer(Brand brand) {
    // TODO: implement _addCustomBrandToServer
    throw UnimplementedError();
  }

  @override
  addCustomBrand(Brand brand) {
    // TODO: implement addCustomBrand
    throw UnimplementedError();
  }

  @override
  fetchCustomBrands() {
    // TODO: implement fetchCustomBrands
    throw UnimplementedError();
  }
}
