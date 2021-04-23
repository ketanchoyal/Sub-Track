import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:sub_track/core/enums/enums.dart';
import 'package:sub_track/ui/dumb_widgets/active_subscription_card.dart';
import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/ui/theme/app_colors.dart';
import './active_subscription_viewmodel.dart';

// FIXME Why no subscription in visible
class ActiveSubscriptionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ActiveSubscriptionViewModel>.reactive(
      viewModelBuilder: () => ActiveSubscriptionViewModel(),
      builder: (context, model, child) => DraggableScrollableSheet(

          /// Only allow to be scrolled down up to half size of the child
          minChildSize: 0.50,

          /// Show full screen by default
          initialChildSize: 1,
          builder: (context, controller) {
            return NotificationListener<DraggableScrollableNotification>(
              onNotification: (DraggableScrollableNotification notification) {
                print(notification.extent);
                if (!model.isDialogPopped &&
                    notification.extent == notification.minExtent) {
                  model.pop();
                }
                return false;
              },
              child: DismissiblePage(
                isFullScreen: true,
                // scrollController: controller,
                minScale: 0.7,
                onDismiss: model.pop,
                backgroundColor: Colors.transparent,
                direction: DismissDirection.horizontal,
                child: Hero(
                  tag: "list",
                  transitionOnUserGestures: true,
                  child: CupertinoPageScaffold(
                    child: Stack(
                      children: [
                        SafeArea(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 0),
                            decoration: BoxDecoration(
                              color: AppColor.STPureWhite,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).padding.top),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    "Active",
                                    style: kTitleStyle.copyWith(
                                        color: AppColor.STDark),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // SystemChrome.setEnabledSystemUIOverlays(
                                      //     SystemUiOverlay.values);
                                      model.pop();
                                    },
                                    child: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      size: 35,
                                    ),
                                  ),
                                ],
                              ).paddingH(20),
                            ),
                            // verticalSpaceSmall,
                            Flexible(
                              fit: FlexFit.tight,
                              child: MediaQuery.removePadding(
                                context: context,
                                removeTop: true,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    controller: controller,
                                    itemCount: model.subscriptions.length,
                                    itemBuilder: (context, index) {
                                      return STActiveSubCard(
                                        subsription: model.subscriptions[index],
                                      );
                                    }),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
