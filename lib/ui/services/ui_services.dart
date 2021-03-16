// This Service contains all the variables which are to be shared across UI
// for some animation or streams etc..
import 'dart:async';

class UIServices {
  StreamController<double> _extraTopPadding =
      StreamController<double>.broadcast(sync: true);

  UIServices() {
    setExtraPadding(0);
  }

  Stream<double> get getExtraPadding {
    return _extraTopPadding.stream;
  }

  setExtraPadding(double value) async {
    _extraTopPadding.sink.add(value);
  }

  dispose() {
    _extraTopPadding.close();
  }
}
