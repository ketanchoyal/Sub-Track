import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:sub_track/ui/resources/resources.dart';

void main() {
  test('assets assets test', () {
    expect(true, File(Assets.notificatons).existsSync());
    expect(true, File(Assets.boy1).existsSync());
    expect(true, File(Assets.boy3).existsSync());
    expect(true, File(Assets.boy2).existsSync());
    expect(true, File(Assets.mobile1).existsSync());
    expect(true, File(Assets.mobile2).existsSync());
    expect(true, File(Assets.addIcon).existsSync());
  });
}
