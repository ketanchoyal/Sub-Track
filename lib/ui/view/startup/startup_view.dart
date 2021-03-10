import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:stacked/stacked.dart';
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
        body: Center(),
      ),
    );
  }
}
