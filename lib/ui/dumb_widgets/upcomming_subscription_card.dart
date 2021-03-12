import 'package:flutter/material.dart';
import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/ui/theme/app_colors.dart';

import 'remainig_days_widget.dart';

class STUpcommingSub extends StatelessWidget {
  const STUpcommingSub(
      {Key? key,
      required this.name,
      required this.colorHex,
      required this.percentage,
      required this.remainingDays,
      required this.price,
      required this.iconAsset,
      required this.repeatEvery})
      : super(key: key);

  final String name;
  final String colorHex;
  final double percentage;
  final int remainingDays;
  final double price;

  // TODO if icon is null then make icon using initial of sub
  final String iconAsset;
  // TODO Make enum for repatation
  final String repeatEvery;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 150,
        width: 130,
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
                color:
                    (colorHex.toColor() ?? AppColor.STAccent).withOpacity(0.1),
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
                                child: Image.asset(
                                  iconAsset,
                                  alignment: Alignment.center,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              name,
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
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "\$",
                              style: kBodyBoldStyle.copyWith(
                                color: AppColor.STDark,
                              ),
                            ),
                            TextSpan(
                              text: price.toString(),
                              style: kBodyBoldStyle.copyWith(
                                color: AppColor.STDark,
                              ),
                            ),
                            TextSpan(
                              text: "/" + repeatEvery,
                              style: kPreTitleStyle.copyWith(
                                color: AppColor.STDarkLight,
                              ),
                            ),
                          ],
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
                color: colorHex.toColor() ?? AppColor.STAccent,
                percent: percentage / 100,
                remainigDays: remainingDays.toString(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
