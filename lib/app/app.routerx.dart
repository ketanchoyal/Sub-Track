import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:stacked/stacked.dart';
import 'package:sub_track/ui/view/add_sub/add_sub_view.dart';
import 'package:sub_track/ui/view/demo/demo_view.dart';
import 'package:sub_track/ui/view/home/home_view.dart';

// NOTE This file contains custom page map which are to be replaced in _pagesMap variable in app.router.dart file
// This cutom map will enable modal_bottom_sheet (cupertino style)

final customPagesMap = <Type, StackedRouteFactory>{
  DemoView: (data) {
    return CupertinoModalBottomSheetRoute<dynamic>(
      builder: (context) => DemoView(),
      expanded: false,
      containerBuilder: (context, _, child) => CupertinoBottomSheetContainer(
        child: child,
        topRadius: _kDefaultTopRadius,
        shadow: _kDefaultBoxShadow,
      ),
      topRadius: _kDefaultTopRadius,
      settings: data,
      bounce: true,
      enableDrag: true,
    );
  },
  AddSubView: (data) {
    return CupertinoModalBottomSheetRoute<dynamic>(
      builder: (context) => AddSubView(),
      expanded: false,
      containerBuilder: (context, _, child) => CupertinoBottomSheetContainer(
        child: child,
        topRadius: _kDefaultTopRadius,
        shadow: _kDefaultBoxShadow,
      ),
      topRadius: _kDefaultTopRadius,
      isDismissible: false,
      animationCurve: Curves.easeInExpo,
      settings: data,
      bounce: true,
      enableDrag: true,
    );
  },
  HomeView: (data) {
    return MaterialWithModalsPageRoute<dynamic>(
      builder: (context) => HomeView(),
      fullscreenDialog: true,
      maintainState: true,
      settings: data,
    );
  },
};

const double _kPreviousPageVisibleOffset = 10;

const Radius _kDefaultTopRadius = Radius.circular(12);
const BoxShadow _kDefaultBoxShadow =
    BoxShadow(blurRadius: 10, color: Colors.black12, spreadRadius: 5);

/// Cupertino Bottom Sheet Container
///
/// Clip the child widget to rectangle with top rounded corners and adds
/// top padding(+safe area padding). This padding [_kPreviousPageVisibleOffset]
/// is the height that will be displayed from previous route.
class CupertinoBottomSheetContainer extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final Radius topRadius;
  final BoxShadow? shadow;

  const CupertinoBottomSheetContainer({
    Key? key,
    required this.child,
    this.backgroundColor,
    required this.topRadius,
    this.shadow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final topSafeAreaPadding = MediaQuery.of(context).padding.top;
    final topPadding = _kPreviousPageVisibleOffset + topSafeAreaPadding;

    final _shadow = shadow ?? _kDefaultBoxShadow;
    BoxShadow(blurRadius: 10, color: Colors.black12, spreadRadius: 5);
    final _backgroundColor =
        backgroundColor ?? CupertinoTheme.of(context).scaffoldBackgroundColor;
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: topRadius),
        child: Container(
          decoration:
              BoxDecoration(color: _backgroundColor, boxShadow: [_shadow]),
          width: double.infinity,
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true, //Remove top Safe Area
            child: child,
          ),
        ),
      ),
    );
  }
}
