import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sub_track/app/app.logger.dart';
import 'package:sub_track/core/models/subscription/subscription.dart';
import 'package:sub_track/core/services/firebase/firestore.dart';

abstract class SubscriptionService {
  Stream<List<Subscription>> fetchSubscriptions();
  addSubscription(Subscription subscription);
  updateSubscription(Subscription updatedSubscription);
  deleteSubscription(String subscriptionId);
  Future<List<Subscription>> getSubscriptions();
}

// NOTE Do not use await/async for Firestore transactions
class SubscriptionServiceImpl with Firestore implements SubscriptionService {
  final StreamController<List<Subscription>> _streamController =
      StreamController<List<Subscription>>.broadcast();
  final logger = getLogger("SubscriptionService");
  @override
  addSubscription(Subscription subscription) {
    if (currentUserSubCollRef != null) {
      currentUserSubCollRef!
          .doc(subscription.subscriptionId)
          .set(subscription.toJson());
      logger.i("Sub added to Firestore");
    } else {
      //Error Snack bar from here
    }
  }

  @override
  deleteSubscription(String subscriptionId) {
    if (currentUserSubCollRef != null)
      currentUserSubCollRef!.doc(subscriptionId).delete();
    else {
      //Error Snack bar from here
    }
  }

  @override
  updateSubscription(Subscription updatedSubscription) {
    if (currentUserSubCollRef != null) {
      currentUserSubCollRef!
          .doc(updatedSubscription.subscriptionId)
          .set(updatedSubscription.toJson(), SetOptions(merge: true));
      logger.i("Sub updated to Firestore");
    } else {
      //Error Snack bar from here
    }
  }

  // NOTE Why Do I need this function? Subs are fethed from local all the time, Remote is just used to store dat
  // FIXME Instead of this function, can I make a function to sync local data with the remote data when user logs in First time?
  @override
  Stream<List<Subscription>> fetchSubscriptions() {
    if (currentUserSubCollRef != null) {
      logger.i("fetching from Firebase");
      currentUserSubCollRef!
          .withConverter<Subscription>(
            fromFirestore: (snapshot, _) =>
                Subscription.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson(),
          )
          .snapshots(includeMetadataChanges: true)
          .map<List<Subscription>>((event) {
        return event.docs.map((snapshot) => snapshot.data()).toList();
      }).listen((event) => _streamController.add(event));
      // return currentUserSubCollRef!
      //     .snapshots(includeMetadataChanges: true)
      //     .map<List<Subscription>>((event) {
      //   return event.docs
      //       .map((snapshot) => Subscription.fromJson(snapshot.data()))
      //       .toList();
      // });
      return _streamController.stream;
    } else {
      return Stream.empty();
      //Error Snack bar from here
    }
  }

  @override
  Future<List<Subscription>> getSubscriptions() async {
    if (currentUserSubCollRef != null) {
      logger.i("fetching from Firebase");
      return (await currentUserSubCollRef!
              .withConverter<Subscription>(
                fromFirestore: (snapshot, _) =>
                    Subscription.fromJson(snapshot.data()!),
                toFirestore: (model, _) => model.toJson(),
              )
              .limit(20)
              .get())
          .docs
          .map((e) => e.data())
          .toList();
    } else {
      return List.empty();
    }
  }

  destroy() {
    _streamController.close();
  }
}
