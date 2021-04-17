import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:sub_track/core/enums/enums.dart';
import 'package:sub_track/ui/dumb_widgets/active_subscription_card.dart';
import 'package:sub_track/ui/dumb_widgets/buttons.dart';
import 'package:sub_track/ui/dumb_widgets/cupertino_modal_transition.dart';
import 'package:sub_track/ui/dumb_widgets/upcomming_subscription_card.dart';
import 'package:sub_track/ui/resources/resources.dart';
import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/ui/theme/app_colors.dart';
import 'package:sub_track/ui/view/home/widgets/graph.dart';
import './home_viewmodel.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) {
        model.startupTasks();
      },
      createNewModelOnInsert: false,
      initialiseSpecialViewModelsOnce: true,
      fireOnModelReadyOnce: true,
      disposeViewModel: false,
      builder: (context, model, child) => CupertinoModalTransition(
        animatorKey: model.animatorKey,
        child: CupertinoPageScaffold(
          // key: UIServices.homeViewKey,
          resizeToAvoidBottomInset: false,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                CupertinoSliverNavigationBar(
                  border: Border(bottom: BorderSide.none),
                  transitionBetweenRoutes: true,
                  largeTitle: Text(
                    'Summary',
                  ),
                  padding: EdgeInsetsDirectional.only(end: 5),
                  trailing: GestureDetector(
                    onLongPress: model.clean,
                    onTap: model.startupTasks,
                    // onTap: () {
                    //   if (model.animatorKey.controller.status ==
                    //       AnimationStatus.completed) {
                    //     model.animatorKey.controller.reverse();
                    //   } else
                    //     model.animatorKey.controller.forward();
                    // },
                    child: CircleAvatar(
                      backgroundColor: AppColor.STPureWhite.withOpacity(0.4),
                      radius: 18,
                      child: Center(
                        child: Text(
                          "KC",
                          style: kBodyBoldStyle.copyWith(
                            color: AppColor.STDark,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ];
            },
            floatHeaderSlivers: true,
            body: Stack(
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
                if (model.subscriptions.length > 0)
                  Column(
                    children: [
                      SizedBox(
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
                                      style: kSmallStyle.copyWith(
                                          color: AppColor.STDarkLight),
                                    ),
                                    Text(
                                      "\$${model.currentMonthExpense}",
                                      style: kHeader2Style.copyWith(
                                        color: AppColor.STDark,
                                        letterSpacing: -1,
                                      ),
                                    ),
                                    Text(
                                      "avg. \$${model.average}/m",
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
                                child: model.graphData.isEmpty
                                    ? Center(child: Text("No Data Available"))
                                    : ExpenseGraph(
                                        data: model.graphData,
                                      ),
                              ),
                            ],
                          ),
                        ).paddingH(15).paddingV(10),
                      ),
                      verticalSpaceSmall,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Upcomming",
                            style: kHeader3Style,
                          ),
                          Text(
                            "See all",
                            style: kBodyBoldStyle.copyWith(
                                color: AppColor.STAccent),
                          )
                        ],
                      ).paddingH(20),
                      Container(
                        height: 160,
                        width: context.screenWidth,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: model.subscriptions.length,
                            itemBuilder: (contex, index) {
                              if (model.subscriptions[index].renewsEvery ==
                                  RenewsEvery.Never) {
                                return Container();
                              }
                              return STUpcommingSub(
                                subsription: model.subscriptions[index],
                                remaningDays: model.remainingDays(
                                  subscription: model.subscriptions[index],
                                ),
                              );
                            }),
                      ),
                      verticalSpaceSmall,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Hero(
                            tag: "active",
                            transitionOnUserGestures: true,
                            child: Text(
                              "Active",
                              style: kHeader3Style,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
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
                      Flexible(
                        fit: FlexFit.tight,
                        child: Stack(
                          children: [
                            Hero(
                              tag: "background",
                              transitionOnUserGestures: true,
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: AppColor.STPureWhite,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                              ),
                            ),
                            MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              child: Hero(
                                tag: "list",
                                transitionOnUserGestures: true,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: model.subscriptions.length,
                                    itemBuilder: (context, index) {
                                      if (model.subscriptions[index]
                                              .renewsEvery ==
                                          RenewsEvery.Never) {
                                        return Container();
                                      }
                                      return STActiveSubCard(
                                        subsription: model.subscriptions[index],
                                      );
                                    }),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                if (model.subscriptions.length > 0)
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
                if (model.subscriptions.length == 0)
                  Align(
                    alignment: Alignment.center,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class ActiveSubscriptionView extends StatelessWidget {
//   const ActiveSubscriptionView(this.model, {Key? key}) : super(key: key);
//   final HomeViewModel model;

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//       child: SafeArea(
//         child: Stack(
//           children: [
//             Hero(
//               tag: "background",
//               transitionOnUserGestures: true,
//               child: Container(
//                 margin: EdgeInsets.symmetric(horizontal: 10),
//                 decoration: BoxDecoration(
//                   color: AppColor.STPureWhite,
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(15),
//                   ),
//                 ),
//               ),
//             ),
//             Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     Hero(
//                       tag: "active",
//                       transitionOnUserGestures: true,
//                       child: Text(
//                         "Active",
//                         style: kTitleStyle.copyWith(color: AppColor.STDark),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: model.$navigationService.back,
//                       child: Icon(
//                         CupertinoIcons.xmark_circle_fill,
//                         size: 30,
//                       ),
//                     ),
//                   ],
//                 ).paddingH(20),
//                 verticalSpaceSmall,
//                 Flexible(
//                   fit: FlexFit.tight,
//                   child: MediaQuery.removePadding(
//                     context: context,
//                     removeTop: true,
//                     child: Hero(
//                       tag: "list",
//                       transitionOnUserGestures: true,
//                       child: ListView.builder(
//                           shrinkWrap: true,
//                           itemCount: model.subscriptions.length,
//                           itemBuilder: (context, index) {
//                             if (model.subscriptions[index].renewsEvery ==
//                                 RenewsEvery.Never) {
//                               return Container();
//                             }
//                             return STActiveSubCard(
//                               subsription: model.subscriptions[index],
//                             );
//                           }),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
