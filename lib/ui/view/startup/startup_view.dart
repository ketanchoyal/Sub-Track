import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sub_track/ui/dumb_widgets/loading.dart';
import './startup_viewmodel.dart';

class StartUpView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(startupViewModelCNP).wait();
    return CupertinoPageScaffold(
      child: Stack(
        children: [
          Center(
            child: Image.asset(
              "assets/launcher_icons/splash_screen.png",
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.center,
            // top: screenHeightPercentage(context, percentage: 0.5) + 125.0,
            // left: screenWidthPercentage(context, percentage: 0.4),
            // right: screenWidthPercentage(context, percentage: 0.4),
            child: Container(
              height: 350,
              width: 350,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: STLoading(
                      height: 55,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
