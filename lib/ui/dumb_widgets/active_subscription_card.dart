import 'package:flutter/material.dart';
import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/ui/theme/app_colors.dart';

class STActiveSubCard extends StatelessWidget {
  STActiveSubCard({
    Key? key,
    required this.name,
    required this.colorHex,
    required this.price,
    required this.iconAsset,
    required this.repeatEvery,
    this.fontColor,
  }) : super(key: key);

  final String name;
  final String colorHex;
  final double price;

  // TODO set font color based on [liminance]
  late final Color? fontColor;

  // TODO if icon is null then make icon using initial of sub
  final String iconAsset;
  // TODO Make enum for repatation
  final String repeatEvery;

  @override
  Widget build(BuildContext context) {
    Color? bgColor = colorHex.toColor();
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
          color: colorHex.toColor() ?? AppColor.STAccent,
          shape: kRoundedCardBorder(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Image.asset(
                      iconAsset,
                      height: 30,
                    ),
                  ),
                  Text(
                    name,
                    style: kBodyBoldStyle.copyWith(
                      color: AppColor.STLight,
                    ),
                  ),
                ],
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
                        text: price.toString(),
                        style: kBodyBoldStyle.copyWith(color: AppColor.STLight),
                      ),
                      TextSpan(
                        text: "/" + repeatEvery,
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
