import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:sub_track/ui/dumb_widgets/segment_controller.dart';
import './select_icon_viewmodel.dart';
import 'package:sub_track/ui/shared/shared.dart';

class SelectIconView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SelectIconViewModel>.reactive(
      viewModelBuilder: () => SelectIconViewModel(),
      builder: (context, model, child) => CupertinoPageScaffold(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              CupertinoSliverNavigationBar(
                automaticallyImplyLeading: false,
                transitionBetweenRoutes: true,
                largeTitle: STSegmentController<IconType>(
                  onValueChanged: (onValueChanged) {},
                  children: IconType.values
                      .map((e) => {e: e.convertToString})
                      .fold<Map<IconType, String>>(
                          {},
                          (previousValue, element) =>
                              {...previousValue, ...element}),
                  selectedValue: IconType.values.first,
                ),
                middle: Text(
                  "Select Icon",
                  style: kNavigationStyle,
                ),
                trailing: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    CupertinoIcons.plus,
                    size: 30,
                  ),
                ),
                leading: Padding(
                  padding: const EdgeInsetsDirectional.only(
                      start: 0, end: 0, top: 7),
                  child: GestureDetector(
                    onTap: () {
                      model.pop();
                    },
                    child: Text.rich(
                      TextSpan(
                        text:
                            String.fromCharCode(CupertinoIcons.back.codePoint),
                        style: TextStyle(
                          inherit: false,
                          color: CupertinoTheme.of(context).primaryColor,
                          fontSize: 30.0,
                          fontFamily: CupertinoIcons.back.fontFamily,
                          package: CupertinoIcons.back.fontPackage,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Stack(
            children: [
              // STSegmentController(
              //   onValueChanged: (onValueChanged) {},
              //   children: {
              //     "Services": "Services",
              //     "Emoji": "Emoji",
              //   },
              //   selectedValue: "Services",
              // ),
            ],
          ),
        ),
      ).addModalContainer(additionalTopPadding: -10),
    );
  }
}
