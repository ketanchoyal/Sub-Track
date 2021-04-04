import 'dart:async';

import 'package:sub_track/core/models/subscription/subscription.dart';

abstract class SubscriptionDataSource {
  Stream<List<Subscription>> fetchSubscriptions();
  Future addSubscription(Subscription subscription);
  Future updateSubscription(Subscription updatedSubscription);
  Future deleteSubscription(Subscription subscription);
}
