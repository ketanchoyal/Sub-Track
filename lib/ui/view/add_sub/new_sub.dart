import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.router.dart';
import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/ui/theme/app_colors.dart';

class NewSubscription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColor.STPureWhite,
      child: Navigator(
        onGenerateRoute: NewSubscriptionRouter().onGenerateRoute,
        key: StackedService.nestedNavigationKey(2),
      ),
      // child: ExtendedNavigator<NewSubscriptionRouter>(
      //   router: NewSubscriptionRouter(),
      //   navigatorKey: StackedService.nestedNavigationKey(2),
      // ),
    ).addModalContainer();
  }
}
