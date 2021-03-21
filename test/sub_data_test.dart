import 'dart:io';

import 'package:sub_track/ui/resources/resources.dart';
import 'package:test/test.dart';

void main() {
  test('sub_data assets test', () {
    expect(true, File(SubData.iconss).existsSync());
    expect(true, File(SubData.categoryIcon).existsSync());
  });
}
