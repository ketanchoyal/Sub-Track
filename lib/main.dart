import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sub_track/ui/view/startup/startup_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
        title: 'Flutter Demo',
        color: Color(0xff566bde),
        theme: CupertinoThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: Color(0xffecf1f4),
          // barBackgroundColor: Color(0xffe4ebf0),
          barBackgroundColor: Color(0xffecf1f4),
          primaryContrastingColor: Color(0xffecf1f4),
          primaryColor: Color(0xff566bde),
          textTheme: CupertinoTextThemeData(
            primaryColor: Color(0xff566bde),
            navLargeTitleTextStyle: TextStyle(
              fontSize: 35,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            navTitleTextStyle: TextStyle(
              fontSize: 17,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            textStyle: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        home: StartupView());
  }
}
