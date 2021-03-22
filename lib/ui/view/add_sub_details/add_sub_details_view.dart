import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:sub_track/core/models/brands.dart';
import 'package:sub_track/ui/dumb_widgets/text_fields.dart';
import 'package:sub_track/ui/dumb_widgets/textfield_outline.dart';
import 'package:sub_track/ui/resources/resources.dart';

import 'package:sub_track/ui/theme/app_colors.dart';
import 'package:sub_track/ui/view/add_sub_details/add_sub_details_view.form.dart';
import 'package:sub_track/ui/view/add_sub_details/widgets/detail_form_element.dart';
import './add_sub_details_viewmodel.dart';
import 'package:sub_track/ui/shared/shared.dart';

@FormView(fields: [
  FormTextField(name: 'name'),
  FormTextField(name: 'cost'),
  FormTextField(name: 'description'),
  FormTextField(name: 'sharedWith'),
])
class AddSubDetailsView extends StatelessWidget with $AddSubDetailsView {
  final Brand brand;

  AddSubDetailsView({Key? key, required this.brand}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddSubDetailsViewModel>.reactive(
      viewModelBuilder: () => AddSubDetailsViewModel(),
      onModelReady: (model) {
        listenToFormUpdated(model);
      },
      builder: (context, model, child) {
        return CupertinoPageScaffold(
          resizeToAvoidBottomInset: false,
          navigationBar: CupertinoNavigationBar(
            automaticallyImplyLeading: false,
            transitionBetweenRoutes: true,
            middle: Text(
              brand.title,
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
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              print("object");
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: ListView(
              children: [
                CupertinoFormSection.insetGrouped(
                  margin: EdgeInsets.all(8),
                  header: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.network(
                        brand.iconUrl,
                        height: 90,
                        color: brand.hex.toColor() ?? AppColor.STAccent,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  children: [
                    STTextFieldOutline(
                      enableDecoration: false,
                      child: STTextField(
                        focusNode: nameFocusNode,
                        nextFocusNode: costFocusNode,
                        type: TextFieldType.DEFAULT,
                      ),
                      title: "Name",
                    ),
                    STTextFieldOutline(
                      enableDecoration: false,
                      child: STTextField(
                        focusNode: costFocusNode,
                        nextFocusNode: descriptionFocusNode,
                        type: TextFieldType.DEFAULT,
                      ),
                      title: "Cost",
                    ),
                    STTextFieldOutline(
                      enableDecoration: false,
                      child: STTextField(
                        focusNode: descriptionFocusNode,
                        type: TextFieldType.DEFAULT,
                      ),
                      title: "Description",
                    ),
                  ],
                ),
                if (model.isExpanded)
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
                          onTap: () async {
                            await CupertinoRoundedDatePicker.show(
                              context,
                              onDateTimeChanged: model.setDate,
                              background:
                                  CupertinoTheme.of(context).barBackgroundColor,
                              fontFamily: CupertinoTheme.of(context)
                                  .textTheme
                                  .textStyle
                                  .fontFamily,
                            );
                          },
                          child: Text(
                            model.date,
                            style: kBodyBoldStyle.copyWith(
                              color: AppColor.STDark,
                            ),
                          ),
                        ),
                      ),
                      STTextFieldOutline(
                        title: "Renews Every",
                        child: STDetailFormElement(
                          onTap: () => model.navigateToOtherSelectView(
                              type: OtherDetailSelectType.Renews_Every),
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
                          onTap: () => model.navigateToOtherSelectView(
                              type: OtherDetailSelectType.Notification),
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
                        child: STTextField(
                          textInputType: TextInputType.numberWithOptions(
                              signed: false, decimal: false),
                          focusNode: sharedWithFocusNode,
                          textInputAction: TextInputAction.done,
                          type: TextFieldType.DEFAULT,
                        ),
                      ),
                    ],
                  ),
                CupertinoFormSection.insetGrouped(
                  margin: EdgeInsets.all(8),
                  children: [
                    CupertinoButton(
                      onPressed: model.toggleIsExpanded,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              // vertical: 15,
                            ),
                            child: Text(
                              model.isExpanded ? "Basic" : "Advanced",
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
          ),
        ).addModalContainer(additionalTopPadding: -10);
      },
    );
  }
}
