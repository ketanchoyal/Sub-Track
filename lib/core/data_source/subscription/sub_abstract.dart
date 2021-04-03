import 'package:sub_track/core/models/subscription/subscription.dart';

abstract class SubscriptionDataSource {
  List<Subscription>? get subscriptions;
  Future fetchSubscriptions();
  Future addSubscription(Subscription subscription);
  Future updateSubscription(Subscription updatedSubscription);
  Future deleteSubscription(Subscription subscription);
}
