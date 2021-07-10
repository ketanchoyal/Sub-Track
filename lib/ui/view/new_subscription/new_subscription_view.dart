import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.router.dart';
import 'package:sub_track/ui/dumb_widgets/cupertino_modal_container.dart';
import './new_subscription_viewmodel.dart';

class NewSubscription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewSubscriptionViewModel>.reactive(
      viewModelBuilder: () => NewSubscriptionViewModel(),
      builder: (context, model, child) => DraggableScrollableSheet(
        /// Only allow to be scrolled down up to half size of the child
        minChildSize: 0.50,

        /// Show full screen by default
        initialChildSize: 1,
        builder: (context, controller) {
          model.scrollController = controller;

          return PlatformContainer(
            backgroundColor: Colors.transparent,
            child: NotificationListener<DraggableScrollableNotification>(
              onNotification: (DraggableScrollableNotification notification) {
                (model.animator as AnimatorKey)
                    .controller
                    .animateBack(notification.extent);
                if (!model.isDialogPopped &&
                    notification.extent == notification.minExtent) {
                  model.pop();
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
      ),
    );
  }
}
