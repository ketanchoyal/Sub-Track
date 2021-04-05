import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/ui/theme/app_colors.dart';
import 'app/app.locatorx.dart';
import 'app/app.router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// FIXME Rename all abstract class (add interface to there name) and Remove Impl from there implemented classes
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays(
      [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  // await Firebase.initializeApp();
  await setupLocator();
  runApp(MyApp());
}

// TODO Replace my widget extensions with velocityX extensions
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // REVIEW Using Material on top of CupertinoApp is okay or not
    return CupertinoApp(
      title: 'Sub Track',
      color: AppColor.STAccent,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      theme: CupertinoThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColor.STLight,
        barBackgroundColor: AppColor.STLight,
        primaryContrastingColor: AppColor.STLight,
        primaryColor: AppColor.STAccent,
        textTheme: CupertinoTextThemeData(
          primaryColor: AppColor.STAccent,
          navLargeTitleTextStyle: kTitleStyle.copyWith(
            color: AppColor.STDark,
            letterSpacing: 1,
          ),
          navTitleTextStyle: kNavigationStyle.copyWith(
            color: AppColor.STDark,
          ),
          textStyle: kBodyStyle.copyWith(
            color: AppColor.STDark,
          ),
        ),
      ),
      // home: AddSubDetailsView(),
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouterX().onGenerateRoute,
    );
  }
}
