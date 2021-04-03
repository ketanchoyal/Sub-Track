import 'package:hive/hive.dart';
import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/core/data_source/subscription/sub_abstract.dart';
import 'package:sub_track/core/models/subscription/subscription.dart';
import 'package:sub_track/core/services/file_service.dart';

abstract class SubscriptionLocalDataSource implements SubscriptionDataSource {
  Future init();
  // Future updateCache(Subscription subscriptions);
}

class SubscriptionLocalDataSourceImpl with SubscriptionLocalDataSource {
  List<Subscription>? _subscriptions;
  final _fileServices = locator<FileService>();
  final _hiveService = locator<HiveInterface>();
  final _subscriptionsBoxName = "subscriptions";
  bool get _subscriptionsBoxIsOpen =>
      _hiveService.isBoxOpen(_subscriptionsBoxName);
  Box<Subscription> get _subscriptionBox =>
      _hiveService.box<Subscription>(_subscriptionsBoxName);

  @override
  List<Subscription>? get subscriptions => _subscriptions;

  @override
  Future init() async {
    final path = await _fileServices.getApplicationDocumentsDirectoryPath();
    _hiveService.init(path);
    _hiveService.registerAdapter<Subscription>(SubscriptionAdapter());

    if (_subscriptionsBoxIsOpen)
      await _hiveService.openBox<Subscription>(_subscriptionsBoxName);
  }

  @override
  addSubscription(Subscription subscription) async {
    if (_subscriptionsBoxIsOpen) {
      _subscriptionBox.containsKey(subscription.subscriptionId)
          ? await _subscriptionBox.put(
              subscription.subscriptionId, subscription)
          : {};
    }
  }

  @override
  fetchSubscriptions() async {
    if (_subscriptionsBoxIsOpen) {
      List<Subscription> subscriptions = _subscriptionBox.values.toList();
      if (subscriptions.isNotEmpty) {
        _subscriptions = subscriptions;
        return;
      }
    }
    return;
  }

  // @override
  // updateCache(Subscription subscriptions) {
  //   // TODO: implement updateCache
  //   throw UnimplementedError();
  // }

  @override
  updateSubscription(Subscription updatedSubscription) async {
    if (_subscriptionsBoxIsOpen) {
      // updatedSubscription.save();
      await _subscriptionBox.put(
          updatedSubscription.subscriptionId, updatedSubscription);
    }
  }

  @override
  deleteSubscription(Subscription subscription) async {
    if (_subscriptionsBoxIsOpen) {
      await _subscriptionBox.delete(subscription.subscriptionId);
    }
  }
}
