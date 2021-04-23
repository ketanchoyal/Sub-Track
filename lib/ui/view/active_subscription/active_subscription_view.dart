import 'package:coast/coast.dart';
import 'package:flutter/cupertino.dart';
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
      builder: (context, model, child) => CupertinoPageScaffold(
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
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Active",
                        style: kTitleStyle.copyWith(color: AppColor.STDark),
                      ),
                      GestureDetector(
                        onTap: () {
                          // SystemChrome.setEnabledSystemUIOverlays(
                          //     SystemUiOverlay.values);
                          model.pop();
                        },
                        child: Icon(
                          CupertinoIcons.xmark_circle_fill,
                          size: 30,
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
                        itemCount: model.subscriptions.length,
                        itemBuilder: (context, index) {
                          print(index);
                          if (model.subscriptions[index].renewsEvery ==
                              RenewsEvery.Never) {
                            return Container();
                          }

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
    );
  }
}
