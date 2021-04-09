import 'dart:async';

import 'package:sub_track/core/models/subscription/subscription.dart';

abstract class SubscriptionService {
  Stream<List<Subscription>> fetchSubscriptions();
  addSubscription(Subscription subscription);
  updateSubscription(Subscription updatedSubscription);
  deleteSubscription(String subscriptionId);
}

// NOTE Do not use await/async for Firestore transactions
class SubscriptionServiceImpl implements SubscriptionService {
  final StreamController<Subscription> _streamController =
      StreamController<Subscription>.broadcast();
  @override
  addSubscription(Subscription subscription) {
    // TODO: implement addSubscription
    return;
  }

  @override
  deleteSubscription(String subscriptionId) {
    // TODO: implement deleteSubscription
    return;
  }

  @override
  updateSubscription(Subscription updatedSubscription) {
    // TODO: implement updateSubscription
    return;
  }

  @override
  Stream<List<Subscription>> fetchSubscriptions() {
    // TODO: implement fetchSubscriptions
    return Stream.empty();
  }

  destroy() {
    _streamController.close();
  }
}
