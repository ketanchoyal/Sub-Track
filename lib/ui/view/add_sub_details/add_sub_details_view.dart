import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:sub_track/core/models/brands.dart';
import 'package:sub_track/ui/dumb_widgets/buttons.dart';
import 'package:sub_track/ui/dumb_widgets/text_fields.dart';
import 'package:sub_track/ui/dumb_widgets/textfield_outline.dart';
import 'package:sub_track/ui/resources/resources.dart';

import 'package:sub_track/ui/theme/app_colors.dart';
import 'package:sub_track/ui/view/add_sub_details/widgets/detail_form_element.dart';
import './add_sub_details_viewmodel.dart';
import 'package:sub_track/ui/shared/shared.dart';

class AddSubDetailsView extends StatefulWidget {
  final Brand brand;

  const AddSubDetailsView({Key? key, required this.brand}) : super(key: key);
  @override
  _AddSubDetailsViewState createState() => _AddSubDetailsViewState();
}

class _AddSubDetailsViewState extends State<AddSubDetailsView> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddSubDetailsViewModel>.reactive(
      viewModelBuilder: () => AddSubDetailsViewModel(),
      onModelReady: (model) => model.setBrand(widget.brand),
      builder: (context, model, child) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            automaticallyImplyLeading: false,
            transitionBetweenRoutes: true,
            middle: Text(
              widget.brand.title,
              style: kNavigationStyle,
            ),
            leading: Padding(
              padding:
                  const EdgeInsetsDirectional.only(start: 0, end: 0, top: 7),
              child: GestureDetector(
                onTap: () {
                  model.pop();
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
            trailing: GestureDetector(
              onTap: () {},
              child: Icon(
                CupertinoIcons.plus,
                size: 30,
              ),
            ),
          ),
          child: ListView(
            children: [
              CupertinoFormSection.insetGrouped(
                margin: EdgeInsets.all(8),
                header: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.network(
                      widget.brand.iconUrl,
                      height: 90,
                      color: widget.brand.hex.toColor() ?? AppColor.STAccent,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                children: [
                  STTextFieldOutline(
                    enableDecoration: false,
                    child: STTextField(
                      focusNode: FocusNode(),
                      type: TextFieldType.DEFAULT,
                    ),
                    title: "Name",
                  ),
                  STTextFieldOutline(
                    enableDecoration: false,
                    child: STTextField(
                      focusNode: FocusNode(),
                      type: TextFieldType.DEFAULT,
                    ),
                    title: "Cost",
                  ),
                  STTextFieldOutline(
                    enableDecoration: false,
                    child: STTextField(
                      focusNode: FocusNode(),
                      type: TextFieldType.DEFAULT,
                    ),
                    title: "Description",
                  ),
                ],
              ),
              if (isExpanded)
                CupertinoFormSection.insetGrouped(
                  margin: EdgeInsets.all(8),
                  children: [
                    CupertinoFormRow(
                      padding: EdgeInsets.zero,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: STTextFieldOutline(
                              title: "Icon",
                              child: STDetailFormElement(
                                onTap: () {
                                  model.navigateToSelectIcon();
                                },
                                child: Image.asset(
                                  AppIconsAssets.google,
                                  height: 40,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: STTextFieldOutline(
                              title: "Color",
                              child: STDetailFormElement(
                                child: CircleAvatar(
                                  backgroundColor: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    STTextFieldOutline(
                      title: "Category",
                      child: STDetailFormElement(
                        onTap: model.navigateToSelectCategory,
                        child: Text(
                          "None",
                          style: kBodyBoldStyle.copyWith(
                            color: AppColor.STDark,
                          ),
                        ),
                      ),
                    ),
                    STTextFieldOutline(
                      title: "Sub Started On",
                      child: STDetailFormElement(
                        child: Text(
                          "2019-4-07",
                          style: kBodyBoldStyle.copyWith(
                            color: AppColor.STDark,
                          ),
                        ),
                      ),
                    ),
                    STTextFieldOutline(
                      title: "Renews Every",
                      child: STDetailFormElement(
                        child: Text(
                          "Week",
                          style: kBodyBoldStyle.copyWith(
                            color: AppColor.STDark,
                          ),
                        ),
                      ),
                    ),
                    STTextFieldOutline(
                      title: "Notification",
                      child: STDetailFormElement(
                        child: Text(
                          "Same Day",
                          style: kBodyBoldStyle.copyWith(
                            color: AppColor.STDark,
                          ),
                        ),
                      ),
                    ),
                    STTextFieldOutline(
                      title: "Shared With",
                      child: STDetailFormElement(
                        child: Text(
                          "0",
                          style: kBodyBoldStyle.copyWith(
                            color: AppColor.STDark,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              CupertinoFormSection.insetGrouped(
                margin: EdgeInsets.all(8),
                children: [
                  CupertinoButton(
                    onPressed: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            // vertical: 15,
                          ),
                          child: Text(
                            isExpanded ? "Basic" : "Advanced",
                            style: kBodyLargeStyle.copyWith(
                              fontWeight: FontWeightX.bold,
                              color: AppColor.STFailure,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ).addModalContainer(additionalTopPadding: -10);
      },
    );
  }
}
