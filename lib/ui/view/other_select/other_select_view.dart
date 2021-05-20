import 'package:universal_platform/universal_platform.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/ui/theme/app_colors.dart';
import 'other_select_viewmodel.dart';
import 'widgets/other_option_element.dart';

class OtherSelectView extends StatelessWidget {
  const OtherSelectView({Key? key, required this.selected, required this.type})
      : super(key: key);
  final dynamic selected;
  final OtherDetailSelectType type;

  Widget appbar(model, context) {
    return UniversalPlatform.isIOS
        ? CupertinoNavigationBar(
            // border: Border(bottom: BorderSide.none),
            backgroundColor: AppColor.STPureWhite,
            automaticallyImplyLeading: false,
            transitionBetweenRoutes: true,
            middle: Text(type.name),
            leading: Padding(
              padding:
                  const EdgeInsetsDirectional.only(start: 0, end: 0, top: 7),
              child: GestureDetector(
                onTap: () {
                  model.pop(selected: selected);
                },
                child: Text.rich(
                  TextSpan(
                    text: String.fromCharCode(CupertinoIcons.back.codePoint),
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
          )
        : AppBar(
            backgroundColor: AppColor.STAccent,
            title: Text(
              type.name,
              style: kHeader3Style,
            ),
            leading: GestureDetector(
              onTap: () => model.pop(selected: selected),
              child: Icon(
                Icons.arrow_back,
                size: 25,
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OtherSelectViewModel>.reactive(
      viewModelBuilder: () => OtherSelectViewModel(),
      onModelReady: (model) => model.setupType(type, selected: selected),
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppColor.STLight,
        appBar: appbar(model, context) as PreferredSizeWidget,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: CupertinoFormSection.insetGrouped(
                margin: EdgeInsets.all(8),
                children: model
                    .getOptions()
                    .map((e) => OtherOptionViewElement(
                          selected: model.selected,
                          onTap: () {
                            model.pop(selected: e[1]);
                          },
                          option: e[0],
                        ))
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
