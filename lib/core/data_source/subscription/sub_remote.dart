import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/core/data_source/subscription/sub_abstract.dart';
import 'package:sub_track/core/data_source/subscription/sub_local.dart';
import 'package:sub_track/core/models/subscription/subscription.dart';
import 'package:sub_track/core/services/subscription_service.dart';

abstract class SubscriptionRemoteDataSource implements SubscriptionDataSource {
  // cacheSubscriptions();
}

class SubscriptionRemoteDataSourceImpl with SubscriptionRemoteDataSource {
  SubscriptionService get _subscriptionService =>
      locator<SubscriptionService>();

  SubscriptionLocalDataSource get _subscriptionLocalDataSource =>
      locator<SubscriptionLocalDataSource>();

  @override
  List<Subscription>? get subscriptions => _subscriptionService.subscriptions;

  @override
  addSubscription(Subscription subscription) async {
    await _subscriptionService.addSubscription(subscription);
  }

  // @override
  _cacheSubscriptions() async {
    // _subscriptionLocalDataSource.
  }

  @override
  deleteSubscription(Subscription subscription) async {
    await _subscriptionService.deleteSubscription(subscription);
  }

  @override
  fetchSubscriptions() async {
    await _subscriptionService.fetchSubscriptions();
  }

  @override
  updateSubscription(Subscription updatedSubscription) async {
    await _subscriptionService.updateSubscription(updatedSubscription);
  }
}
