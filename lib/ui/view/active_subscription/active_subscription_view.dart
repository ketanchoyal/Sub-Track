import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:sub_track/core/models/subscription/subscription.dart';
import 'package:sub_track/ui/dumb_widgets/active_subscription_card.dart';
import 'package:sub_track/ui/dumb_widgets/loading.dart';
import 'package:sub_track/ui/dumb_widgets/text_fields.dart';
import 'package:sub_track/ui/dumb_widgets/textfield_outline.dart';
import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/ui/theme/app_colors.dart';
import 'package:sub_track/ui/view/active_subscription/widget/history.dart';
import './active_subscription_viewmodel.dart';

class ActiveSubscriptionView extends ConsumerStatefulWidget {
  final String selectedSubId;

  const ActiveSubscriptionView({
    Key? key,
    required this.selectedSubId,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ActiveSubscriptionViewState();
}

class _ActiveSubscriptionViewState
    extends ConsumerState<ActiveSubscriptionView> {
  @override
  void initState() {
    super.initState();
    ref.read(activeSubscriptionViewModelCNP).init(widget.selectedSubId);
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.read(activeSubscriptionViewModelCNP);
    final isBusy = ref
        .watch(activeSubscriptionViewModelCNP.select((value) => value.isBusy));
    final selectedSub = ref.watch(
        activeSubscriptionViewModelCNP.select((value) => value.selectedSub));
    final remainingDays = ref.watch(
        activeSubscriptionViewModelCNP.select((value) => value.remainingDays));
    final startedOn = ref.watch(
        activeSubscriptionViewModelCNP.select((value) => value.startedOn));

    return DismissiblePage(
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
                      // verticalSpaceSmall,
                      Expanded(
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            color: selectedSub.brand.hex.toColor(),
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(20),
                              right: Radius.circular(20),
                            ),
                            boxShadow: <BoxShadow>[
                              new BoxShadow(
                                color: selectedSub.brand.hex.toColor()!,
                                blurRadius: 8.0,
                                offset: new Offset(0.0, 3.0),
                              ),
                            ],
                          ),
                          child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: Column(
                              children: [
                                Hero(
                                  tag: selectedSub.subscriptionId,
                                  child: Container(
                                    width: screenWidth(context),
                                    color: AppColor.STPureWhite,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: MediaQuery.of(context).padding.top,
                                        left: 20,
                                        right: 20,
                                      ),
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
                                              color: selectedSub.brand.hex
                                                  .toColor()!,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
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
                                              selectedSub.brand.title,
                                              overflow: TextOverflow.ellipsis,
                                              style: kTitleStyle.copyWith(
                                                color: selectedSub.brand.hex
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
                                                color: selectedSub.brand.hex
                                                    .toColor()!
                                                    .contrastOf(),
                                              ),
                                              Text(
                                                "${selectedSub.sharedWith}",
                                                style: kHeader3Style.copyWith(
                                                  color: selectedSub.brand.hex
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
                                                      style: kHeader3Style
                                                          .copyWith(
                                                              color: selectedSub
                                                                  .brand.hex
                                                                  .toColor()!
                                                                  .contrastOf()),
                                                    ),
                                                    TextSpan(
                                                      text: selectedSub.cost
                                                          .toString(),
                                                      style: kHeader3Style
                                                          .copyWith(
                                                              color: selectedSub
                                                                  .brand.hex
                                                                  .toColor()!
                                                                  .contrastOf()),
                                                    ),
                                                    TextSpan(
                                                      text: "/" +
                                                          selectedSub
                                                              .renewsEveryValue,
                                                      style:
                                                          kSmallStyle.copyWith(
                                                              color: selectedSub
                                                                  .brand.hex
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
                                                      color: selectedSub
                                                          .brand.hex
                                                          .toColor()!
                                                          .contrastOf()),
                                                  children: [
                                                    TextSpan(
                                                      text: "Next Billing in ",
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          "${remainingDays ?? "N.A"}",
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          " ${(remainingDays ?? 0) <= 1 ? "day" : "days"},",
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          " ${DateFormat('dd MMM').format(selectedSub.nextSubOn(remainingDays) ?? DateTime.now())}.",
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              verticalSpaceSmall,
                                              Text(
                                                "Subscription started on ${DateFormat('dd MMM yyyy').format(startedOn)}.",
                                                style: kMediumStyle.copyWith(
                                                    color: selectedSub.brand.hex
                                                        .toColor()!
                                                        .contrastOf()),
                                              ),
                                            ],
                                          ),
                                          if (selectedSub.brand.source != null)
                                            Container(
                                              height: 60,
                                              width: 60,
                                              child: Card(
                                                elevation: 0,
                                                child: IconButton(
                                                  icon: Icon(
                                                    Icons.link_rounded,
                                                    size: 30,
                                                    color: selectedSub.brand.hex
                                                        .toColor(),
                                                  ),
                                                  onPressed: model.openLink,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      verticalSpaceRegular,
                                      Text(
                                        "History",
                                        style: kHeader3Style.copyWith(
                                          color: selectedSub.brand.hex
                                              .toColor()!
                                              .contrastOf(),
                                        ),
                                      ),
                                      verticalSpaceTiny,
                                      Divider(
                                        color: selectedSub.brand.hex
                                            .toColor()!
                                            .contrastOf(),
                                      ),
                                      verticalSpaceRegular,
                                      isBusy
                                          ? Center(
                                              child: STLoading(),
                                            )
                                          : Column(
                                              children:
                                                  selectedSub.payments == null
                                                      ? []
                                                      : selectedSub
                                                          .payments!.entries
                                                          .map(
                                                            (e) => History(
                                                              title: selectedSub
                                                                  .brand.title,
                                                              date: e.key,
                                                              amount: e.value,
                                                              color: selectedSub
                                                                  .brand.hex
                                                                  .toColor(),
                                                            ),
                                                          )
                                                          .toList(),
                                            ),
                                      isBusy
                                          ? verticalSpaceRegular
                                          : verticalSpaceTiny,
                                      Divider(
                                        color: selectedSub.brand.hex
                                            .toColor()!
                                            .contrastOf(),
                                      ),
                                      verticalSpaceTiny,
                                      GestureDetector(
                                        onTap: () {
                                          model.deleteSub();
                                        },
                                        child: SizedBox(
                                          width: screenWidth(context),
                                          height: 50,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Delete",
                                                style: kHeader3Style.copyWith(
                                                  color: selectedSub.brand.hex
                                                      .toColor()!
                                                      .contrastOf(),
                                                ),
                                              ),
                                              Icon(
                                                Icons.delete_rounded,
                                                size: 30,
                                                color: selectedSub.brand.hex
                                                    .toColor()!
                                                    .contrastOf(),
                                              ),
                                            ],
                                          ).paddingH(5),
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
                      SafeArea(
                        top: false,
                        child: SizedBox(
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
                                      isSelected: model.isCurrentSelected(s),
                                      subsription: s,
                                    ),
                                  ),
                                ),
                              );
                            },
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
    );
  }
}
