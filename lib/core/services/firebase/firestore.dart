import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:sub_track/app/app.locatorx.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class Firestore {
  final _firebaseAuthenticationService =
      locator<FirebaseAuthenticationService>();

  final firestore = FirebaseFirestore.instance;

  String? get userId {
    return _firebaseAuthenticationService.currentUser?.uid;
  }

  User? get user {
    return _firebaseAuthenticationService.currentUser;
  }

  CollectionReference get rootUserCollRef {
    return firestore.collection("users");
  }

  DocumentReference? get currentUserDocRef {
    return userId == null ? null : rootUserCollRef.doc(userId!);
  }

  CollectionReference? get currentUserSubCollRef {
    return userId == null
        ? null
        : currentUserDocRef!.collection("subscriptions");
  }
}
