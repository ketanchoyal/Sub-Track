import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:stacked/stacked.dart';
import './add_sub_viewmodel.dart';

class AddSubView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddSubViewModel>.reactive(
      viewModelBuilder: () => AddSubViewModel(),
      builder: (context, model, child) => CupertinoPageScaffold(
        child: Container(),
      ),
    );
  }
}
