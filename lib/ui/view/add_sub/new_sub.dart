import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.router.dart';
import 'package:sub_track/ui/shared/shared.dart';

class NewSubscription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: NewSubscriptionRouter().onGenerateRoute,
      key: StackedService.nestedNavigationKey(2),
    );
  }
}
