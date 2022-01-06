import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/app/app.logger.dart';
import 'package:sub_track/core/data_source/subscription/sub_abstract.dart';
import 'package:sub_track/core/data_source/subscription/sub_local.dart';
import 'package:sub_track/core/models/subscription/subscription.dart';
import 'package:sub_track/core/services/firebase/subscription_service.dart';

final subscriptionRemoteDataSourceP = Provider<SubscriptionRemoteDataSource>(
  (ref) => SubscriptionRemoteDataSourceImpl(ref),
  dependencies: [
    subscriptionServiceP,
  ],
  name: 'subscriptionRemoteDataSourceP',
);

/// Require
///
/// [SubscriptionService]
///
/// [SubscriptionLocalDataSource]
abstract class SubscriptionRemoteDataSource implements SubscriptionDataSource {
  // cacheSubscriptions();
}

class SubscriptionRemoteDataSourceImpl implements SubscriptionRemoteDataSource {
  final ProviderRef _ref;
  SubscriptionRemoteDataSourceImpl(this._ref);
  final logger = getLogger("SubscriptionRemoteDataSource");
  SubscriptionService get _subscriptionService =>
      _ref.read(subscriptionServiceP);

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
  Stream<List<Subscription>> fetchSubscriptions([String? category]) {
    return _subscriptionService.fetchSubscriptions(category);
  }
}
