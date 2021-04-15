import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:io' as io;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:stacked/stacked.dart';
import 'package:sub_track/ui/dumb_widgets/active_subscription_card.dart';
import 'package:sub_track/ui/dumb_widgets/buttons.dart';
import 'package:sub_track/ui/dumb_widgets/upcomming_subscription_card.dart';
import 'package:sub_track/ui/resources/resources.dart';
import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/ui/theme/app_colors.dart';
import 'package:sub_track/ui/view/home/widgets/graph.dart';
import './home_viewmodel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeView extends StatelessWidget {
  Widget graphElement(double height, String month) => Flexible(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              month,
              style: kPreTitleStyle.copyWith(
                color: AppColor.STDarkLight,
              ),
            ),
            Flexible(
              child: Card(
                margin: EdgeInsets.symmetric(horizontal: 8),
                color: AppColor.STAccent,
                child: SizedBox(
                  height: height,
                  width: double.infinity,
                ),
              ),
            )
          ],
        ),
      );

  final bool showGraph = true;
  GlobalKey _globalKey = new GlobalKey();

  _capturePng(HomeViewModel model) async {
    try {
      print('inside');
      RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData!.buffer.asUint8List();
      model.saveImage(pngBytes);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _globalKey,
      child: ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        onModelReady: (model) {
          model.startupTasks();
        },
        createNewModelOnInsert: false,
        initialiseSpecialViewModelsOnce: true,
        fireOnModelReadyOnce: true,
        builder: (context, model, child) => CupertinoPageScaffold(
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
                if (model.image != null) Image.file(model.image!),
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
                                      "Paid so far",
                                      style: kSmallStyle.copyWith(
                                          color: AppColor.STDarkLight),
                                    ),
                                    Text(
                                      "\$${model.totalExpense}",
                                      style: kHeader2Style.copyWith(
                                        color: AppColor.STDark,
                                        letterSpacing: -1,
                                      ),
                                    ),
                                    Text(
                                      "avg. \$84.9/m",
                                      style: kSmallStyle.copyWith(
                                        color: AppColor.STDarkLight,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // verticalSpaceLarge,
                              Flexible(
                                flex: 9,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(child: BarChartSample4())
                                    // if (showGraph) graphElement(50, "JAN"),
                                    // if (showGraph) graphElement(90, "FEB"),
                                    // if (showGraph) graphElement(40, "MAR"),
                                    // if (showGraph) graphElement(80, "APR"),
                                    // if (showGraph) graphElement(100, "MAY"),
                                    // if (!showGraph)
                                    //   Expanded(
                                    //     child: Text(
                                    //       "Not enough data for graph",
                                    //       style: kBodyStyle,
                                    //       textAlign: TextAlign.center,
                                    //     ),
                                    //   )
                                  ],
                                ).paddingA(20),
                              ),
                              // verticalSpaceTiny,
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
                          itemBuilder: (contex, index) => STUpcommingSub(
                            subsription: model.subscriptions[index],
                            remaningDays: model.remainingDays(
                              subscription: model.subscriptions[index],
                            ),
                          ),
                        ),
                      ),
                      verticalSpaceSmall,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Active",
                            style: kHeader3Style,
                          ),
                          Text(
                            "See all",
                            style: kBodyBoldStyle.copyWith(
                                color: AppColor.STAccent),
                          )
                        ],
                      ).paddingH(20),
                      verticalSpaceSmall,
                      Flexible(
                        fit: FlexFit.tight,
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: model.subscriptions.length,
                            itemBuilder: (context, index) => STActiveSubCard(
                              subsription: model.subscriptions[index],
                            ),
                          ),
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
                      onPressed: () {
                        _capturePng(model);
                        model.navigateToAddSub();
                        // showCupertinoModalBottomSheet(
                        //   expand: true,
                        //   context: context,
                        //   backgroundColor: Colors.transparent,
                        //   builder: (context) => AddSubView(),
                        // );
                      },
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
                          onPressed: () {},
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
