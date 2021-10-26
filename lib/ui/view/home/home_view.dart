import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sub_track/core/enums/enums.dart';
import 'package:sub_track/ui/dumb_widgets/active_subscription_card.dart';
import 'package:sub_track/ui/dumb_widgets/buttons.dart';
import 'package:sub_track/ui/dumb_widgets/cupertino_modal_transition.dart';
import 'package:sub_track/ui/dumb_widgets/loading.dart';
import 'package:sub_track/ui/dumb_widgets/upcomming_subscription_card.dart';
import 'package:sub_track/ui/resources/resources.dart';
import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/ui/theme/app_colors.dart';
import 'package:sub_track/ui/view/home/widgets/graph.dart';
import './home_viewmodel.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeView extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _HomeViewState();
  }
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      ref.read(homeViewModelCNP).startupTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.read(homeViewModelCNP);
    final isBusy = ref.watch(homeViewModelCNP.select((value) => value.isBusy));
    final subscriptions =
        ref.watch(homeViewModelCNP.select((value) => value.subscriptions));
    return CupertinoModalTransition(
      animatorKey: model.animatorKey,
      child: CupertinoPageScaffold(
        // key: UIServices.homeViewKey,
        resizeToAvoidBottomInset: true,
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: screenHeight(context),
                  width: screenWidth(context) * 0.35,
                  color: AppColor.STPureWhite.withOpacity(0.5),
                ),
              ],
            ),
            CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: <Widget>[
                CupertinoSliverNavigationBar(
                  border: Border(bottom: BorderSide.none),
                  transitionBetweenRoutes: true,
                  largeTitle: Text(
                    'Summary',
                  ),
                  padding: EdgeInsetsDirectional.only(end: 5),
                  trailing: GestureDetector(
                    onLongPress: model.startupTasks,
                    onTap: model.navigateToSettingView,
                    onDoubleTap: () {
                      model.clean();
                    },
                    child: CircleAvatar(
                      backgroundColor: AppColor.STPureWhite.withOpacity(0.4),
                      radius: 18,
                      child: Center(
                        child: Icon(
                          Icons.person,
                          // size: 40,
                        ),
                      ),
                    ),
                  ),
                ),
                CupertinoSliverRefreshControl(
                  builder: (context, mode, pulledExtent,
                      refreshTriggerPullDistance, refreshIndicatorExtent) {
                    return Center(
                      child: Container(
                        height: 50,
                        width: 50,
                        child: STLoading(),
                      ),
                    );
                  },
                  onRefresh: () async {
                    await model.fetchSubs(refresh: true);
                  },
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: screenHeightPercentage(context, percentage: 1),
                    child: subscriptions.isNotEmpty && !isBusy
                        ? MediaQuery.removePadding(
                            removeTop: true,
                            context: context,
                            child: ListView(
                              physics: NeverScrollableScrollPhysics(),
                              children: [
                                SummaryWidget(),
                                verticalSpaceSmall,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      "Upcomming",
                                      style: kHeader3Style,
                                    ),
                                    // Text(
                                    //   "See all",
                                    //   style: kBodyBoldStyle.copyWith(
                                    //       color: AppColor.STAccent),
                                    // )
                                  ],
                                ).paddingH(20),
                                Container(
                                  height: 170,
                                  width: context.screenWidth,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: model.upcommings.length,
                                      itemBuilder: (contex, index) {
                                        if (model.upcommings[index]
                                                .renewsEvery ==
                                            RenewsEvery.Never) {
                                          return Container();
                                        }
                                        return STUpcommingSub(
                                          subsription: model.upcommings[index],
                                          remaningDays: model.remainingDays(
                                            subscription:
                                                model.upcommings[index],
                                          ),
                                        );
                                      }),
                                ),
                                verticalSpaceSmall,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      "Active",
                                      style: kHeader3Style,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        model.navigateToActiveSub(
                                            subId: subscriptions
                                                .first.subscriptionId);
                                        // model.$navigationService.navigateWithTransition(
                                        //   ActiveSubscriptionView(model),
                                        //   popGesture: true,
                                        //   opaque: true,
                                        // );
                                      },
                                      child: Text(
                                        "See all",
                                        style: kBodyBoldStyle.copyWith(
                                            color: AppColor.STAccent),
                                      ),
                                    )
                                  ],
                                ).paddingH(20),
                                verticalSpaceSmall,
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: AppColor.STPureWhite,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  child: MediaQuery.removePadding(
                                    context: context,
                                    removeTop: true,
                                    removeBottom: true,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: subscriptions.length,
                                        itemBuilder: (context, index) {
                                          if (subscriptions[index]
                                                  .renewsEvery ==
                                              RenewsEvery.Never) {
                                            return Container();
                                          }
                                          return GestureDetector(
                                            onTap: () {
                                              model.navigateToActiveSub(
                                                  subId: subscriptions[index]
                                                      .subscriptionId);
                                            },
                                            child: STActiveSubCard(
                                              subsription: subscriptions[index],
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 50,
                  ),
                )
              ],
              shrinkWrap: false,
            ),
            if (isBusy)
              Center(
                child: STLoading(),
              ),
            if (subscriptions.isEmpty && !isBusy)
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                left: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "No Subscription Added",
                      style: kHeader3Style.copyWith(
                        color: AppColor.STDark,
                      ),
                    ),
                    Text(
                      "Add your subscriptions to see here",
                      style: kSmallStyle.copyWith(),
                    ),
                    verticalSpaceSmall,
                    STButton(
                      buttonText: "Add Subscription",
                      onPressed: model.navigateToAddSub,
                    )
                  ],
                ),
              ),
            if (subscriptions.isNotEmpty)
              Positioned(
                bottom: 20,
                right: 20,
                child: FloatingActionButton(
                  heroTag: "plusButton",
                  backgroundColor: AppColor.STPureWhite,
                  autofocus: true,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(Assets.addIcon),
                  ),
                  onPressed: model.navigateToAddSub,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class SummaryWidget extends ConsumerWidget {
  const SummaryWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMonthExpense = ref
        .watch(homeViewModelCNP.select((value) => value.currentMonthExpense));
    final average =
        ref.watch(homeViewModelCNP.select((value) => value.average));
    final graphData =
        ref.watch(homeViewModelCNP.select((value) => value.graphData));
    return SizedBox(
      height: 180,
      width: screenWidth(context),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 4,
        shape: kRoundedCardBorder(radius: 20),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            verticalSpaceSmall,
            Flexible(
              flex: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Paid this month",
                    style: kSmallStyle.copyWith(color: AppColor.STDarkLight),
                  ),
                  Text(
                    "\$${currentMonthExpense}",
                    style: kHeader2Style.copyWith(
                      color: AppColor.STDark,
                      letterSpacing: -1,
                    ),
                  ),
                  Text(
                    "avg. \$${average}/m",
                    style: kSmallStyle.copyWith(
                      color: AppColor.STDarkLight,
                    ),
                  ),
                ],
              ),
            ),
            // verticalSpaceLarge,
            Expanded(
              flex: 9,
              child: graphData.isEmpty
                  ? Center(child: Text("No Data Available"))
                  : ExpenseGraph(
                      data: graphData,
                    ),
            ),
          ],
        ),
      ).paddingH(15).paddingV(10),
    );
  }
}
