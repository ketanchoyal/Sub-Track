import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sub_track/ui/models/category.dart';
import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/ui/theme/app_colors.dart';

class SingleCategoryView extends StatelessWidget {
  const SingleCategoryView({
    Key? key,
    required this.category,
    required this.onTap,
    this.selected,
  }) : super(key: key);

  final Category category;
  final Function()? onTap;
  final String? selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CupertinoFormRow(
        padding: EdgeInsets.zero,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: category.hex.toColor(),
              child: Center(
                child: Icon(
                  category.icon,
                  color: AppColor.STPureWhite,
                ),
              ),
            ),
            horizontalSpaceSmall,
            Expanded(
              child: Text(
                category.name,
                style: kBodyBoldStyle,
              ),
            ),
            if (selected == category.name)
              Icon(
                CupertinoIcons.checkmark_alt,
              ),
          ],
        ),
      ).paddingH(10).paddingV(8),
    );
  }
}
