// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../ui/view/demo/demo_view.dart';
import '../ui/view/startup/startup_view.dart';

class Routes {
  static const String demoView = '/';
  static const String startUpView = '/start-up-view';
  static const all = <String>{
    demoView,
    startUpView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.demoView, page: DemoView),
    RouteDef(Routes.startUpView, page: StartUpView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    DemoView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => DemoView(),
        settings: data,
      );
    },
    StartUpView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => StartUpView(),
        settings: data,
      );
    },
  };
}
