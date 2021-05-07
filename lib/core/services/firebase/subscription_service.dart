import 'dart:async';

import 'package:sub_track/core/models/subscription/subscription.dart';
import 'package:sub_track/core/services/firebase/firestore.dart';

abstract class SubscriptionService {
  Stream<List<Subscription>> fetchSubscriptions();
  addSubscription(Subscription subscription);
  updateSubscription(Subscription updatedSubscription);
  deleteSubscription(String subscriptionId);
}

// NOTE Do not use await/async for Firestore transactions
class SubscriptionServiceImpl with Firestore implements SubscriptionService {
  final StreamController<Subscription> _streamController =
      StreamController<Subscription>.broadcast();
  @override
  addSubscription(Subscription subscription) {
    if (currentUserSubCollRef != null)
      currentUserSubCollRef!
          .doc(subscription.subscriptionId)
          .set(subscription.toJson());
    else {
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
    if (currentUserSubCollRef != null)
      currentUserSubCollRef!
          .doc(updatedSubscription.subscriptionId)
          .update(updatedSubscription.toJson());
    else {
      //Error Snack bar from here
    }
  }

  // NOTE Why Do I need this function? Subs are fethed from local all the time, Remote is just used to store dat
  // FIXME Instead of this function, can I make a function to sync local data with the remote data when user logs in First time?
  // NOTE Requires Testing
  @override
  Stream<List<Subscription>> fetchSubscriptions() {
    if (currentUserSubCollRef != null)
      return currentUserSubCollRef!
          .snapshots(includeMetadataChanges: true)
          .map<List<Subscription>>((event) {
        return event.docs
            .map((snapshot) => Subscription.fromJson(snapshot.data()))
            .toList();
      });
    else {
      return Stream.empty();
      //Error Snack bar from here
    }
  }

  destroy() {
    _streamController.close();
  }
}
