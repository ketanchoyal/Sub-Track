// This Service contains all the variables which are to be shared across UI
// for some animation or streams etc..
import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final uiServicesP = Provider<UIServices>(
  (ref) => UIServices(),
  name: "uiServicesP",
);

class UIServices {
  late ScrollController _scrollController;

  set scrollController(value) => _scrollController = value;

  ScrollController get scrollController => _scrollController;

  final AnimatorKey _animatorKey = AnimatorKey<double>();

  AnimatorKey get animatorKey => _animatorKey;

  forward() {
    _animatorKey.controller.forward();
  }

  reverse() {
    _animatorKey.controller.reverse();
  }

  animateBackToZero() {
    _animatorKey.controller.animateBack(0.0);
  }

  // static late final GlobalKey<HomeViewState> homeViewKey;
  // StreamController<double> _extraTopPadding =
  //     StreamController<double>.broadcast(sync: true);

  // // StreamController<bool> _streamController =
  // //     StreamController<bool>.broadcast(sync: true);

  // UIServices() {
  //   setExtraPadding(0);
  //   // setIsDraggable(false);
  // }

  // // Stream<bool> get isDraggable {
  // //   return _streamController.stream;
  // // }

  // Stream<double> get getExtraPadding {
  //   return _extraTopPadding.stream;
  // }

  // setExtraPadding(double value) async {
  //   _extraTopPadding.sink.add(value);
  // }

  // // setIsDraggable(bool value) async {
  // //   _streamController.sink.add(value);
  // // }

  // dispose() {
  //   _extraTopPadding.close();
  //   // _streamController.close();
  // }
}
