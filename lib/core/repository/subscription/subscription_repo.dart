import 'package:sub_track/core/models/subscription/subscription.dart';

abstract class SubscriptionRepo {
  fetchSubscriptions();
  addSubscription({Subscription subsription});
  deleteSubscription({String subscriptionId});
  updateSubscription({Subscription subsription});
}
