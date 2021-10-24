// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

// import 'dart:io';

import 'dart:io';

import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/ui/view/active_subscription/active_subscription_view.dart';
import 'package:sub_track/ui/view/new_subscription/new_subscription_view.dart';

import '../core/models/brand/brand.dart';
import '../ui/shared/shared.dart';
import '../ui/view/active_subscription/active_subscription_view.dart';
import '../ui/view/add_sub/add_sub_view.dart';
import '../ui/view/add_sub_details/add_sub_details_view.dart';
import '../ui/view/demo/demo_view.dart';
import '../ui/view/forgot_password/forgot_password_view.dart';
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

final navigationServiceP = Provider<NavigationService>(
  (ref) => NavigationService(),
  name: 'navigationServiceP',
);

class Routes {
  static const String demoView = '/demo-view';
  static const String onBoardingView = '/onBoarding';
  static const String newSubscription = '/new-subscription';
  static const String startUpView = '/';
  static const String loginView = '/login-view';
  static const String registerView = '/register-view';
  static const String homeView = '/home-view';
  static const String forgotPasswordView = '/forgot-password-view';
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
    forgotPasswordView,
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
    RouteDef(Routes.forgotPasswordView, page: ForgotPasswordView),
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
    ForgotPasswordView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ForgotPasswordView(),
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

typedef StackedRouteFactory = Route<dynamic> Function(RouteData data);
typedef RouterBuilder<T extends RouterBase> = T Function();

abstract class RouterBase {
  List<RouteDef> get routes;

  Map<Type, StackedRouteFactory> get pagesMap;

  Set<String> get allRoutes => routes.map((e) => e.template).toSet();

  Route<dynamic>? onGenerateRoute(RouteSettings settings, [String? basePath]) {
    assert(routes != null);
    assert(settings != null);
    var match = findMatch(settings);
    if (match != null) {
      if (basePath != null) {
        match = match.copyWith(name: _joinPath(basePath, match.name))
            as RouteMatch?;
      }

      RouteData data;
      if (match!.isParent) {
        data = ParentRouteData(
          matchResult: match,
          initialRoute: match.rest,
          router: match.routeDef.generator,
        );
      } else {
        data = RouteData(match);
      }
      return pagesMap[match.routeDef.page!]!(data);
    }
    return null;
  }

  String _joinPath(String basePath, String? part) {
    var name;
    var pathOnly = Uri.parse(basePath).path;
    if (part == "" || pathOnly.endsWith("/") || part!.startsWith("/")) {
      name = "$pathOnly$part";
    } else {
      name = "$pathOnly/$part";
    }
    return name;
  }

  // a shorthand for calling the onGenerateRoute function
  // when using Router directly in MaterialApp or such
  // Router().onGenerateRoute becomes Router()
  Route<dynamic>? call(RouteSettings settings) => onGenerateRoute(settings);

  RouteMatch? findMatch(RouteSettings settings) {
    var matcher = RouteMatcher(settings);
    for (var route in routes) {
      var match = matcher.match(route);
      if (match != null) {
        // matching root "/" must be exact
        if ((route.template == "/" || route.template.isEmpty) &&
            match.hasRest) {
          continue;
        }
        return match;
      }
    }
    return null;
  }

  bool hasMatch(String path) {
    return findMatch(RouteSettings(name: path)) != null;
  }

  List<RouteMatch> allMatches(RouteMatcher matcher) {
    var matches = <RouteMatch>[];
    for (var route in routes) {
      var matchResult = matcher.match(route);
      if (matchResult != null) {
        matches.add(matchResult);
        if (matchResult.isParent || !matchResult.hasRest) {
          break;
        }
      }
    }
    return matches;
  }
}

class RouteMatcher {
  final Uri _uri;
  final RouteSettings? _settings;

  RouteMatcher(RouteSettings this._settings)
      : _uri = Uri.parse(_settings.name!);

  RouteMatcher.fromUri(this._uri) : _settings = null;

  RouteMatch? match(RouteDef route, {bool fullMatch = false}) {
    var pattern = fullMatch ? '${route.pattern}\$' : route.pattern;
    var match = RegExp(pattern as String).stringMatch(_uri.path);
    RouteMatch? matchResult;
    if (match != null) {
      // strip trailing forward slash
      if (match.endsWith("/") && match.length > 1) {
        match = match.substring(0, match.length - 1);
      }

      var segment = _uri.replace(path: match);
      var rest = _uri.replace(path: _uri.path.substring(match.length));
      // return null if the rest of the provided uri doesn't match
      // any of the nested routes
      if (!rest.hasEmptyPath) {
        if (route.isParent) {
          if (!route.generator!.hasMatch(rest.path)) {
            return null;
          }
        } else {
          return null;
        }
      }

      // passing args to the last destination
      // when pushing deep links
      var args = _settings?.arguments;
      var argsToPass;
      if (!rest.hasEmptyPath) {
        argsToPass = args;
        args = null;
      }

      matchResult = RouteMatch(
          name: !rest.hasEmptyPath || !segment.hasQueryParams || route.isParent
              ? segment.path
              : segment.toString(),
          arguments: args,
          initialArgsToPass: argsToPass,
          uri: segment,
          routeDef: route,
          rest: rest,
          pathParamsMap: _extractPathParams(route.pattern as String, match));
    }
    return matchResult;
  }

  Map<String, String?> _extractPathParams(String pathPattern, String path) {
    var pathMatch = RegExp(pathPattern).firstMatch(path);
    var params = <String, String?>{};
    if (pathMatch != null) {
      for (var name in pathMatch.groupNames) {
        params[name] = pathMatch.namedGroup(name);
      }
    }
    return params;
  }
}

@immutable
class RouteMatch extends RouteSettings {
  final Uri uri;
  final RouteDef routeDef;
  final Uri rest;
  final Map<String, String?> pathParamsMap;
  final Object? initialArgsToPass;

  RouteMatch({
    required this.uri,
    required this.routeDef,
    required this.rest,
    required this.pathParamsMap,
    this.initialArgsToPass,
    required String? name,
    required Object? arguments,
  }) : super(name: name, arguments: arguments);

  bool get hasRest => !rest.hasEmptyPath;

  bool get hasGuards => routeDef.guards?.isNotEmpty == true;

  bool get isParent => routeDef.generator != null;

  String get template => routeDef.template;

  String get path => uri.path;

  Parameters get queryParams => Parameters(uri.queryParameters);

  Parameters get pathParams => Parameters(pathParamsMap);

  @override
  RouteSettings copyWith({
    String? name,
    Object? arguments,
  }) {
    return RouteMatch(
        name: name ?? this.name,
        arguments: arguments ?? this.arguments,
        initialArgsToPass: this.initialArgsToPass,
        uri: this.uri,
        routeDef: this.routeDef,
        rest: this.rest,
        pathParamsMap: this.pathParamsMap);
  }
}

class RouteDef {
  final String template;
  final List<Type>? guards;
  final RouterBase? generator;
  final Pattern pattern;
  final Type? page;

  RouteDef(
    this.template, {
    this.page,
    this.guards,
    this.generator,
  }) : pattern = _buildPathPattern(template);

  bool get isParent => generator != null;

  static Pattern _buildPathPattern(String template) {
    var regEx = template.replaceAllMapped(RegExp(r':([^/|?]+)|([*])'), (m) {
      if (m[1] != null) {
        return '?(?<${m[1]}>[^/]+)';
      } else {
        return ".*";
      }
    });
    return '^$regEx([/])?';
  }
}

@immutable
class RouteData extends RouteSettings {
  RouteData(this.routeMatch)
      : _pathParams = routeMatch.pathParams,
        _queryParams = routeMatch.queryParams,
        fragment = routeMatch.uri.fragment,
        super(name: routeMatch.name, arguments: routeMatch.arguments);

  final RouteMatch routeMatch;
  final Parameters _pathParams;
  final Parameters _queryParams;
  final String fragment;

  String get template => routeMatch.template;

  Parameters get queryParams => _queryParams;

  Parameters get pathParams => _pathParams;

  String get path => routeMatch.uri.path;

  Object? get _initialArgsToPass => routeMatch.initialArgsToPass;

  T getArgs<T>({bool nullOk = true, T Function()? orElse}) {
    if (nullOk == true) {
      assert(orElse != null);
    }
    if (_hasInvalidArgs<T>(nullOk)) {
      throw FlutterError(
          'Expected [${T.toString()}],  found [${arguments?.runtimeType}]');
    }
    return arguments as T? ?? orElse!();
  }

  bool _hasInvalidArgs<T>(bool nullOk) {
    if (!nullOk) {
      return (arguments is! T);
    } else {
      return (arguments != null && arguments is! T);
    }
  }

  @override
  String toString() {
    return 'RouteData{template: ${routeMatch.template}, '
        'path: ${routeMatch.path}, fullName: ${routeMatch.name}, args: $arguments,  params: $_pathParams, query: $_queryParams}';
  }

  static RouteData? of(BuildContext context) {
    var modal = ModalRoute.of(context);
    if (modal != null && modal.settings is RouteData) {
      return modal.settings as RouteData;
    } else {
      return null;
    }
  }

  static RoutePredicate withPath(String path) {
    return (Route<dynamic> route) {
      return !route.willHandlePopInternally &&
          route is ModalRoute &&
          route.settings is RouteData &&
          (route.settings as RouteData).template == path;
    };
  }
}

@immutable
class ParentRouteData<T extends RouterBase> extends RouteData {
  final Uri? initialRoute;
  final T? router;

  ParentRouteData({
    this.initialRoute,
    this.router,
    required RouteMatch matchResult,
  }) : super(matchResult);

  Object? get initialRouteArgs => _initialArgsToPass;
  static ParentRouteData? of(BuildContext context) {
    var modal = ModalRoute.of(context);
    if (modal != null && modal.settings is ParentRouteData) {
      return modal.settings as ParentRouteData;
    } else {
      return null;
    }
  }
}

class Parameters {
  final Map<String, String?> _params;

  Parameters(Map<String, String?> params) : _params = params;

  Map<String, String?> get rawMap => _params;

  ParameterValue operator [](String key) => ParameterValue._(_params[key]);

  @override
  String toString() {
    return _params.toString();
  }
}

class ParameterValue {
  final dynamic _value;

  const ParameterValue._(this._value);

  dynamic get value => _value;

  String? optString() => _value;

  String getString([String? defaultValue]) {
    var val = _value ?? defaultValue;
    if (val == null) {
      throw FlutterError('Failed to parse [String] value from $_value');
    }
    return val;
  }

  int? optInt([int? defaultValue]) {
    if (_value == null) {
      return defaultValue;
    } else if (_value is int) {
      return _value;
    } else {
      return int.tryParse(_value.toString()) ?? defaultValue;
    }
  }

  int getInt([int? defaultValue]) {
    var val = optInt(defaultValue);
    if (val == null) {
      throw FlutterError('Failed to parse [int] value from $_value');
    }
    return val;
  }

  double? optDouble([double? defaultValue]) {
    if (_value == null) {
      return defaultValue;
    } else if (_value is double) {
      return _value;
    } else {
      return double.tryParse(_value.toString()) ?? defaultValue;
    }
  }

  double getDouble([double? defaultValue]) {
    var val = optDouble(defaultValue);
    if (val == null) {
      throw FlutterError('Failed to parse [double] value from $_value');
    }
    return val;
  }

  num? optNum([num? defaultValue]) {
    if (_value == null) {
      return defaultValue;
    } else if (_value is num) {
      return _value;
    } else {
      return double.tryParse(_value.toString()) ?? defaultValue;
    }
  }

  num getNum([num? defaultValue]) {
    var val = optNum(defaultValue);
    if (val == null) {
      throw FlutterError('Failed to parse [num] value from $_value');
    }
    return val;
  }

  bool? optBool([bool? defaultValue]) {
    switch (_value?.toLowerCase()) {
      case 'true':
        return true;
      case 'false':
        return false;
      default:
        return defaultValue;
    }
  }

  bool getBool([bool? defaultValue]) {
    var val = optBool(defaultValue);
    if (val == null) {
      throw FlutterError('Failed to parse [bool] value from $_value');
    }
    return val;
  }
}

extension UriX on Uri {
  String get normalizedPath =>
      hasQueryParams || hasFragment ? toString() : path;

  bool get hasQueryParams => queryParameters.isNotEmpty == true;
}

PageRoute<T> buildAdaptivePageRoute<T>({
  required WidgetBuilder builder,
  RouteSettings? settings,
  bool maintainState = true,
  bool fullscreenDialog = false,
  String? cupertinoTitle,
}) {
  // no transitions for web
  if (kIsWeb) {
    return PageRouteBuilder(
      pageBuilder: (ctx, _, __) => builder(ctx),
      settings: settings,
      maintainState: maintainState,
      fullscreenDialog: fullscreenDialog,
    );
  } else if (Platform.isIOS || Platform.isMacOS) {
    return CupertinoPageRoute<T>(
      builder: builder,
      settings: settings,
      maintainState: maintainState,
      fullscreenDialog: fullscreenDialog,
      title: cupertinoTitle,
    );
  } else {
    return MaterialPageRoute<T>(
      builder: builder,
      settings: settings,
      maintainState: maintainState,
      fullscreenDialog: fullscreenDialog,
    );
  }
}
