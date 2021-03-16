import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import './add_sub_details_viewmodel.dart';
import 'package:sub_track/ui/shared/shared.dart';

class AddSubDetailsView extends StatelessWidget {
  final double _topPadding = 20;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddSubDetailsViewModel>.reactive(
      viewModelBuilder: () => AddSubDetailsViewModel(),
      onDispose: () {},
      builder: (context, model, child) => WillPopScope(
        onWillPop: () async {
          await model.resetpadding();
          return true;
        },
        child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            transitionBetweenRoutes: true,
            middle: Text("Spotify"),
          ),
          child: Stack(
            children: [],
          ),
        ).addNavigator().addModalContainer(
            additionalTopPadding: (model.data ?? 0) + _topPadding),
      ),
    );
  }
}
