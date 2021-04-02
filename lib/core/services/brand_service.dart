import 'package:flutter/services.dart';
import 'package:sub_track/core/models/brand/brand.dart';
import 'package:sub_track/core/models/brand/brands.dart';
import 'package:sub_track/ui/resources/resources.dart';
import 'dart:convert';

abstract class BrandService {
  List<Brand>? _brands;

  List<Brand>? get brands => _brands;

  fetchBrands();

  List<Brand>? _brandsFromJson(String str);
}

class BrandServiceImpl with BrandService {
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
  List<Brand>? _brandsFromJson(String str) =>
      Brands.fromMap(json.decode(str)).brands;
}
