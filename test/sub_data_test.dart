import 'dart:io';

import 'package:sub_track/ui/resources/resources.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('sub_data assets test', () {
    expect(true, File(SubData.imagesData).existsSync());
    expect(true, File(SubData.categoryIcon).existsSync());
  });
}
