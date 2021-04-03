import 'package:flutter/services.dart';
import 'package:sub_track/core/models/brand/brand.dart';
import 'package:sub_track/core/models/brand/brands.dart';
import 'package:sub_track/ui/resources/resources.dart';
import 'dart:convert';

abstract class BrandService {
  List<Brand>? get brands;
  fetchBrands();
}

class BrandServiceImpl with BrandService {
  List<Brand>? _brands;

  @override
  fetchBrands() async {
    if (_brands == null) {
      await Future.delayed(Duration(seconds: 2));
      String data = await rootBundle.loadString(SubData.iconss);
      _brands = _brandsFromJson(data);
    }
    return _brands;
  }

  @override
  List<Brand>? get brands => _brands;

  List<Brand>? _brandsFromJson(String str) =>
      Brands.fromMap(json.decode(str)).brands;
}
