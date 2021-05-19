import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FakeUser extends Fake implements User {
  @override
  String get uid => "fakeUId";

  @override
  String? get email => "fakeemail@gmail.com";

  @override
  String? get displayName => "fake name";

  @override
  Future<void> updateProfile({String? displayName, String? photoURL}) async {
    return;
  }
}
