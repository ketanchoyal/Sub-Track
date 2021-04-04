import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/core/data_source/subscription/sub_local.dart';
import 'package:sub_track/core/data_source/subscription/sub_remote.dart';
import 'package:sub_track/core/models/subscription/subscription.dart';
import 'package:sub_track/core/services/connectivity_service.dart';

abstract class SubscriptionRepo {
  Stream<List<Subscription>> fetchSubscriptions({bool forceFetch = false});
  Future addSubscription({required Subscription subsription});
  Future deleteSubscription({required String subscriptionId});
  Future updateSubscription({required Subscription subsription});
}

class SubscriptionRepoImpl implements SubscriptionRepo {
  SubscriptionLocalDataSource get _brandLocalDataSource =>
      locator<SubscriptionLocalDataSource>();
  SubscriptionRemoteDataSource get _brandRemoteDataSource =>
      locator<SubscriptionRemoteDataSource>();

  ConnectivityService get _connectivityService =>
      locator<ConnectivityService>();

  List<Subscription>? _subscriptions;
  @override
  List<Subscription>? get subscriptions => _subscriptions;

  @override
  Future addSubscription({required Subscription subsription}) async {
    // _brandRemoteDataSource.
  }

  @override
  Future deleteSubscription({required String subscriptionId}) {
    // TODO: implement deleteSubscription
    throw UnimplementedError();
  }

  @override
  Future updateSubscription({required Subscription subsription}) {
    // TODO: implement updateSubscription
    throw UnimplementedError();
  }

  @override
  Stream<List<Subscription>> fetchSubscriptions({bool forceFetch = false}) {
    // TODO: implement fetchSubscriptions
    throw UnimplementedError();
  }
}
