import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import './startup_viewmodel.dart';

class StartUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartUpViewModel>.reactive(
      viewModelBuilder: () => StartUpViewModel(),
      builder: (context, model, child) => Scaffold(),
    );
  }
}
