import 'package:flutter/material.dart';

class BaseViewModel extends ChangeNotifier {
  bool _isBusy = false;
  bool get isBusy => _isBusy;

  final Map<int, bool> _busyStates = <int, bool>{};
  final Map<int, dynamic> _errorStates = Map<int, dynamic>();

  bool busy(Object? object) => _busyStates[object.hashCode] ?? false;

  // ignore: avoid_positional_boolean_parameters
  void setBusy(bool value) {
    _isBusy = value;
    notifyListeners();
  }

  void setBusyForObject(Object? object, bool value) {
    _busyStates[object.hashCode] = value;
    notifyListeners();
  }

  /// Sets the ViewModel to busy, runs the future and then sets it to not busy when complete.
  ///
  /// rethrows [Exception] after setting busy to false for object or class
  Future<T> runBusyFuture<T>(Future<T> busyFuture,
      {Object? busyObject, bool throwException = false}) async {
    _setBusyForModelOrObject(true, busyObject: busyObject);
    try {
      var value = await runErrorFuture<T>(busyFuture,
          key: busyObject, throwException: throwException);
      return value;
    } catch (e) {
      if (throwException) rethrow;
      return Future.value();
    } finally {
      _setBusyForModelOrObject(false, busyObject: busyObject);
    }
  }

  Future<T> runErrorFuture<T>(Future<T> future,
      {Object? key, bool throwException = false}) async {
    try {
      _setErrorForModelOrObject(null, key: key);
      return await future;
    } catch (e) {
      _setErrorForModelOrObject(e, key: key);
      onFutureError(e, key);
      if (throwException) rethrow;
      return Future.value();
    }
  }

  /// Function that is called when a future throws an error
  void onFutureError(dynamic error, Object? key) {}

  void _setBusyForModelOrObject(bool value, {Object? busyObject}) {
    if (busyObject != null) {
      setBusyForObject(busyObject, value);
    } else {
      setBusyForObject(this, value);
    }
  }

  void _setErrorForModelOrObject(dynamic value, {Object? key}) {
    if (key != null) {
      setErrorForObject(key, value);
    } else {
      setErrorForObject(this, value);
    }
  }

  /// Sets the error state for the object equal to the value passed in and notifies Listeners
  /// If you're using a primitive type the value SHOULD NOT BE CHANGED, since Hashcode uses == value
  void setErrorForObject(Object object, dynamic value) {
    _errorStates[object.hashCode] = value;
    notifyListeners();
  }
}
