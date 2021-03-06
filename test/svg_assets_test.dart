import 'dart:io';

import 'package:sub_track/ui/resources/resources.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('svg_assets assets test', () {
    expect(true, File(SvgAssets.mobile2).existsSync());
    expect(true, File(SvgAssets.mobile1).existsSync());
    expect(true, File(SvgAssets.boy2).existsSync());
    expect(true, File(SvgAssets.boy3).existsSync());
    expect(true, File(SvgAssets.notificatons).existsSync());
    expect(true, File(SvgAssets.boy1).existsSync());
  });
}
