import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:stacked/stacked.dart';
import 'package:sub_track/ui/dumb_widgets/cupertino_modal_container.dart';
import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/ui/view/add_sub/add_sub_view.dart';
import 'package:sub_track/ui/view/add_sub_details/add_sub_details_view.dart';
import 'package:sub_track/ui/view/demo/demo_view.dart';
import 'package:sub_track/ui/view/home/home_view.dart';

import 'app.router.dart';

// NOTE This file contains custom page map which are to be replaced in _pagesMap variable in app.router.dart file
// This cutom map will enable modal_bottom_sheet (cupertino style)

final customPagesMap = <Type, StackedRouteFactory>{
  DemoView: (data) {
    return CupertinoModalBottomSheetRoute<dynamic>(
      builder: (context) => DemoView(),
      expanded: false,
      topRadius: kDefaultTopRadius,
      settings: data,
      bounce: true,
      enableDrag: true,
    );
  },
  AddSubView: (data) {
    return CupertinoModalBottomSheetRoute<dynamic>(
      builder: (context) => AddSubView(),
      expanded: false,
      topRadius: kDefaultTopRadius,
      isDismissible: true,
      // duration: Duration(milliseconds: 400),
      animationCurve: Curves.easeIn,
      settings: data,
      bounce: false,
      enableDrag: true,
    );
  },
  AddSubDetailsView: (data) {
    return CupertinoModalBottomSheetRoute<dynamic>(
      builder: (context) => AddSubDetailsView(),
      expanded: false,
      topRadius: kDefaultTopRadius,
      isDismissible: false,
      animationCurve: Curves.bounceIn,
      settings: data,
      bounce: false,
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
