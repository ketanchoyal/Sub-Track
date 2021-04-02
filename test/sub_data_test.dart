import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:sub_track/ui/resources/resources.dart';

void main() {
  test('sub_data assets test', () {
    expect(true, File(SubData.iconss).existsSync());
    expect(true, File(SubData.categoryIcon).existsSync());
  });
}
