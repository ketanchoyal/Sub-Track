import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/app/app.router.dart';
import 'package:sub_track/ui/dumb_widgets/cupertino_modal_container.dart';
import 'package:sub_track/ui/services/ui_services.dart';

class NewSubscription extends StatefulWidget {
  @override
  _NewSubscriptionState createState() => _NewSubscriptionState();
}

class _NewSubscriptionState extends State<NewSubscription> {
  bool isDialogPopped = false;
  UIServices _uiServices = locator<UIServices>();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      /// Only allow to be scrolled down up to half size of the child
      minChildSize: 0.50,

      /// Show full screen by default
      initialChildSize: 1,
      builder: (context, controller) {
        _uiServices.scrollController = controller;
        return CupertinoBottomSheetContainer(
          child: NotificationListener<DraggableScrollableNotification>(
            onNotification: (DraggableScrollableNotification notification) {
              if (!isDialogPopped &&
                  notification.extent == notification.minExtent) {
                isDialogPopped = true;
                Navigator.of(context).pop();
              }
              return false;
            },
            child: Navigator(
              onGenerateRoute: NewSubscriptionRouter().onGenerateRoute,
              key: StackedService.nestedNavigationKey(2),
            ),
          ),
        );
      },
    );
  }
}
