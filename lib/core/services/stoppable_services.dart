import 'package:flutter/foundation.dart';

abstract class StoppableService {
  bool _serviceStoped = false;
  bool get serviceStopped => _serviceStoped;
  @mustCallSuper
  void stop() {
    _serviceStoped = true;
  }

  @mustCallSuper
  void start() {
    _serviceStoped = false;
  }
}
