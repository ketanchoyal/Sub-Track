import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sub_track/core/models/brand/brand.dart';
import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/ui/theme/app_colors.dart';

class STAddSubCard extends StatelessWidget {
  STAddSubCard({
    Key? key,
    required this.brand,
    this.onTap,
  }) : super(key: key);

  final Brand brand;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    Color? bgColor = brand.hex.toColor();
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
          width: screenWidth(context),
          child: Card(
            elevation: 0,
            margin: EdgeInsets.all(0),
            color: (brand.hex.toColor() ?? AppColor.STAccent).darken(15),
            shape: kRoundedCardBorder(radius: 4),
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
                          brand.iconUrl!,
                          height: 35,
                          semanticsLabel: brand.title,
                          placeholderBuilder: (BuildContext context) =>
                              const CupertinoActivityIndicator(
                            animating: true,
                          ),
                          color: brand.hex.toColor()!.brighten(80),
                          // color: AppColor.STPureDark,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          brand.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: kBodyBoldStyle.copyWith(
                            // color: brand.hex.toColor()!.contrastOf(),
                            color: AppColor.STLight,
                          ),
                        ),
                      ),
                    ],
                  ),
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
