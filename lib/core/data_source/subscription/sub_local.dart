import 'dart:async';

import 'package:hive/hive.dart';
import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/core/data_source/subscription/sub_abstract.dart';
import 'package:sub_track/core/models/subscription/subscription.dart';
import 'package:sub_track/core/services/file_service.dart';

/// Require
///
/// [FileService]
///
/// [HiveInterface]
abstract class SubscriptionLocalDataSource implements SubscriptionDataSource {
  Future init();
  Future cleanEverything();
  // Future updateCache(Subscription subscriptions);
}

class SubscriptionLocalDataSourceImpl with SubscriptionLocalDataSource {
  final StreamController<List<Subscription>> _streamController =
      StreamController<List<Subscription>>.broadcast();
  final _fileServices = locator<FileService>();
  final _hiveService = locator<HiveInterface>();
  final _subscriptionsBoxName = "subscriptions";
  bool get _subscriptionsBoxIsOpen =>
      _hiveService.isBoxOpen(_subscriptionsBoxName);
  Box<Subscription> get _subscriptionBox =>
      _hiveService.box<Subscription>(_subscriptionsBoxName);

  // Map<String, Subscription> _map = Map();

  @override
  Future init() async {
    // final path = await _fileServices.getApplicationDocumentsDirectoryPath();
    // _hiveService.init(path);
    _hiveService.registerAdapter<Subscription>(SubscriptionAdapter());

    if (!_subscriptionsBoxIsOpen)
      await _hiveService.openBox<Subscription>(_subscriptionsBoxName);
  }

  @override
  addSubscription(Subscription subscription) async {
    print("Here");

    if (_subscriptionsBoxIsOpen) {
      print(_subscriptionBox.values.length);
      !_subscriptionBox.containsKey(subscription.subscriptionId)
          ? await _subscriptionBox.put(
              subscription.subscriptionId, subscription)
          : {};
      print(_subscriptionBox.values);
    } else {
      print("Sub box Not Open");
    }
  }

  @override
  Stream<List<Subscription>> fetchSubscriptions() {
    _listenToSubscription();
    return _streamController.stream;
  }

  //Real stuff here
  _listenToSubscription() {
    if (_subscriptionsBoxIsOpen) {
      print("listening To Subscription local");
      _streamController.add(_subscriptionBox.values.toList());
      _subscriptionBox.watch().listen((event) {
        _streamController.add(_subscriptionBox.values.toList());
        print("listening To Subscription local");
      });
    }
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
  deleteSubscription(String subscriptionId) async {
    if (_subscriptionsBoxIsOpen) {
      await _subscriptionBox.delete(subscriptionId);
    }
  }

  destroy() {
    _streamController.close();
  }

  @override
  Future cleanEverything() async {
    if (_subscriptionsBoxIsOpen) {
      var someData = await _subscriptionBox.clear();
      print("Everyting is clear Now : $someData");
    }
  }
}
