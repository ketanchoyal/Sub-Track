import 'package:sub_track/core/data_source/subscription/sub_abstract.dart';
import 'package:sub_track/core/models/subscription/subscription.dart';

abstract class SubscriptionLocalDataSource implements SubscriptionDataSource {
  Future init();
  late List<Subscription> _subscriptions;
  @override
  List<Subscription> get subscriptions => _subscriptions;
  updateCache(List<Subscription> subscriptions);
}

class SubscriptionLocalDataSourceImpl with SubscriptionLocalDataSource {
  @override
  addSubscription(Subscription subscription) {
    // TODO: implement addSubscription
    throw UnimplementedError();
  }

  @override
  fetchSubscriptions() {
    // TODO: implement fetchSubscriptions
    throw UnimplementedError();
  }

  @override
  Future init() {
    // TODO: implement init
    throw UnimplementedError();
  }

  @override
  updateCache(List<Subscription> subscriptions) {
    // TODO: implement updateCache
    throw UnimplementedError();
  }

  @override
  updateSubscription(Subscription updatedSubscription) {
    // TODO: implement updateSubscription
    throw UnimplementedError();
  }

  @override
  deleteSubscription(Subscription subscription) {
    // TODO: implement deleteSubscription
    throw UnimplementedError();
  }
}
