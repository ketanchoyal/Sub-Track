import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/core/data_source/subscription/sub_local.dart';
import 'package:sub_track/core/data_source/subscription/sub_remote.dart';
import 'package:sub_track/core/models/subscription/subscription.dart';
import 'package:sub_track/core/services/connectivity_service.dart';

/// Require
/// [SubscriptionLocalDataSource],
///
/// [SubscriptionRemoteDataSource] and
///
/// [ConnectivityService]
abstract class SubscriptionRepo {
  Future<Stream<List<Subscription>>> fetchSubscriptions(
      {bool forceFetch = false});
  Future addSubscription({required Subscription subscription});
  Future deleteSubscription({required String subscriptionId});
  Future updateSubscription({required Subscription subscription});
}

class SubscriptionRepoImpl implements SubscriptionRepo {
  SubscriptionLocalDataSource get _brandLocalDataSource =>
      locator<SubscriptionLocalDataSource>();
  SubscriptionRemoteDataSource get _brandRemoteDataSource =>
      locator<SubscriptionRemoteDataSource>();

  ConnectivityService get _connectivityService =>
      locator<ConnectivityService>();

  @override
  Future<Stream<List<Subscription>>> fetchSubscriptions(
      {bool forceFetch = false}) async {
    if (await _connectivityService.checkConnectivity() && forceFetch) {
      return _brandRemoteDataSource.fetchSubscriptions();
    } else {
      return _brandLocalDataSource.fetchSubscriptions();
    }
  }

  @override
  Future addSubscription({required Subscription subscription}) async {
    await _brandLocalDataSource.addSubscription(subscription);
    _brandRemoteDataSource.addSubscription(subscription);
  }

  @override
  Future deleteSubscription({required String subscriptionId}) async {
    await _brandLocalDataSource.deleteSubscription(subscriptionId);
    _brandRemoteDataSource.deleteSubscription(subscriptionId);
  }

  @override
  Future updateSubscription({required Subscription subscription}) async {
    await _brandLocalDataSource.updateSubscription(subscription);
    _brandRemoteDataSource.updateSubscription(subscription);
  }
}
