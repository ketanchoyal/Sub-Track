// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../ui/view/demo/demo_view.dart';
import '../ui/view/home/home_view.dart';
import '../ui/view/login/login_view.dart';
import '../ui/view/on_boarding/on_boarding_view.dart';
import '../ui/view/register/register_view.dart';
import '../ui/view/startup/startup_view.dart';

class Routes {
  static const String demoView = '/demo-view';
  static const String startUpView = '/';
  static const String onBoardingView = '/onBoarding';
  static const String loginView = '/login-view';
  static const String registerView = '/register-view';
  static const String homeView = '/home-view';
  static const all = <String>{
    demoView,
    startUpView,
    onBoardingView,
    loginView,
    registerView,
    homeView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.demoView, page: DemoView),
    RouteDef(Routes.startUpView, page: StartUpView),
    RouteDef(
      Routes.onBoardingView,
      page: OnBoardingView,
      generator: OnBoardingViewRouter(),
    ),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.registerView, page: RegisterView),
    RouteDef(Routes.homeView, page: HomeView),
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
    OnBoardingView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => OnBoardingView(),
        settings: data,
      );
    },
    LoginView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginView(),
        settings: data,
      );
    },
    RegisterView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => RegisterView(),
        settings: data,
      );
    },
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeView(),
        settings: data,
      );
    },
  };
}

class OnBoardingViewRoutes {
  static const String view1 = '/';
  static const String view2 = '/2';
  static const String view3 = '/3';
  static const all = <String>{
    view1,
    view2,
    view3,
  };
}

class OnBoardingViewRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(OnBoardingViewRoutes.view1, page: View1),
    RouteDef(OnBoardingViewRoutes.view2, page: View2),
    RouteDef(OnBoardingViewRoutes.view3, page: View3),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    View1: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const View1(),
        settings: data,
        fullscreenDialog: true,
      );
    },
    View2: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const View2(),
        settings: data,
        fullscreenDialog: true,
      );
    },
    View3: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const View3(),
        settings: data,
        fullscreenDialog: false,
      );
    },
  };
}
