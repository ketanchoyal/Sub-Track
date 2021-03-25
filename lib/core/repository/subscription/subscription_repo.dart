import 'package:sub_track/core/models/subscription/subscription.dart';

abstract class SubscriptionRepo {
  late List<Subscription> _subscriptions;
  List<Subscription> get subscriptions => _subscriptions;
  fetchSubscriptions({bool forceFetch = false});
  addSubscription({Subscription subsription});
  deleteSubscription({String subscriptionId});
  updateSubscription({Subscription subsription});
}
