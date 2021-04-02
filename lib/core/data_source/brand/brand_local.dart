import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/core/data_source/brand/brand_abstract.dart';
import 'package:sub_track/core/models/brand/brands.dart';
import 'package:sub_track/core/models/brand/brand.dart';
import 'package:sub_track/core/services/file_service.dart';
import 'package:sub_track/ui/resources/resources.dart';

abstract class BrandLocalDataSource implements BrandDataSource {
  Future init();
  late List<Brand>? _brands;
  @override
  List<Brand>? get brands => _brands;
  Future updateCache(List<Brand> brands);
  List<Brand>? _brandsFromJson(String str);
}

class BrandLocalDataSourceImpl with BrandLocalDataSource {
  final _fileServices = locator<FileService>();
  final _hiveService = locator<HiveInterface>();
  final _brandBoxName = "brands";
  get _brandBoxIsOpen => _hiveService.isBoxOpen(_brandBoxName);
  Box<Brand> get _brandBox => _hiveService.box<Brand>(_brandBoxName);

  @override
  Future init() async {
    final path = await _fileServices.getApplicationDocumentsDirectoryPath();
    _hiveService.init(path);
    _hiveService.registerAdapter<Brand>(BrandAdapter());

    if (_brandBoxIsOpen) await _hiveService.openBox<Brand>(_brandBoxName);
  }

  @override
  fetchBrands() async {
    if (_brandBoxIsOpen) {
      Map<dynamic, Brand> brands = _brandBox.toMap();
      if (brands.isNotEmpty) {
        _brands = brands.entries.map((e) => e.value).toList();
        return;
      }
    }
    String data = await rootBundle.loadString(SubData.iconss);
    _brands = _brandsFromJson(data);
    return;
  }

  @override
  updateCache(List<Brand> brands) async {
    await _brandBox.putAll(
      {for (Brand brand in brands) brand.title: brand},
    );
  }

  @override
  List<Brand>? _brandsFromJson(String str) =>
      Brands.fromMap(json.decode(str)).brands;
}
