import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:stacked/stacked.dart';
import 'package:sub_track/ui/dumb_widgets/active_subscription_card.dart';
import 'package:sub_track/ui/dumb_widgets/buttons.dart';
import 'package:sub_track/ui/dumb_widgets/text_fields.dart';
import 'package:sub_track/ui/resources/resources.dart';
import './startup_viewmodel.dart';

class StartupView extends StatefulWidget {
  @override
  _StartupViewState createState() => _StartupViewState();
}

class _StartupViewState extends State<StartupView> {
  late FocusNode _focusNode1;
  late FocusNode _focusNode2;

  @override
  Widget build(BuildContext context) {
    _focusNode1 = FocusNode();
    _focusNode2 = FocusNode();
    return ViewModelBuilder<StartupViewModel>.reactive(
      viewModelBuilder: () => StartupViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              STTextField(
                type: TextFieldType.VALID,
                focusNode: _focusNode1,
                nextFocusNode: _focusNode2,
              ),
              STTextField(
                type: TextFieldType.ERROR,
                focusNode: _focusNode2,
              ),
              STTextField(
                focusNode: FocusNode(),
                type: TextFieldType.DEFAULT,
                placeholder: "This is Disabled TextField",
              ),
              STButton(
                buttonText: "Apple",
                buttonType: ButtonType.PRIMARY,
                onPressed: () {},
                icon: Image.asset(
                  AppIconsAssets.apple,
                ),
              ),
              ActiveSubCard(
                name: "Google",
                colorHex: "000000",
                price: 18.99,
                iconAsset: AppIconsAssets.google,
                repeatEvery: "/m",
              ),
              ActiveSubCard(
                name: "Apple",
                colorHex: "CF3A26",
                price: 11.99,
                iconAsset:
                    "assets/subIcons/7769dafa_2055_11eb_adc1_0242ac120002.png",
                repeatEvery: "/m",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
