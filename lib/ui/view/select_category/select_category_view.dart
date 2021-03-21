import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/ui/theme/app_colors.dart';
import './select_category_viewmodel.dart';

class SelectCategoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SelectCategoryViewModel>.reactive(
      viewModelBuilder: () => SelectCategoryViewModel(),
      builder: (context, model, child) => CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          border: Border(bottom: BorderSide.none),
          backgroundColor: AppColor.STPureWhite,
          automaticallyImplyLeading: false,
          transitionBetweenRoutes: true,
          middle: Text("Category"),
          trailing: GestureDetector(
            onTap: () {},
            child: Icon(
              CupertinoIcons.plus,
              size: 30,
            ),
          ),
          leading: Padding(
            padding: const EdgeInsetsDirectional.only(start: 0, end: 0, top: 7),
            child: GestureDetector(
              onTap: model.pop,
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
        ),
        child: Stack(
          children: [
            CupertinoFormSection.insetGrouped(
              margin: EdgeInsets.all(8),
              children: [
                CupertinoFormRow(
                  padding: EdgeInsets.zero,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.redAccent,
                        child: Center(
                          child: Icon(
                            CupertinoIcons.news_solid,
                            color: AppColor.STPureWhite,
                          ),
                        ),
                      ),
                      horizontalSpaceSmall,
                      Text(
                        "Gaming",
                        style: kBodyBoldStyle,
                      ),
                    ],
                  ),
                ).paddingH(10).paddingV(8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
