import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/ui/theme/app_colors.dart';
import 'package:sub_track/ui/view/startup/startup_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // REVIEW Using Material on top of CupertinoApp is okay or not
    return Material(
      textStyle: kMainStyle,
      child: CupertinoApp(
        title: 'Sub Track',
        color: AppColor.STAccent,
        theme: CupertinoThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: AppColor.STLight,
          barBackgroundColor: AppColor.STLight,
          primaryContrastingColor: AppColor.STLight,
          primaryColor: AppColor.STAccent,
          textTheme: CupertinoTextThemeData(
            primaryColor: AppColor.STAccent,
            navLargeTitleTextStyle: kTitleStyle,
            navTitleTextStyle: kNavigationStyle,
            textStyle: kBodyStyle,
          ),
        ),
        home: StartupView(),
      ),
    );
  }
}
