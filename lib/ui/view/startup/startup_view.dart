import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:stacked/stacked.dart';
import './startup_viewmodel.dart';

class StartupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartupViewModel>.reactive(
      viewModelBuilder: () => StartupViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Text("fdf"),
        ),
      ),
    );
  }
}
