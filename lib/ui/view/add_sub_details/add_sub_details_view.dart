import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_custom.dart';
import 'package:stacked/stacked.dart';
import 'package:sub_track/core/enums/enums.dart';
import 'package:sub_track/core/models/brand/brand.dart';
import 'package:sub_track/ui/dumb_widgets/loading.dart';
import 'package:sub_track/ui/dumb_widgets/text_fields.dart';
import 'package:sub_track/ui/dumb_widgets/textfield_outline.dart';

import 'package:sub_track/ui/theme/app_colors.dart';
import 'package:sub_track/ui/view/add_sub_details/add_sub_details_view.formx.dart';
import 'package:sub_track/ui/view/add_sub_details/widgets/color_picker.dart';
import 'package:sub_track/ui/view/add_sub_details/widgets/detail_form_element.dart';
import './add_sub_details_viewmodel.dart';
import 'package:sub_track/ui/shared/shared.dart';

// @FormView(fields: [
//   FormTextField(name: 'name'),
//   FormTextField(name: 'cost'),
//   FormTextField(name: 'description'),
//   FormTextField(name: 'sharedWith'),
// ])
class AddSubDetailsView extends StatelessWidget with $AddSubDetailsView {
  final Brand brand;

  AddSubDetailsView({Key? key, required this.brand}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddSubDetailsViewModel>.reactive(
      viewModelBuilder: () => AddSubDetailsViewModel(),
      fireOnModelReadyOnce: true,
      onModelReady: (model) {
        initControllers(model, brand);
        listenToFormUpdated(model);
        model.setBrand(brand);
      },
      builder: (context, model, child) {
        return CupertinoPageScaffold(
          resizeToAvoidBottomInset: false,
          // navigationBar: CupertinoNavigationBar(
          //   automaticallyImplyLeading: false,
          //   transitionBetweenRoutes: true,
          //   middle: Text(
          //     brand.title,
          //     style: kNavigationStyle,
          //   ),
          //   leading: Padding(
          //     padding:
          //         const EdgeInsetsDirectional.only(start: 0, end: 0, top: 7),
          //     child: GestureDetector(
          //       onTap: () {
          //         model.pop();
          //       },
          //       child: Text.rich(
          //         TextSpan(
          //           text: String.fromCharCode(CupertinoIcons.back.codePoint),
          //           style: TextStyle(
          //             inherit: false,
          //             color: CupertinoTheme.of(context).primaryColor,
          //             fontSize: 30.0,
          //             fontFamily: CupertinoIcons.back.fontFamily,
          //             package: CupertinoIcons.back.fontPackage,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          //   trailing: GestureDetector(
          //     onTap: () => model.addSubscription(),
          //     child: Icon(
          //       CupertinoIcons.plus,
          //       size: 30,
          //     ),
          //   ),
          // ),
          child: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                if (Platform.isAndroid)
                  SliverToBoxAdapter(
                    child: AppBar(
                      backgroundColor: AppColor.STAccent,
                      title: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            brand.title,
                            style: kHeader3Style,
                          ),
                          GestureDetector(
                            onTap: () => model.addSubscription(),
                            child: Text(
                              "Save",
                              style: kBodyBoldStyle,
                            ),
                          ),
                        ],
                      ),
                      leading: GestureDetector(
                        onTap: model.pop,
                        child: Icon(
                          Icons.arrow_back,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                if (Platform.isIOS)
                  SliverToBoxAdapter(
                    child: CupertinoNavigationBar(
                      automaticallyImplyLeading: false,
                      transitionBetweenRoutes: true,
                      middle: Text(
                        brand.title,
                        style: kNavigationStyle,
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
                              text: String.fromCharCode(
                                  CupertinoIcons.back.codePoint),
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
                        onTap: () => model.addSubscription(),
                        child: Icon(
                          CupertinoIcons.plus,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
              ];
            },
            body: model.isBusy
                ? Stack(
                    children: [
                      Center(
                        child: STLoading(),
                      )
                    ],
                  )
                : KeyboardActions(
                    // tapOutsideToDismiss: true,
                    // disableScroll: true,
                    config: KeyboardActionsConfig(
                      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
                      keyboardBarColor: Colors.grey[200],
                      nextFocus: true,
                      actions: [
                        KeyboardActionsItem(
                          focusNode: nameFocusNode,
                          displayArrows: true,
                        ),
                        KeyboardActionsItem(
                          focusNode: costFocusNode,
                          displayArrows: true,
                        ),
                        KeyboardActionsItem(
                          focusNode: descriptionFocusNode,
                          displayArrows: true,
                        ),
                        KeyboardActionsItem(
                          focusNode: colorFocusNode,
                          displayDoneButton: true,
                          footerBuilder: (_) => ColorPickerKeyboard(
                            notifier: model.colorChangeNotifier,
                          ),
                        ),
                        // KeyboardActionsItem(
                        //   focusNode: sharedWithFocusNode,
                        //   displayArrows: true,
                        // ),
                      ],
                    ),
                    child: ListView(
                      // controller: model.scrollController,
                      children: [
                        CupertinoFormSection.insetGrouped(
                          margin: EdgeInsets.all(8),
                          header: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child:
                                  model.subscription.iconType == SubIconType.SVG
                                      ? SvgPicture.network(
                                          model.subscription.brand.iconUrl!,
                                          height: 90,
                                          color: model.subscription.brand.hex
                                                  .toColor() ??
                                              AppColor.STAccent,
                                          fit: BoxFit.fitHeight,
                                        )
                                      : Text(
                                          model.subscription.brand.iconName ??
                                              model.subscription.brand.title[0],
                                          style: kTitleStyle,
                                        ),
                            ),
                          ),
                          children: [
                            STTextFieldOutline(
                              enableDecoration: false,
                              child: STTextField(
                                controller: nameController,
                                focusNode: nameFocusNode,
                                textInputAction: TextInputAction.next,
                                nextFocusNode: costFocusNode,
                                type: TextFieldType.DEFAULT,
                              ),
                              title: "Name",
                            ),
                            STTextFieldOutline(
                              enableDecoration: false,
                              child: STTextField(
                                controller: costController,
                                focusNode: costFocusNode,
                                textInputAction: TextInputAction.next,
                                nextFocusNode: descriptionFocusNode,
                                type: TextFieldType.DEFAULT,
                                textInputType: TextInputType.numberWithOptions(
                                    decimal: true),
                              ),
                              title: "Cost",
                            ),
                            STTextFieldOutline(
                              enableDecoration: false,
                              child: STTextField(
                                controller: descriptionController,
                                textInputAction: TextInputAction.done,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: STTextFieldOutline(
                                        title: "Icon",
                                        child: STDetailFormElement(
                                          onTap: () {
                                            model.navigateToSelectIcon();
                                          },
                                          child: model.subscription.iconType ==
                                                  SubIconType.SVG
                                              ? SvgPicture.network(
                                                  model.subscription.brand
                                                      .iconUrl!,
                                                  height: 40,
                                                  color: model.subscription
                                                          .brand.hex
                                                          .toColor() ??
                                                      AppColor.STAccent,
                                                  fit: BoxFit.fitHeight,
                                                )
                                              : Text(
                                                  model.subscription.brand
                                                          .iconName ??
                                                      model.subscription.brand
                                                          .title[0],
                                                  style: kTitleStyle,
                                                ),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: STTextFieldOutline(
                                        title: "Color",
                                        child: KeyboardCustomInput<Color?>(
                                          focusNode: colorFocusNode,
                                          notifier: model.colorChangeNotifier,
                                          builder: (context, val, hasFocus) {
                                            // model.setColor(val);
                                            return STDetailFormElement(
                                              child: CircleAvatar(
                                                backgroundColor: val,
                                              ),
                                            );
                                          },
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
                                    model.subscription.category ?? "None",
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
                                    _showDatePicker(context, model);
                                  },
                                  child: Text(
                                    model.subscription.startedOn
                                        .toString()
                                        .split(" ")[0],
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
                                    model.subscription.renewsEveryValue,
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
                                    model.subscription.notificationOnValue,
                                    style: kBodyBoldStyle.copyWith(
                                      color: AppColor.STDark,
                                    ),
                                  ),
                                ),
                              ),
                              STTextFieldOutline(
                                title: "Shared With",
                                child: STTextField(
                                  controller: sharedWithController,
                                  textInputType:
                                      TextInputType.numberWithOptions(
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
          ),
        );
      },
    );
  }

  void _showDatePicker(ctx, model) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    showCupertinoModalPopup(
      context: ctx,
      builder: (context) => Container(
        color: AppColor.STLight,
        height: 400,
        child: Column(
          children: [
            Container(
              height: 300,
              child: CupertinoDatePicker(
                initialDateTime: DateTime.now(),
                onDateTimeChanged: model.setDate,
                mode: CupertinoDatePickerMode.date,
              ),
            ),
            // Close the modal
            CupertinoButton(
              child: Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      ),
    );
  }
}
