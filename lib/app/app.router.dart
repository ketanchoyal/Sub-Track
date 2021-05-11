// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:sub_track/ui/view/active_subscription/active_subscription_view.dart';
import 'package:sub_track/ui/view/new_subscription/new_subscription_view.dart';

import '../core/models/brand/brand.dart';
import '../ui/shared/shared.dart';
import '../ui/view/active_subscription/active_subscription_view.dart';
import '../ui/view/add_sub/add_sub_view.dart';
import '../ui/view/add_sub_details/add_sub_details_view.dart';
import '../ui/view/demo/demo_view.dart';
import '../ui/view/home/home_view.dart';
import '../ui/view/login/login_view.dart';
import '../ui/view/new_subscription/new_subscription_view.dart';
import '../ui/view/on_boarding/on_boarding_view.dart';
import '../ui/view/other_select/other_select_view.dart';
import '../ui/view/register/register_view.dart';
import '../ui/view/select_category/select_category_view.dart';
import '../ui/view/select_icon/select_icon_view.dart';
import '../ui/view/setting/setting_view.dart';
import '../ui/view/startup/startup_view.dart';

part 'app.routerx.dart';

class Routes {
  static const String demoView = '/demo-view';
  static const String onBoardingView = '/onBoarding';
  static const String newSubscription = '/new-subscription';
  static const String startUpView = '/';
  static const String loginView = '/login-view';
  static const String registerView = '/register-view';
  static const String homeView = '/home-view';
  static const String activeSubscriptionView = '/active-subscription-view';
  static const String settingView = '/setting-view';
  static const all = <String>{
    demoView,
    onBoardingView,
    newSubscription,
    startUpView,
    loginView,
    registerView,
    homeView,
    activeSubscriptionView,
    settingView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.demoView, page: DemoView),
    RouteDef(
      Routes.onBoardingView,
      page: OnBoardingView,
      generator: OnBoardingViewRouter(),
    ),
    RouteDef(
      Routes.newSubscription,
      page: NewSubscription,
      generator: NewSubscriptionRouter(),
    ),
    RouteDef(Routes.startUpView, page: StartUpView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.registerView, page: RegisterView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.activeSubscriptionView, page: ActiveSubscriptionView),
    RouteDef(Routes.settingView, page: SettingView),
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
    OnBoardingView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => OnBoardingView(),
        settings: data,
      );
    },
    NewSubscription: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => NewSubscription(),
        settings: data,
      );
    },
    StartUpView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => StartUpView(),
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
    ActiveSubscriptionView: (data) {
      var args = data.getArgs<ActiveSubscriptionViewArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => ActiveSubscriptionView(
          key: args.key,
          selectedSubId: args.selectedSubId,
        ),
        settings: data,
        fullscreenDialog: true,
        maintainState: true,
      );
    },
    SettingView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => SettingView(),
        settings: data,
        maintainState: true,
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

class NewSubscriptionRoutes {
  static const String addSubView = '/';
  static const String addSubDetailsView = '/add-sub-details-view';
  static const String selectIconView = '/select-icon-view';
  static const String selectCategoryView = '/select-category-view';
  static const String otherSelectView = '/other-select-view';
  static const all = <String>{
    addSubView,
    addSubDetailsView,
    selectIconView,
    selectCategoryView,
    otherSelectView,
  };
}

class NewSubscriptionRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(NewSubscriptionRoutes.addSubView, page: AddSubView),
    RouteDef(NewSubscriptionRoutes.addSubDetailsView, page: AddSubDetailsView),
    RouteDef(NewSubscriptionRoutes.selectIconView, page: SelectIconView),
    RouteDef(NewSubscriptionRoutes.selectCategoryView,
        page: SelectCategoryView),
    RouteDef(NewSubscriptionRoutes.otherSelectView, page: OtherSelectView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    AddSubView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => AddSubView(),
        settings: data,
      );
    },
    AddSubDetailsView: (data) {
      var args = data.getArgs<AddSubDetailsViewArguments>(nullOk: false);
      return CupertinoPageRoute<dynamic>(
        builder: (context) => AddSubDetailsView(
          key: args.key,
          brand: args.brand,
        ),
        settings: data,
      );
    },
    SelectIconView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => SelectIconView(),
        settings: data,
      );
    },
    SelectCategoryView: (data) {
      var args = data.getArgs<SelectCategoryViewArguments>(
        orElse: () => SelectCategoryViewArguments(),
      );
      return CupertinoPageRoute<dynamic>(
        builder: (context) => SelectCategoryView(
          key: args.key,
          selected: args.selected,
        ),
        settings: data,
      );
    },
    OtherSelectView: (data) {
      var args = data.getArgs<OtherSelectViewArguments>(nullOk: false);
      return CupertinoPageRoute<dynamic>(
        builder: (context) => OtherSelectView(
          key: args.key,
          selected: args.selected,
          type: args.type,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// ActiveSubscriptionView arguments holder class
class ActiveSubscriptionViewArguments {
  final Key? key;
  final String selectedSubId;
  ActiveSubscriptionViewArguments({this.key, required this.selectedSubId});
}

/// AddSubDetailsView arguments holder class
class AddSubDetailsViewArguments {
  final Key? key;
  final Brand brand;
  AddSubDetailsViewArguments({this.key, required this.brand});
}

/// SelectCategoryView arguments holder class
class SelectCategoryViewArguments {
  final Key? key;
  final String? selected;
  SelectCategoryViewArguments({this.key, this.selected});
}

/// OtherSelectView arguments holder class
class OtherSelectViewArguments {
  final Key? key;
  final dynamic selected;
  final OtherDetailSelectType type;
  OtherSelectViewArguments(
      {this.key, required this.selected, required this.type});
}
