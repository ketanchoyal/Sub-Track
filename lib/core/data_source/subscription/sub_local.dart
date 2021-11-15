import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sub_track/core/data_source/subscription/sub_abstract.dart';
import 'package:sub_track/core/models/subscription/subscription.dart';
import 'package:sub_track/core/services/file_service.dart';

final subscriptionLocalDataSourceP = Provider<SubscriptionLocalDataSource>(
  (ref) => SubscriptionLocalDataSourceImpl(ref),
  dependencies: [
    fileServiceP,
    hiveP,
  ],
  name: "subscriptionLocalDataSourceP",
);

/// Require
///
/// [FileService]
///
/// [HiveInterface]
abstract class SubscriptionLocalDataSource implements SubscriptionDataSource {
  Future<void> init();
  Future<void> cleanEverything();
  List<Subscription> getSubscriptionsOnce();
  // Future updateCache(Subscription subscriptions);
}

class SubscriptionLocalDataSourceImpl implements SubscriptionLocalDataSource {
  final ProviderRef _ref;
  SubscriptionLocalDataSourceImpl(this._ref);
  final StreamController<List<Subscription>> _streamController =
      StreamController<List<Subscription>>.broadcast();
  FileService get _fileServices => _ref.read(fileServiceP);
  HiveInterface get _hiveService => _ref.read(hiveP);

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

    await _listenToSubscription();
  }

  @override
  addSubscription(Subscription subscription) async {
    print("Adding Sub to local");

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
    // _listenToSubscription();
    return _subscriptionBox.watch().map(
      (BoxEvent event) {
        print(
            "${event.key} : ${event.value} => ${event.deleted ? "Deleted" : "Added"}");
        return getSubscriptionsOnce();
      },
    ).startWith(
      getSubscriptionsOnce(),
    )..asBroadcastStream();
    // return _streamController.stream..asBroadcastStream();
  }

  @override
  List<Subscription> getSubscriptionsOnce() {
    return _subscriptionBox.values.toList();
  }

  //Real stuff here
  _listenToSubscription() async {
    if (_subscriptionsBoxIsOpen) {
      print("listening To Subscription local");
      // _streamController.add(_subscriptionBox.values.toList());
      // await _streamController.addStream(
      //   _subscriptionBox.watch().map(
      //     (BoxEvent event) {
      //       print("${event.toString()}");
      //       return getSubscriptionsOnce();
      //     },
      //   ).startWith(
      //     getSubscriptionsOnce(),
      //   ),
      // );
      // _subscriptionBox.watch().listen((event) {
      //   _streamController.add(_subscriptionBox.values.toList());
      //   print("listening To Subscription local");
      // });
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
