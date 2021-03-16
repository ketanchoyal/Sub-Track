import 'package:flutter/material.dart';
import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/ui/theme/app_colors.dart';

class STAddSubCard extends StatelessWidget {
  STAddSubCard({
    Key? key,
    required this.name,
    required this.colorHex,
    required this.iconAsset,
    this.fontColor,
    this.onTap,
  }) : super(key: key);

  final String name;
  final String colorHex;
  late final Color? fontColor;
  final Function()? onTap;

  // TODO if icon is null then make icon using initial of sub
  final String iconAsset;

  @override
  Widget build(BuildContext context) {
    Color? bgColor = colorHex.toColor();
    if (bgColor != null) {
      // NOTE 0 for darkness and 1 for lightness
      // REVIEW
      double luminance = bgColor.computeLuminance();
    }
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 2,
          vertical: 1,
        ),
        child: SizedBox(
          height: 65,
          width: MediaQuery.of(context).size.width,
          child: Card(
            elevation: 0,
            margin: EdgeInsets.all(0),
            color: colorHex.toColor() ?? AppColor.STAccent,
            shape: kRoundedCardBorder(radius: 4),
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
                  child: Icon(
                    Icons.add,
                    size: 30,
                    color: AppColor.STLight,
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
