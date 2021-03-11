import 'dart:io';

import 'package:sub_track/ui/resources/resources.dart';
import 'package:test/test.dart';

void main() {
  test('button_assets assets test', () {
    expect(true, File(ButtonAssets.googleDark).existsSync());
    expect(true, File(ButtonAssets.facebookDark).existsSync());
    expect(true, File(ButtonAssets.apple).existsSync());
    expect(true, File(ButtonAssets.google).existsSync());
    expect(true, File(ButtonAssets.facebook).existsSync());
  });
}
