import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/test_helpers.dart';

void main() {
  group("Subscription Service - ", () {
    setUp(() async {
      await getAndRegisterFirebaseAuthenticationService(successFullLogin: true);
    });
    tearDown(() => unregisterAll());

    test("should add Subscription to firestore", () async {});
    test("should update Subscription to firestore", () async {});
    test("should delete Subscription from firestore", () async {});
    test("should get Subscription Stream from firestore", () async {});
  });
}
