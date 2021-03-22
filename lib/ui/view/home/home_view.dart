import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:sub_track/core/models/brands.dart';
import 'package:sub_track/core/models/subscription.dart';
import 'package:sub_track/ui/dumb_widgets/active_subscription_card.dart';
import 'package:sub_track/ui/dumb_widgets/buttons.dart';
import 'package:sub_track/ui/dumb_widgets/upcomming_subscription_card.dart';
import 'package:sub_track/ui/resources/resources.dart';
import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/ui/theme/app_colors.dart';
import './home_viewmodel.dart';
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

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              CupertinoSliverNavigationBar(
                border: Border(bottom: BorderSide.none),
                transitionBetweenRoutes: true,
                largeTitle: Text(
                  'Summary',
                ),
                padding: EdgeInsetsDirectional.only(end: 5),
                trailing: CircleAvatar(
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
                                  "\$55.2",
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                graphElement(50, "JAN"),
                                graphElement(90, "FEB"),
                                graphElement(40, "MAR"),
                                graphElement(80, "APR"),
                                graphElement(100, "MAY"),
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
                        style:
                            kBodyBoldStyle.copyWith(color: AppColor.STAccent),
                      )
                    ],
                  ).paddingH(20),
                  Container(
                    // height: 160,
                    width: context.screenWidth,
                    child: VxSwiper.builder(
                      enableInfiniteScroll: false,
                      itemCount: 5,
                      isFastScrollingEnabled: true,
                      scrollDirection: Axis.horizontal,
                      enlargeCenterPage: true,
                      viewportFraction: 0.45,
                      height: 185,
                      autoPlayAnimationDuration: Duration(milliseconds: 400),
                      initialPage: 1,
                      itemBuilder: (contex, index) => STUpcommingSub(
                        subsription: Subsription(
                          brand: Brand(
                            title: "Netflix",
                            hex: "E50914",
                            source:
                                "https://brand.netflix.com/en/assets/brand-symbol",
                            iconName: "netflix.svg",
                            iconUrl:
                                "https://raw.githubusercontent.com/ketanchoyal/simple-icons/master/icons/netflix.svg",
                          ),
                          cost: 18.99,
                          repeatEvery: "Month",
                          startedOn: DateTime.now(),
                          notificationOn: "Same Day",
                        ),
                      ),
                    ),
                    // ListView.builder(
                    //   scrollDirection: Axis.horizontal,
                    //   itemCount: 5,
                    //   itemBuilder: (contex, index) => STUpcommingSub(
                    //     name: "Google",
                    //     colorHex: "000000",
                    //     iconAsset: AppIconsAssets.google,
                    //     percentage: 30,
                    //     price: 18.99,
                    //     remainingDays: 18,
                    //     repeatEvery: "Month",
                    //   ),
                    // ),
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
                        style:
                            kBodyBoldStyle.copyWith(color: AppColor.STAccent),
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
                        itemCount: 5,
                        itemBuilder: (context, index) => STActiveSubCard(
                          subsription: Subsription(
                            brand: Brand(
                              title: "Netflix",
                              hex: "E50914",
                              source:
                                  "https://brand.netflix.com/en/assets/brand-symbol",
                              iconName: "netflix.svg",
                              iconUrl:
                                  "https://raw.githubusercontent.com/ketanchoyal/simple-icons/master/icons/netflix.svg",
                            ),
                            cost: 18.99,
                            repeatEvery: "Month",
                            startedOn: DateTime.now(),
                            notificationOn: "Same Day",
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: FloatingActionButton(
                  backgroundColor: AppColor.STPureWhite,
                  autofocus: true,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(Assets.addIcon),
                  ),
                  onPressed: () {
                    model.navigateToAddSub();
                  },
                ),
              ),
              if (model.haveSubscriptions)
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
    );
  }
}
