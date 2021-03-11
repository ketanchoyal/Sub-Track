import 'dart:io';

import 'package:sub_track/ui/resources/resources.dart';
import 'package:test/test.dart';

void main() {
  test('assets assets test', () {
    expect(true, File(Assets.notificatons).existsSync());
    expect(true, File(Assets.boy1).existsSync());
    expect(true, File(Assets.boy3).existsSync());
    expect(true, File(Assets.boy2).existsSync());
    expect(true, File(Assets.mobile1).existsSync());
    expect(true, File(Assets.mobile2).existsSync());
  });
}
