import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sub_track/core/services/brand_service.dart';

import '../../helpers/test_helpers.mocks.dart';

void main() {
  group("Brand Service - ", () {
    test('When brands are fetched Brand List should not be null', () async {
      final BrandService _brandService = BrandServiceImpl.test();
      await _brandService.fetchBrands();

      expect(_brandService.brands, isNotNull);
    });
  });
}
