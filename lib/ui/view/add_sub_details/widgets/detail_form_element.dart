import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sub_track/ui/theme/app_colors.dart';

class STDetailFormElement extends StatelessWidget {
  const STDetailFormElement({
    Key? key,
    required this.child,
    this.onTap,
  }) : super(key: key);

  final Widget child;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        // margin: EdgeInsets.only(right: 10, left: 10),
        decoration: BoxDecoration(
          color: AppColor.STLight,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.only(right: 5, left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            child,
            Icon(
              CupertinoIcons.chevron_right,
              size: 35,
              color: AppColor.STDarkLight,
            )
          ],
        ),
      ),
    );
  }
}
