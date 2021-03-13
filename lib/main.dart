import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/ui/theme/app_colors.dart';
import 'package:sub_track/ui/view/demo/demo_view.dart';
import 'package:sub_track/ui/view/on_boarding_1/on_boarding1_view.dart';

import 'app/app.locator.dart';
import 'app/app.router.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // REVIEW Using Material on top of CupertinoApp is okay or not
    return Material(
      // textStyle: kMainStyle,
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
        home: OnBoarding1View(),
        navigatorKey: StackedService.navigatorKey,
        onGenerateRoute: StackedRouter().onGenerateRoute,
      ),
    );
  }
}
