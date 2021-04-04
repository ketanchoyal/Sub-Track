import 'dart:async';

import 'package:sub_track/core/models/subscription/subscription.dart';

abstract class SubscriptionService {
  Stream<List<Subscription>> fetchSubscriptions();
  addSubscription(Subscription subscription);
  updateSubscription(Subscription updatedSubscription);
  deleteSubscription(Subscription subscription);
}

// NOTE Do not use await/async for Firestore transactions
class SubscriptionServiceImpl implements SubscriptionService {
  final StreamController<Subscription> _streamController =
      StreamController<Subscription>.broadcast();
  @override
  addSubscription(Subscription subscription) {
    // TODO: implement addSubscription
    throw UnimplementedError();
  }

  @override
  deleteSubscription(Subscription subscription) {
    // TODO: implement deleteSubscription
    throw UnimplementedError();
  }

  @override
  updateSubscription(Subscription updatedSubscription) {
    // TODO: implement updateSubscription
    throw UnimplementedError();
  }

  @override
  Stream<List<Subscription>> fetchSubscriptions() {
    // TODO: implement fetchSubscriptions
    throw UnimplementedError();
  }

  destroy() {
    _streamController.close();
  }
}
