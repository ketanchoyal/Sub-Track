import 'dart:async';

import 'package:cross_connectivity/cross_connectivity.dart';
import 'package:sub_track/core/services/stoppable_services.dart';

class ConnectivityService extends StoppableService {
  Connectivity? _connectivity;

  /// must call [start] function to start this stream˝
  Stream<bool> get connectivityStream => _connectivity == null
      ? Stream.value(false)
      : _connectivity!.isConnected.asBroadcastStream();

  @override
  start() {
    super.start();
    if (_connectivity == null) _connectivity = Connectivity();
  }

  @override
  stop() {
    super.stop();
    if (_connectivity != null) _connectivity = null;
  }

  /// To check the connectivity once
  Future<bool> checkConnectivity() async {
    start();
    return _connectivity!.checkConnection();
  }
}
