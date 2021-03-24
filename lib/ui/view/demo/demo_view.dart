import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:stacked/stacked.dart';
import 'package:sub_track/core/enums/enums.dart';
import 'package:sub_track/core/models/brand/brands.dart';
import 'package:sub_track/core/models/subscription/subscription.dart';
import 'package:sub_track/ui/dumb_widgets/active_subscription_card.dart';
import 'package:sub_track/ui/dumb_widgets/add_subscription_card.dart';
import 'package:sub_track/ui/dumb_widgets/buttons.dart';
import 'package:sub_track/ui/dumb_widgets/segment_controller.dart';
import 'package:sub_track/ui/dumb_widgets/text_fields.dart';
import 'package:sub_track/ui/dumb_widgets/upcomming_subscription_card.dart';
import 'package:sub_track/ui/resources/resources.dart';

import 'package:sub_track/ui/shared/shared.dart';
import 'demo_viewmodel.dart';

class DemoView extends StatefulWidget {
  @override
  _DemoViewState createState() => _DemoViewState();
}

class _DemoViewState extends State<DemoView> {
  late FocusNode _focusNode1;
  late FocusNode _focusNode2;
  late FocusNode _focusNode3;
  String selectedValue = "Label 1";

  @override
  void initState() {
    super.initState();
    _focusNode1 = FocusNode();
    _focusNode2 = FocusNode();
    _focusNode3 = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DemoViewModel>.reactive(
      viewModelBuilder: () => DemoViewModel(),
      builder: (context, model, child) => CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          transitionBetweenRoutes: false,
          middle: Text('Sub Track Widgets'),
        ),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            // mainAxisSize: MainAxisSize.max,
            children: [
              STTextField(
                type: TextFieldType.VALID,
                focusNode: _focusNode1,
                nextFocusNode: _focusNode2,
              ),
              verticalSpaceSmall,
              STTextField(
                type: TextFieldType.ERROR,
                focusNode: _focusNode2,
                nextFocusNode: _focusNode3,
              ),
              verticalSpaceSmall,
              STTextField(
                focusNode: _focusNode3,
                type: TextFieldType.DEFAULT,
                placeholder: "This is Default TextField",
              ),
              verticalSpaceSmall,
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  STButton(
                    buttonText: "Apple",
                    buttonType: ButtonType.PRIMARY,
                    onPressed: () {
                      model.navigate();
                    },
                    icon: Image.asset(
                      AppIconsAssets.apple,
                    ),
                  ),
                  verticalSpaceSmall,
                  STButton(
                    buttonText: "Normal Button",
                    buttonType: ButtonType.SECONDARY,
                    onPressed: () {},
                    // icon: Image.asset(
                    //   AppIconsAssets.apple,
                    // ),
                  ),
                ],
              ),
              STActiveSubCard(
                subsription: Subscription(
                  subscriptionId: "sfihewruiw",
                  brand: Brand(
                    title: "Netflix",
                    hex: "E50914",
                    source: "https://brand.netflix.com/en/assets/brand-symbol",
                    iconName: "netflix.svg",
                    iconUrl:
                        "https://raw.githubusercontent.com/ketanchoyal/simple-icons/master/icons/netflix.svg",
                  ),
                  cost: 18.99,
                  renewsEvery: RenewsEvery.Weekly,
                  startedOn: DateTime.now(),
                  notificationOn: NotifyOn.One_Day_Before,
                ),
              ),
              STActiveSubCard(
                subsription: Subscription(
                  subscriptionId: "sfihewruiw",
                  brand: Brand(
                    title: "Netflix",
                    hex: "E50914",
                    source: "https://brand.netflix.com/en/assets/brand-symbol",
                    iconName: "netflix.svg",
                    iconUrl:
                        "https://raw.githubusercontent.com/ketanchoyal/simple-icons/master/icons/netflix.svg",
                  ),
                  cost: 18.99,
                  renewsEvery: RenewsEvery.Weekly,
                  startedOn: DateTime.now(),
                  notificationOn: NotifyOn.One_Day_Before,
                ),
              ),
              // STAddSubCard(
              //   name: "Google",
              //   colorHex: "000000",
              //   iconAsset: AppIconsAssets.google,
              // ),
              // STAddSubCard(
              //   name: "Apple",
              //   colorHex: "CF3A26",
              //   iconAsset:
              //       "assets/subIcons/7769dafa_2055_11eb_adc1_0242ac120002.png",
              // ),
              STSegmentController<String>(
                children: {
                  "Label 1": "Label 1",
                  "Label 2": "Label 2",
                  "Label 3": "Label 3",
                },
                selectedValue: selectedValue,
                onValueChanged: (value) {
                  print(value);
                  selectedValue = value!;
                  setState(() {});
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  STUpcommingSub(
                    subsription: Subscription(
                      subscriptionId: "sfihewruiw",
                      brand: Brand(
                        title: "Netflix",
                        hex: "E50914",
                        source:
                            "https://brand.netflix.com/en/assets/brand-symbol",
                        iconName: "netflix.svg",
                        iconUrl:
                            "https://raw.githubusercontent.com/ketanchoyal/simple-icons/master/icons/netflix.svg",
                      ),
                      cost: 18.99,
                      renewsEvery: RenewsEvery.Weekly,
                      startedOn: DateTime.now(),
                      notificationOn: NotifyOn.One_Day_Before,
                    ),
                  ),
                  STUpcommingSub(
                    subsription: Subscription(
                      subscriptionId: "sfihewruiw",
                      brand: Brand(
                        title: "Netflix",
                        hex: "E50914",
                        source:
                            "https://brand.netflix.com/en/assets/brand-symbol",
                        iconName: "netflix.svg",
                        iconUrl:
                            "https://raw.githubusercontent.com/ketanchoyal/simple-icons/master/icons/netflix.svg",
                      ),
                      cost: 18.99,
                      renewsEvery: RenewsEvery.Weekly,
                      startedOn: DateTime.now(),
                      notificationOn: NotifyOn.One_Day_Before,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ).addModalContainer(additionalTopPadding: 100),
    );
  }
}
