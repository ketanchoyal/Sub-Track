import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sub_track/core/models/brand/brand.dart';
import 'package:sub_track/core/models/brand/brands.dart';
import 'package:sub_track/ui/resources/resources.dart';
import 'dart:convert';

abstract class BrandService {
  List<Brand>? get brands;
  fetchBrands();
}

// NOTE This class is supposed to fetch data from server but as of now it only fetches from local storage
class BrandServiceImpl with BrandService {
  List<Brand>? _brands;
  bool _forTesting = false;

  BrandServiceImpl.test() {
    _forTesting = true;
  }

  BrandServiceImpl();

  @override
  fetchBrands() async {
    if (_brands == null) {
      await Future.delayed(Duration(seconds: 2));
      if (_forTesting) {
        _brands = _brandsFromJson(_testBrands);
      } else {
        String data = await rootBundle.loadString(SubData.iconss);
        _brands = _brandsFromJson(data);
      }
    }
    return _brands;
  }

  @override
  List<Brand>? get brands => _brands;

  List<Brand>? _brandsFromJson(str) =>
      Brands.fromMap(_forTesting ? str : json.decode(str)).brands;
}

Map<String, dynamic> _testBrands = {
  "icons": [
    {
      "title": "1001Tracklists",
      "hex": "40AEF0",
      "source": "https://www.1001tracklists.com/",
      "iconName": "1001tracklists.svg",
      "iconUrl":
          "https://raw.githubusercontent.com/ketanchoyal/simple-icons/master/icons/1001tracklists.svg"
    },
    {
      "title": "1Password",
      "hex": "0094F5",
      "source": "https://1password.com/press/",
      "iconName": "1password.svg",
      "iconUrl":
          "https://raw.githubusercontent.com/ketanchoyal/simple-icons/master/icons/1password.svg"
    }
  ]
};
