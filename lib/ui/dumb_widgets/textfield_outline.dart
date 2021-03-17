import 'package:flutter/material.dart';
import 'package:sub_track/ui/dumb_widgets/text_fields.dart';
import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/ui/theme/app_colors.dart';

class STTextFieldOutline extends StatelessWidget {
  const STTextFieldOutline({
    Key? key,
    required this.child,
    this.icon,
    required this.title,
    this.helperText,
    this.enableDecoration = true,
  }) : super(key: key);

  final Widget child;
  final IconData? icon;
  final String title;
  final String? helperText;
  final bool enableDecoration;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: enableDecoration
          ? BoxDecoration(
              color: AppColor.STPureWhite.withOpacity(0.6),
              borderRadius: BorderRadius.circular(12),
            )
          : null,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              if (icon != null)
                Icon(
                  icon,
                  size: 25,
                  color: AppColor.STDark,
                ),
              if (icon != null) horizontalSpaceTiny,
              Text(
                title,
                style: kHeader3Style.copyWith(
                  color: AppColor.STDark,
                ),
              ),
            ],
          ),
          verticalSpaceTiny,
          child,
          if (helperText != null)
            Row(
              children: [
                horizontalSpaceTiny,
                Text(
                  helperText!,
                  style: kPreTitleStyle.copyWith(
                    color: AppColor.STDarkLight,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
