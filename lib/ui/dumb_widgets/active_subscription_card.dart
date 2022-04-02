import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sub_track/core/models/subscription/subscription.dart';
import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/ui/theme/app_colors.dart';

class STActiveSubCard extends StatelessWidget {
  STActiveSubCard({
    Key? key,
    required this.subsription,
    this.isHorizontal = false,
    this.isSelected = false,
  }) : super(key: key);

  // TODO set font color based on [liminance]
  // TODO if icon is null then make icon using initial of sub
  // TODO Make enum for repatation

  final Subscription subsription;
  final bool isHorizontal;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    Color? bgColor = subsription.brand.hex.toColor();
    if (bgColor != null) {
      // NOTE 0 for darkness and 1 for lightness
      // REVIEW
      double luminance = bgColor.computeLuminance();
    }
    return Padding(
      padding: isHorizontal
          ? const EdgeInsets.symmetric(
              horizontal: 5,
            )
          : const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 2,
            ),
      child: SizedBox(
        height: 70,
        width: isHorizontal ? 70 : screenWidth(context),
        child: Hero(
          tag: isSelected ? "fjncj " : subsription.subscriptionId,
          transitionOnUserGestures: true,
          child: Card(
            elevation: 5,
            color: subsription.brand.hex.toColor() ?? AppColor.STAccent,
            shape: kRoundedCardBorder(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 9,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: isHorizontal
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: isHorizontal
                              ? const EdgeInsets.all(0)
                              : const EdgeInsets.symmetric(horizontal: 15),
                          child: SvgPicture.network(
                            subsription.brand.iconUrl!,
                            height: isHorizontal ? 40 : 30,
                            color:
                                subsription.brand.hex.toColor()!.contrastOf(),
                          ),
                        ),
                      ),
                      if (!isHorizontal)
                        Expanded(
                          flex: 3,
                          child: Text(
                            subsription.brand.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: kBodyBoldStyle.copyWith(
                              color: AppColor.STLight,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                // if (!isHorizontal) Spacer(),
                if (!isHorizontal)
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "\$",
                              style: kBodyBoldStyle.copyWith(
                                  color: AppColor.STLight),
                            ),
                            TextSpan(
                              text: subsription.cost.toString(),
                              style: kBodyBoldStyle.copyWith(
                                  color: AppColor.STLight),
                            ),
                            TextSpan(
                              text: "/" + subsription.renewsEveryInitial,
                              style: kPreTitleStyle.copyWith(
                                  color: AppColor.STLight),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
