import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import './select_icon_viewmodel.dart';
import 'package:sub_track/ui/shared/shared.dart';

class SelectIconView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SelectIconViewModel>.reactive(
      viewModelBuilder: () => SelectIconViewModel(),
      builder: (context, model, child) => CupertinoPageScaffold(
        child: Stack(
          children: [],
        ),
      ).addModalContainer(),
    );
  }
}
