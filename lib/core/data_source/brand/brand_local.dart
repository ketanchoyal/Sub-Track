import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/core/data_source/brand/brand_abstract.dart';
import 'package:sub_track/core/models/brand/brands.dart';
import 'package:sub_track/core/models/brand/brand.dart';
import 'package:sub_track/core/services/file_service.dart';
import 'package:sub_track/ui/resources/resources.dart';

final brandLocalDataStorageP = Provider<BrandLocalDataSource>(
  (ref) {
    return BrandLocalDataSourceImpl(ref);
  },
  dependencies: [
    fileServiceP,
    hiveP,
  ],
  name: 'brandLocalDataStorageP',
);

/// Require
///
/// [FileService]
///
/// [HiveInterface]
///
abstract class BrandLocalDataSource implements BrandDataSource {
  Future<void> init();
}

class BrandLocalDataSourceImpl implements BrandLocalDataSource {
  final ProviderRef _ref;
  BrandLocalDataSourceImpl(this._ref);
  List<Brand>? _brands;
  FileService get _fileServices => _ref.read(fileServiceP);
  HiveInterface get _hiveService => _ref.read(hiveP);
  final _brandBoxName = "brands";
  bool get _brandBoxIsOpen => _hiveService.isBoxOpen(_brandBoxName);
  Box<Brand> get _brandBox => _hiveService.box<Brand>(_brandBoxName);

  @override
  List<Brand>? get brands => _brands;

  @override
  Future init() async {
    if (!kIsWeb) {
      final path = await _fileServices.getApplicationDocumentsDirectoryPath();
      _hiveService.init(path);
    }
    _hiveService.registerAdapter<Brand>(BrandAdapter());

    if (!_brandBoxIsOpen) await _hiveService.openBox<Brand>(_brandBoxName);
  }

  @override
  fetchBrands() async {
    if (_brandBoxIsOpen) {
      List<Brand> brands = _brandBox.values.toList();
      if (brands.isNotEmpty) {
        _brands = brands;
        return;
      }
    }
    String data = await rootBundle.loadString(SubData.iconss);
    _brands = _brandsFromJson(data);
    return;
  }

  // @override
  updateCache(List<Brand> brands) async {
    await _brandBox.putAll(
      {for (Brand brand in brands) brand.title: brand},
    );
  }

  List<Brand>? _brandsFromJson(String str) =>
      Brands.fromMap(json.decode(str)).brands;
}
