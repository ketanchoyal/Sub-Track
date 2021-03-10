import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:stacked/stacked.dart';
import 'package:sub_track/ui/dumb_widgets/buttons.dart';
import 'package:sub_track/ui/dumb_widgets/text_fields.dart';
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
                buttonText: "Button",
                buttonType: ButtonType.SECONDARY,
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
