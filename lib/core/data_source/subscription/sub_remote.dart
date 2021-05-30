import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/app/app.logger.dart';
import 'package:sub_track/core/data_source/subscription/sub_abstract.dart';
import 'package:sub_track/core/data_source/subscription/sub_local.dart';
import 'package:sub_track/core/models/subscription/subscription.dart';
import 'package:sub_track/core/services/firebase/subscription_service.dart';

/// Require
///
/// [SubscriptionService]
///
/// [SubscriptionLocalDataSource]
abstract class SubscriptionRemoteDataSource implements SubscriptionDataSource {
  // cacheSubscriptions();
}

class SubscriptionRemoteDataSourceImpl with SubscriptionRemoteDataSource {
  final logger = getLogger("SubscriptionRemoteDataSource");
  SubscriptionService get _subscriptionService =>
      locator<SubscriptionService>();

  SubscriptionLocalDataSource get _subscriptionLocalDataSource =>
      locator<SubscriptionLocalDataSource>();

  @override
  addSubscription(Subscription subscription) async {
    logger.d("In the addSubscription");
    await _subscriptionService.addSubscription(subscription);
  }

  // @override
  _cacheSubscriptions() async {
    // _subscriptionLocalDataSource.
  }

  @override
  deleteSubscription(String subscriptionId) async {
    await _subscriptionService.deleteSubscription(subscriptionId);
  }

  @override
  updateSubscription(Subscription updatedSubscription) async {
    logger.d("In the updateSubscription");
    await _subscriptionService.updateSubscription(updatedSubscription);
  }

  @override
  Stream<List<Subscription>> fetchSubscriptions() {
    return _subscriptionService.fetchSubscriptions();
  }
}
