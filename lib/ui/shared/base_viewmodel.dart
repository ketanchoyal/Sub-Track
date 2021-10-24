import 'package:flutter/material.dart';

class BaseViewModel extends ChangeNotifier {
  bool _isBusy = false;
  bool get isBusy => _isBusy;

  final Map<int, bool> _busyStates = <int, bool>{};
  bool busy(Object? object) => _busyStates[object.hashCode] ?? false;

  // ignore: avoid_positional_boolean_parameters
  void setBusy(bool value) {
    _isBusy = value;
    notifyListeners();
  }

  // //Todo: ketan: this is not used either, what is this for?
  void setBusyForObject(Object? object, bool value) {
    _busyStates[object.hashCode] = value;
    notifyListeners();
  }
}
