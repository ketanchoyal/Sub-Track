import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:stacked/stacked.dart';
import 'package:sub_track/ui/dumb_widgets/loading.dart';
import 'package:sub_track/ui/shared/shared.dart';
import './startup_viewmodel.dart';

class StartUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartUpViewModel>.reactive(
      viewModelBuilder: () => StartUpViewModel(),
      onModelReady: (model) => model.wait(),
      builder: (context, model, child) => CupertinoPageScaffold(
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
      ),
    );
  }
}
