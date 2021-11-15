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
    // SchedulerBinding.instance?.addPostFrameCallback((_) {
    //   ref.read(homeViewModelCNP).startupTasks();
    // });
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.read(homeViewModelCNP);
    // final isBusy = ref.watch(homeViewModelCNP.select((value) => value.isBusy));
    // final subscriptions =
    //     ref.watch(homeViewModelCNP.select((value) => value.subscriptions));
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
                    // onLongPress: model.startupTasks,
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
                    ref.refresh(allSubscriptionStreamProvider);
                    ref.refresh(upCommingSubscriptionsFutureProvider);
                    // await model.fetchSubs(refresh: true);
                  },
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: screenHeightPercentage(context, percentage: 1),
                    child: MediaQuery.removePadding(
                      removeTop: true,
                      context: context,
                      child: ListView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          SummaryWidget(),
                          verticalSpaceSmall,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          Consumer(builder: (context, ref, child) {
                            final upcomingSubs =
                                ref.watch(upCommingSubscriptionsFutureProvider);
                            return upcomingSubs.when(
                              data: (subs) {
                                return Container(
                                  height: 170,
                                  width: context.screenWidth,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: subs.length,
                                      itemBuilder: (contex, index) {
                                        if (subs[index].renewsEvery ==
                                            RenewsEvery.Never) {
                                          return Container();
                                        }
                                        return ProviderScope(
                                          overrides: [
                                            currentSubscription
                                                .overrideWithValue(subs[index]),
                                          ],
                                          child: const STUpcommingSub(
                                              // subsription: subs[index],
                                              // remaningDays:
                                              //     subs[index].remaningDays,
                                              ),
                                        );
                                      }),
                                );
                              },
                              error: (error, st, previous) {
                                return ErrorWidget(error);
                              },
                              loading: (previous) {
                                return Center(
                                  child: STLoading(),
                                );
                              },
                            );
                          }),
                          verticalSpaceSmall,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                "Active",
                                style: kHeader3Style,
                              ),
                              GestureDetector(
                                onTap: () {
                                  // model.navigateToActiveSub(
                                  //     subId:
                                  //         subscriptions.first.subscriptionId);
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
                            child: Consumer(builder: (context, ref, child) {
                              final subscriptionStream =
                                  ref.watch(allSubscriptionStreamProvider);

                              return subscriptionStream.when(
                                data: (subscriptions) {
                                  return MediaQuery.removePadding(
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
                                  );
                                },
                                error: (error, st, previous) {
                                  return ErrorWidget(error);
                                },
                                loading: (previous) {
                                  return Center(
                                    child: STLoading(),
                                  );
                                },
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
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
            // if (isBusy)
            //   Center(
            //     child: STLoading(),
            //   ),
            Consumer(
              builder: (context, ref, child) {
                final subscriptionStream =
                    ref.watch(allSubscriptionStreamProvider);

                return subscriptionStream.when(
                  data: (subscriptions) {
                    if (subscriptions.isEmpty)
                      return Positioned(
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
                      );
                    if (subscriptions.isNotEmpty)
                      return Positioned(
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
                      );

                    return SizedBox();
                  },
                  error: (error, st, previous) {
                    return ErrorWidget(error);
                  },
                  loading: (previous) {
                    return const SizedBox();
                  },
                );
              },
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
    final currentMonthExpenseFP = ref.watch(currentMonthExpenseFutureProvider);
    final averageFP = ref.watch(currentYearExpenseAverageFutureProvider);
    final graphDataFP = ref.watch(graphDataFutureProvider);
    // final currentMonthExpense = ref
    //     .watch(homeViewModelCNP.select((value) => value.currentMonthExpense));
    // final average =
    //     ref.watch(homeViewModelCNP.select((value) => value.average));
    // final graphData =
    //     ref.watch(homeViewModelCNP.select((value) => value.graphData));
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
                  currentMonthExpenseFP.when(
                    data: (currentMonthExpense) {
                      return Text(
                        "\$$currentMonthExpense",
                        style: kHeader2Style.copyWith(
                          color: AppColor.STDark,
                          letterSpacing: -1,
                        ),
                      );
                    },
                    error: (error, st, previous) {
                      return ErrorWidget(error);
                    },
                    loading: (previous) {
                      return Text(
                        "...",
                        style: kHeader2Style.copyWith(
                          color: AppColor.STDark,
                          letterSpacing: -1,
                        ),
                      );
                    },
                  ),
                  averageFP.when(
                    data: (average) {
                      return Text(
                        "avg. \$$average/m",
                        style: kSmallStyle.copyWith(
                          color: AppColor.STDarkLight,
                        ),
                      );
                    },
                    error: (error, st, _) {
                      return ErrorWidget(error);
                    },
                    loading: (_) {
                      return Text(
                        "avg. ../m",
                        style: kSmallStyle.copyWith(
                          color: AppColor.STDarkLight,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            // verticalSpaceLarge,
            graphDataFP.when(
              data: (graphData) {
                return Expanded(
                  flex: 9,
                  child: graphData.isEmpty
                      ? Center(child: Text("No Data Available"))
                      : ExpenseGraph(
                          data: graphData,
                        ),
                );
              },
              error: (error, st, _) {
                return Expanded(
                  flex: 9,
                  child: Center(
                    child: ErrorWidget(error),
                  ),
                );
              },
              loading: (_) {
                return Expanded(
                    flex: 9, child: Center(child: Text("No Data Available")));
              },
            ),
          ],
        ),
      ).paddingH(15).paddingV(10),
    );
  }
}
