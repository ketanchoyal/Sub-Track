import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:sub_track/ui/dumb_widgets/buttons.dart';
import 'package:sub_track/ui/dumb_widgets/text_fields.dart';
import 'package:sub_track/ui/dumb_widgets/textfield_outline.dart';
import 'package:sub_track/ui/resources/resources.dart';
import 'package:sub_track/ui/shared/enums.dart';
import 'package:sub_track/ui/theme/app_colors.dart';
import 'package:sub_track/ui/view/add_sub_details/widgets/detail_form_element.dart';
import './add_sub_details_viewmodel.dart';
import 'package:sub_track/ui/shared/shared.dart';

class AddSubDetailsView extends StatefulWidget {
  @override
  _AddSubDetailsViewState createState() => _AddSubDetailsViewState();
}

class _AddSubDetailsViewState extends State<AddSubDetailsView> {
  final double _topPadding = 20;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddSubDetailsViewModel>.reactive(
      viewModelBuilder: () => AddSubDetailsViewModel(),
      builder: (context, model, child) {
        return WillPopScope(
          onWillPop: () async {
            // await model.resetpadding();
            // TODO add dialogbox to confirm exit
            return true;
          },
          child: CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              automaticallyImplyLeading: true,
              transitionBetweenRoutes: true,
              middle: Text(
                "Apple",
                style: kNavigationStyle,
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
                      child: Image.asset(
                        "assets/subIcons/7769dafa_2055_11eb_adc1_0242ac120002.png",
                        height: 90,
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
                                  onTap: () {},
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
          ).addModalContainer(additionalTopPadding: -10),
        );
      },
    );
  }
}
