import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sub_track/core/models/subscription/subscription.dart';
import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/ui/theme/app_colors.dart';

import 'remainig_days_widget.dart';

class STUpcommingSub extends StatelessWidget {
  const STUpcommingSub({
    Key? key,
    required this.subsription,
  }) : super(key: key);

  final Subsription subsription;

  // TODO if icon is null then make icon using initial of sub
  // TODO Make enum for repatation

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 150,
        width: 150,
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              bottom: 2,
              left: 0,
              right: 3,
              child: Card(
                elevation: 2,
                color: AppColor.STPureWhite,
                shape: kRoundedCardBorder(),
              ),
            ),
            Positioned(
              top: 0,
              bottom: 2,
              left: 0,
              right: 3,
              child: Card(
                elevation: 0,
                color: (subsription.brand.hex.toColor() ?? AppColor.STAccent)
                    .withOpacity(0.1),
                shape: kRoundedCardBorder(),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 35,
                            height: 35,
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Center(
                                child: SvgPicture.network(
                                  subsription.brand.iconUrl,
                                  height: 40,
                                  alignment: Alignment.center,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              subsription.brand.title,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              textWidthBasis: TextWidthBasis.parent,
                              maxLines: 1,
                              style: kBodyBoldStyle.copyWith(
                                color: AppColor.STDark,
                              ),
                            ),
                          ),
                        ],
                      ),
                      verticalSpaceSmall,
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "\$",
                                style: kBodyBoldStyle.copyWith(
                                  color: AppColor.STDark,
                                ),
                              ),
                              TextSpan(
                                text: subsription.cost.toString(),
                                style: kBodyBoldStyle.copyWith(
                                  color: AppColor.STDark,
                                ),
                              ),
                              TextSpan(
                                text: "/" + subsription.repeatEvery,
                                style: kPreTitleStyle.copyWith(
                                  color: AppColor.STDarkLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      Text(
                        "Days \nRemaning",
                        style: kPreTitleStyle.copyWith(
                          color: AppColor.STDarkLight,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: STRemainingDaysWidget(
                color: subsription.brand.hex.toColor() ?? AppColor.STAccent,
                percent: 20 / 100,
                remainigDays: 20.toString(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
