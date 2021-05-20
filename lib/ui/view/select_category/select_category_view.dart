import 'package:universal_platform/universal_platform.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/ui/theme/app_colors.dart';
import 'package:sub_track/ui/view/select_category/widgets/category_view_element.dart';
import './select_category_viewmodel.dart';

class SelectCategoryView extends StatelessWidget {
  const SelectCategoryView({Key? key, this.selected}) : super(key: key);
  final String? selected;

  Widget appbar(model, context) {
    return UniversalPlatform.isIOS
        ? CupertinoNavigationBar(
            // border: Border(bottom: BorderSide.none),
            automaticallyImplyLeading: false,
            backgroundColor: AppColor.STPureWhite,
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
              padding:
                  const EdgeInsetsDirectional.only(start: 0, end: 0, top: 7),
              child: GestureDetector(
                onTap: () {
                  model.pop(category: selected);
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
            title: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Category",
                  style: kHeader3Style,
                ),
                GestureDetector(
                  onTap: () => {},
                  child: Text(
                    "Add",
                    style: kBodyBoldStyle,
                  ),
                ),
              ],
            ),
            leading: GestureDetector(
              onTap: () => model.pop(category: selected),
              child: Icon(
                Icons.arrow_back,
                size: 25,
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SelectCategoryViewModel>.reactive(
      viewModelBuilder: () => SelectCategoryViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppColor.STLight,
        appBar: appbar(model, context) as PreferredSizeWidget,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: CupertinoFormSection.insetGrouped(
                margin: EdgeInsets.all(8),
                children: model.categories
                    .map(
                      (e) => SingleCategoryViewElement(
                        category: e,
                        selected: selected,
                        onTap: () {
                          model.pop(category: e.name);
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
