import 'dart:io';

import 'package:sub_track/ui/resources/resources.dart';
import 'package:test/test.dart';

void main() {
  test('app_icons_assets assets test', () {
    expect(true, File(AppIconsAssets.googleDark).existsSync());
    expect(true, File(AppIconsAssets.facebookDark).existsSync());
    expect(true, File(AppIconsAssets.apple).existsSync());
    expect(true, File(AppIconsAssets.google).existsSync());
    expect(true, File(AppIconsAssets.facebook).existsSync());
  });
}
