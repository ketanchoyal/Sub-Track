import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.router.dart';
import 'package:sub_track/ui/dumb_widgets/cupertino_modal_container.dart';
import './new_subscription_viewmodel.dart';

class NewSubscription extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DraggableScrollableSheet(
      /// Only allow to be scrolled down up to half size of the child
      minChildSize: 0.50,

      /// Show full screen by default
      initialChildSize: 1,
      builder: (context, controller) {
        ref.read(newSubscriptionViewModelCNP).scrollController = controller;

        return PlatformContainer(
          backgroundColor: Colors.transparent,
          child: NotificationListener<DraggableScrollableNotification>(
            onNotification: (DraggableScrollableNotification notification) {
              (ref.read(newSubscriptionViewModelCNP).animator as AnimatorKey)
                  .controller
                  .animateBack(
                    notification.extent,
                    duration: const Duration(milliseconds: 200),
                  );
              if (notification.extent == notification.minExtent) {
                ref.read(newSubscriptionViewModelCNP).pop();
              }
              return false;
            },
            child: Navigator(
              initialRoute: NewSubscriptionRoutes.addSubView,
              onGenerateRoute: NewSubscriptionRouter().onGenerateRoute,
              key: StackedService.nestedNavigationKey(2),
            ),
          ),
        );
      },
    );
  }
}
