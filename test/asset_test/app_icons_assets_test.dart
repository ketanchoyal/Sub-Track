import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:sub_track/ui/resources/resources.dart';

void main() {
  test('app_icons_assets assets test', () {
    expect(true, File(AppIconsAssets.googleDark).existsSync());
    expect(true, File(AppIconsAssets.facebookDark).existsSync());
    expect(true, File(AppIconsAssets.apple).existsSync());
    expect(true, File(AppIconsAssets.google).existsSync());
    expect(true, File(AppIconsAssets.facebook).existsSync());
  });
}
