import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';

final firebaseAuthServiceP = Provider<FirebaseAuthenticationService>(
  (ref) => FirebaseAuthenticationService(),
  name: "firebaseAuthServiceP",
);
