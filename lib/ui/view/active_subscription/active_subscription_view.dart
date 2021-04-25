import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:sub_track/core/models/subscription/subscription.dart';
import 'package:sub_track/ui/dumb_widgets/active_subscription_card.dart';
import 'package:sub_track/ui/dumb_widgets/text_fields.dart';
import 'package:sub_track/ui/dumb_widgets/textfield_outline.dart';
import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/ui/theme/app_colors.dart';
import 'package:sub_track/ui/view/active_subscription/widget/history.dart';
import './active_subscription_viewmodel.dart';

class ActiveSubscriptionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ActiveSubscriptionViewModel>.reactive(
      viewModelBuilder: () => ActiveSubscriptionViewModel(),
      builder: (context, model, child) => DismissiblePage(
        isFullScreen: true,
        // scrollController: controller,
        minScale: 0.7,
        onDismiss: model.pop,
        backgroundColor: Colors.transparent,
        direction: DismissDirection.horizontal,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(model.scale * 10),
          child: AspectRatio(
            aspectRatio: 1,
            child: CupertinoPageScaffold(
              child: Stack(
                children: [
                  Container(
                    // margin: EdgeInsets.symmetric(horizontal: 0),
                    decoration: BoxDecoration(
                      color: AppColor.STPureWhite,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).padding.top),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        SizedBox(
                          height: 90,
                          child: ListView.builder(
                            shrinkWrap: false,
                            // controller: controller,
                            scrollDirection: Axis.horizontal,
                            itemCount: model.subscriptions.length,
                            itemBuilder: (context, index) {
                              Subscription s = model.subscriptions[index];
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Transform.scale(
                                  scale: model.isCurrentSelected(s) ? 1.2 : 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      model.selectSub(s);
                                    },
                                    child: STActiveSubCard(
                                      isHorizontal: true,
                                      subsription: s,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              color: model.selectedSub.brand.hex.toColor(),
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(20),
                                right: Radius.circular(20),
                              ),
                              boxShadow: <BoxShadow>[
                                new BoxShadow(
                                  color: model.selectedSub.brand.hex.toColor()!,
                                  blurRadius: 8.0,
                                  offset: new Offset(0.0, 3.0),
                                ),
                              ],
                            ),
                            child: MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              child: ListView(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          model.selectedSub.brand.title,
                                          overflow: TextOverflow.ellipsis,
                                          style: kTitleStyle.copyWith(
                                            color: model.selectedSub.brand.hex
                                                .toColor()!
                                                .contrastOf(),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.person_outline_rounded,
                                            size: 30,
                                            semanticLabel: "Shared With",
                                            color: model.selectedSub.brand.hex
                                                .toColor()!
                                                .contrastOf(),
                                          ),
                                          Text(
                                            "${model.selectedSub.sharedWith}",
                                            style: kHeader3Style.copyWith(
                                              color: model.selectedSub.brand.hex
                                                  .toColor()!
                                                  .contrastOf(),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  verticalSpaceSmall,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: "\$",
                                                  style: kHeader3Style.copyWith(
                                                      color: model
                                                          .selectedSub.brand.hex
                                                          .toColor()!
                                                          .contrastOf()),
                                                ),
                                                TextSpan(
                                                  text: model.selectedSub.cost
                                                      .toString(),
                                                  style: kHeader3Style.copyWith(
                                                      color: model
                                                          .selectedSub.brand.hex
                                                          .toColor()!
                                                          .contrastOf()),
                                                ),
                                                TextSpan(
                                                  text: "/" +
                                                      model.selectedSub
                                                          .renewsEveryValue,
                                                  style: kSmallStyle.copyWith(
                                                      color: model
                                                          .selectedSub.brand.hex
                                                          .toColor()!
                                                          .contrastOf()),
                                                ),
                                              ],
                                            ),
                                          ),
                                          verticalSpaceSmall,
                                          RichText(
                                            text: TextSpan(
                                              style: kMediumStyle.copyWith(
                                                  color: model
                                                      .selectedSub.brand.hex
                                                      .toColor()!
                                                      .contrastOf()),
                                              children: [
                                                TextSpan(
                                                  text: "Next Billing in ",
                                                ),
                                                TextSpan(
                                                  text:
                                                      "${model.remainingDays ?? "N.A"}",
                                                ),
                                                TextSpan(
                                                  text:
                                                      " ${model.remainingDays == 1 ? "day" : "days"},",
                                                ),
                                                TextSpan(
                                                  text:
                                                      " ${DateFormat('dd MMM').format(model.selectedSub.startedOn)}.",
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (model.selectedSub.brand.source !=
                                          null)
                                        Container(
                                          height: 60,
                                          width: 60,
                                          child: Card(
                                            elevation: 0,
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.link_rounded,
                                                size: 30,
                                                color: model
                                                    .selectedSub.brand.hex
                                                    .toColor(),
                                              ),
                                              onPressed: model.openLink,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  verticalSpaceMedium,
                                  Text(
                                    "History",
                                    style: kHeader3Style.copyWith(
                                      color: model.selectedSub.brand.hex
                                          .toColor()!
                                          .contrastOf(),
                                    ),
                                  ),
                                  verticalSpaceTiny,
                                  Divider(
                                    color: model.selectedSub.brand.hex
                                        .toColor()!
                                        .contrastOf(),
                                  ),
                                  verticalSpaceRegular,
                                  Column(
                                    children: model
                                        .selectedSub.payments!.entries
                                        .map(
                                          (e) => History(
                                            title:
                                                model.selectedSub.brand.title,
                                            date: e.key,
                                            amount: e.value,
                                            color: model.selectedSub.brand.hex
                                                .toColor(),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
