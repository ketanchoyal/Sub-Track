import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:sub_track/ui/models/category.dart';
import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/ui/theme/app_colors.dart';
import 'package:sub_track/ui/view/select_category/widgets/category_view.dart';
import './select_category_viewmodel.dart';

class SelectCategoryView extends StatelessWidget {
  const SelectCategoryView({Key? key, this.selected}) : super(key: key);
  final String? selected;

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
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: CupertinoFormSection.insetGrouped(
                margin: EdgeInsets.all(8),
                children: Category.categories
                    .map(
                      (e) => SingleCategoryView(
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
