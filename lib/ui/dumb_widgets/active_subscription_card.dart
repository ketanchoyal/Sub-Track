import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sub_track/core/models/subscription/subscription.dart';
import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/ui/theme/app_colors.dart';

class STActiveSubCard extends StatelessWidget {
  STActiveSubCard({
    Key? key,
    required this.subsription,
  }) : super(key: key);

  // TODO set font color based on [liminance]
  // TODO if icon is null then make icon using initial of sub
  // TODO Make enum for repatation

  final Subscription subsription;

  @override
  Widget build(BuildContext context) {
    Color? bgColor = subsription.brand.hex.toColor();
    if (bgColor != null) {
      // NOTE 0 for darkness and 1 for lightness
      // REVIEW
      double luminance = bgColor.computeLuminance();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 2,
      ),
      child: SizedBox(
        height: 70,
        width: screenWidth(context),
        child: Card(
          elevation: 5,
          color: subsription.brand.hex.toColor() ?? AppColor.STAccent,
          shape: kRoundedCardBorder(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: SvgPicture.network(
                        subsription.brand.iconUrl!,
                        height: 30,
                        color: subsription.brand.hex.toColor()!.contrastOf(),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        subsription.brand.title,
                        style: kBodyBoldStyle.copyWith(
                          color: AppColor.STLight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "\$",
                        style: kBodyBoldStyle.copyWith(color: AppColor.STLight),
                      ),
                      TextSpan(
                        text: subsription.cost.toString(),
                        style: kBodyBoldStyle.copyWith(color: AppColor.STLight),
                      ),
                      TextSpan(
                        text: "/" + subsription.renewsEveryInitial,
                        style: kPreTitleStyle.copyWith(color: AppColor.STLight),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
