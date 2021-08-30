import 'dart:async';

import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/app/app.logger.dart';
import 'package:sub_track/core/data_source/subscription/sub_local.dart';
import 'package:sub_track/core/data_source/subscription/sub_remote.dart';
import 'package:sub_track/core/models/subscription/subscription.dart';
import 'package:sub_track/core/services/connectivity_service.dart';
import 'package:sub_track/core/services/stoppable_services.dart';

/// Require
/// [SubscriptionLocalDataSource],
///
/// [SubscriptionRemoteDataSource] and
///
/// [ConnectivityService]
abstract class SubscriptionRepo {
  Stream<List<Subscription>> fetchSubscriptions({bool forceFetch = false});
  Future<void> addSubscription({required Subscription subscription});
  Future<void> deleteSubscription({required String subscriptionId});
  Future<void> updateSubscription({required Subscription subscription});
  List<Subscription> getSubscriptionsOnce();
  Future<void> cacheSubscriptions();
}

class SubscriptionRepoImpl implements SubscriptionRepo {
  SubscriptionLocalDataSource get _subscriptionLocalDataSource =>
      locator<SubscriptionLocalDataSource>();
  SubscriptionRemoteDataSource get _subscriptionRemoteDataSource =>
      locator<SubscriptionRemoteDataSource>();

  StreamController<List<Subscription>> _subscriptionsStreamController =
      StreamController.broadcast();

  var log = getLogger("");

  ConnectivityService get _connectivityService =>
      locator<StoppableService>() as ConnectivityService;

  @override
  Stream<List<Subscription>> fetchSubscriptions({bool forceFetch = false}) {
    // if (await _connectivityService.checkConnectivity() && forceFetch) {
    if (forceFetch) {
      log.i("Fetching subs from Remote Data Source");

      // (await _subscriptionsStreamController
      //         .addStream(_subscriptionRemoteDataSource.fetchSubscriptions()))
      //     .asStream();
      // return _subscriptionsStreamController.stream;
      return _subscriptionRemoteDataSource.fetchSubscriptions();
    } else {
      log.i("Fetching subs from Local Data Source");
      // (await _subscriptionsStreamController
      //         .addStream(_subscriptionLocalDataSource.fetchSubscriptions()))
      //     .asStream();
      // return _subscriptionsStreamController.stream;
      return _subscriptionLocalDataSource.fetchSubscriptions();
    }
  }

  @override
  Future<void> cacheSubscriptions() async {
    log.d("Caching Subscriptions started");
    List<Subscription> subs =
        await _subscriptionRemoteDataSource.fetchSubscriptions().first;
    await Future.forEach<Subscription>(subs, (element) async {
      await _subscriptionLocalDataSource.addSubscription(element);
    });
    log.d("Caching Subscriptions finished");
  }

  @override
  List<Subscription> getSubscriptionsOnce() {
    return _subscriptionLocalDataSource.getSubscriptionsOnce();
  }

  @override
  Future addSubscription({required Subscription subscription}) async {
    await _subscriptionLocalDataSource.addSubscription(subscription);
    _subscriptionRemoteDataSource.addSubscription(subscription);
  }

  @override
  Future deleteSubscription({required String subscriptionId}) async {
    await _subscriptionLocalDataSource.deleteSubscription(subscriptionId);
    _subscriptionRemoteDataSource.deleteSubscription(subscriptionId);
  }

  @override
  Future updateSubscription({required Subscription subscription}) async {
    await _subscriptionLocalDataSource.updateSubscription(subscription);
    _subscriptionRemoteDataSource.updateSubscription(subscription);
  }
}
