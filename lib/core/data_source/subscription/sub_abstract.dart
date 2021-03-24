import 'package:sub_track/core/models/subscription/subscription.dart';

abstract class SubscriptionDataSource {
  List<Subscription> get subscriptions;
  fetchSubscriptions();
  addSubscription(Subscription subscription);
  updateSubscription(Subscription updatedSubscription);
  deleteSubscription(Subscription subscription);
}
