// import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_custom.dart';

import 'package:stacked_services/stacked_services.dart';
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
class AddSubDetailsView extends ConsumerStatefulWidget {
  final Brand brand;

  AddSubDetailsView({Key? key, required this.brand}) : super(key: key);

  @override
  ConsumerState<AddSubDetailsView> createState() => _AddSubDetailsViewState();
}

class _AddSubDetailsViewState extends ConsumerState<AddSubDetailsView>
    with $AddSubDetailsView {
  Widget appbar(model, context) {
    return (GetPlatform.isIOS || GetPlatform.isMacOS)
        ? CupertinoNavigationBar(
            automaticallyImplyLeading: false,
            transitionBetweenRoutes: true,
            backgroundColor: AppColor.STPureWhite,
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
              onTap: () => model.addSubscription(),
              child: Icon(
                CupertinoIcons.plus,
                size: 30,
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
                  widget.brand.title,
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
          );
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      ref.read(addSubDetailViewModelCNP).setBrand(widget.brand);
    });
    initControllers();
    listenToFormUpdated();
  }

  @override
  void dispose() {
    super.dispose();
    disposeForm();
  }

  AddSubDetailsViewModel get model => ref.read(addSubDetailViewModelCNP);
  @override
  Widget build(BuildContext context) {
    final isBusy =
        ref.watch(addSubDetailViewModelCNP.select((value) => value.isBusy));
    final isExpanded =
        ref.watch(addSubDetailViewModelCNP.select((value) => value.isExpanded));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.STLight,
      appBar: appbar(model, context) as PreferredSizeWidget,
      body: isBusy
          ? Stack(
              children: [
                const Center(
                  child: const STLoading(),
                )
              ],
            )
          : Consumer(builder: (context, ref, child) {
              final subscription = ref.watch(addSubDetailViewModelCNP
                  .select((value) => value.subscription));
              return KeyboardActions(
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
                          child: subscription.iconType == SubIconType.SVG
                              ? SvgPicture.network(
                                  subscription.brand.iconUrl!,
                                  height: 90,
                                  color: subscription.brand.hex.toColor() ??
                                      AppColor.STAccent,
                                  fit: BoxFit.fitHeight,
                                )
                              : Text(
                                  subscription.brand.iconName ??
                                      subscription.brand.title[0],
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
                            textInputType:
                                TextInputType.numberWithOptions(decimal: true),
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
                                      child: subscription.iconType ==
                                              SubIconType.SVG
                                          ? SvgPicture.network(
                                              subscription.brand.iconUrl!,
                                              height: 40,
                                              color: subscription.brand.hex
                                                      .toColor() ??
                                                  AppColor.STAccent,
                                              fit: BoxFit.fitHeight,
                                            )
                                          : Text(
                                              subscription.brand.iconName ??
                                                  subscription.brand.title[0],
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
                                subscription.category ?? "None",
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
                                (GetPlatform.isIOS || GetPlatform.isMacOS)
                                    ? _showDatePicker(context, model)
                                    : await model.setDate(await showDatePicker(
                                          context: context,
                                          initialDate: subscription.startedOn,
                                          firstDate:
                                              DateTime.now().addYears(-5).date,
                                          lastDate: DateTime.now()
                                              .add(Duration(minutes: 10)),
                                        ) ??
                                        DateTime.now());
                              },
                              child: Text(
                                subscription.startedOn.toString().split(" ")[0],
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
                                subscription.renewsEveryValue,
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
                                subscription.notificationOnValue,
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
              );
            }),
    );
  }

  void _showDatePicker(ctx, AddSubDetailsViewModel model) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    showCupertinoModalPopup(
      context: ctx,
      builder: (context) => Container(
        color: AppColor.STLight,
        height: 300,
        child: Stack(
          children: [
            Container(
              height: 280,
              child: CupertinoDatePicker(
                initialDateTime: model.subscription.startedOn,
                onDateTimeChanged: model.setDate,
                maximumDate: DateTime.now().add(Duration(minutes: 10)),
                maximumYear: DateTime.now().year,
                minimumDate: DateTime.now().addYears(-5).date,
                mode: CupertinoDatePickerMode.date,
              ),
            ),
            // Close the modal
            Align(
              alignment: Alignment.topRight,
              child: CupertinoButton(
                child: Text('Close'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
