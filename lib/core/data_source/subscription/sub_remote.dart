import 'package:sub_track/core/data_source/subscription/sub_abstract.dart';
import 'package:sub_track/core/models/subscription/subscription.dart';

abstract class SubscriptionRemoteDataSource implements SubscriptionDataSource {
  late List<Subscription> _subscriptions;
  @override
  List<Subscription> get subscriptions => _subscriptions;
  cacheSubscriptions();
}

class SubscriptionRemoteDataSourceImpl with SubscriptionRemoteDataSource {
  @override
  addSubscription(Subscription subscription) {
    // TODO : implement addSubscription
    throw UnimplementedError();
  }

  @override
  cacheSubscriptions() {
    // TODO : implement cacheSubscriptions
    throw UnimplementedError();
  }

  @override
  deleteSubscription(Subscription subscription) {
    // TODO : implement deleteSubscription
    throw UnimplementedError();
  }

  @override
  fetchSubscriptions() {
    // TODO : implement fetchSubscriptions
    throw UnimplementedError();
  }

  @override
  updateSubscription(Subscription updatedSubscription) {
    // TODO : implement updateSubscription
    throw UnimplementedError();
  }
}
