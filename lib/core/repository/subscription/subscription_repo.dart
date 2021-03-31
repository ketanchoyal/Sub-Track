import 'package:sub_track/core/models/subscription/subscription.dart';

abstract class SubscriptionRepo {
  late List<Subscription> _subscriptions;
  List<Subscription> get subscriptions => _subscriptions;
  fetchSubscriptions({bool forceFetch = false});
  addSubscription({required Subscription subsription});
  deleteSubscription({required String subscriptionId});
  updateSubscription({required Subscription subsription});
}

class SubscriptionRepoStub with SubscriptionRepo {
  @override
  addSubscription({required Subscription subsription}) {
    // TODO: implement addSubscription
    throw UnimplementedError();
  }

  @override
  deleteSubscription({required String subscriptionId}) {
    // TODO: implement deleteSubscription
    throw UnimplementedError();
  }

  @override
  fetchSubscriptions({bool forceFetch = false}) {
    // TODO: implement fetchSubscriptions
    throw UnimplementedError();
  }

  @override
  updateSubscription({required Subscription subsription}) {
    // TODO: implement updateSubscription
    throw UnimplementedError();
  }
}
