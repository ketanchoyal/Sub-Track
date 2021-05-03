import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sub_track/core/enums/enums.dart';
import 'package:sub_track/core/models/subscription/subscription.dart';
import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/ui/theme/app_colors.dart';

import 'remainig_days_widget.dart';

class STUpcommingSub extends StatelessWidget {
  const STUpcommingSub({
    Key? key,
    required this.subsription,
    this.remaningDays,
  }) : super(key: key);

  final Subscription subsription;
  final int? remaningDays;

  // TODO if icon is null then make icon using initial of sub
  // TODO Make enum for repatation

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 160,
        width: 140,
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
                                  subsription.brand.iconUrl!,
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
                                text: "/" + subsription.renewsEveryInitial,
                                style: kPreTitleStyle.copyWith(
                                  color: AppColor.STDarkLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      verticalSpaceSmall,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.repeat_rounded,
                            size: 12,
                            color: AppColor.STDarkLight,
                          ),
                          Text(
                            "${DateFormat('dd MMMM').format(subsription.nextSubOn(remaningDays) ?? DateTime.now())}",
                            style: kPreTitleStyle.copyWith(
                              color: AppColor.STDarkLight,
                            ),
                          ),
                        ],
                      ),
                      verticalSpaceTiny,
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
                percent: remaningDays == null
                    ? null
                    : subsription.renewsEvery == RenewsEvery.Never
                        ? null
                        : (remaningDays!) /
                            (subsription.renewsEvery == RenewsEvery.Weekly
                                ? 7.0
                                : subsription.renewsEvery ==
                                        RenewsEvery.Biweekly
                                    ? 14.0
                                    : subsription.renewsEvery ==
                                            RenewsEvery.Monthly
                                        ? 30.5
                                        : subsription.renewsEvery ==
                                                RenewsEvery.Quarterly
                                            ? 90.0
                                            : subsription.renewsEvery ==
                                                    RenewsEvery.Half_yearly
                                                ? 182.5
                                                : subsription.renewsEvery ==
                                                        RenewsEvery.Yearly
                                                    ? 365.0
                                                    : 1.0),
                remainigDays: (remaningDays ?? "N.A").toString(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
