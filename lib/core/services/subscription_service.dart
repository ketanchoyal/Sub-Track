import 'package:sub_track/core/models/subscription/subscription.dart';

abstract class SubscriptionService {
  List<Subscription>? get subscriptions;
  Future fetchSubscriptions();
  Future addSubscription(Subscription subscription);
  Future updateSubscription(Subscription updatedSubscription);
  Future deleteSubscription(Subscription subscription);
}

class SubscriptionServiceImpl implements SubscriptionService {
  @override
  // TODO: implement subscriptions
  List<Subscription>? get subscriptions => throw UnimplementedError();

  @override
  Future addSubscription(Subscription subscription) async {
    // TODO: implement addSubscription
    throw UnimplementedError();
  }

  @override
  Future deleteSubscription(Subscription subscription) async {
    // TODO: implement deleteSubscription
    throw UnimplementedError();
  }

  @override
  Future fetchSubscriptions() async {
    // TODO: implement fetchSubscriptions
    throw UnimplementedError();
  }

  @override
  Future updateSubscription(Subscription updatedSubscription) async {
    // TODO: implement updateSubscription
    throw UnimplementedError();
  }
}
