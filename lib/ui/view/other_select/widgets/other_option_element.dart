import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sub_track/ui/shared/shared.dart';

class OtherOptionViewElement extends StatelessWidget {
  const OtherOptionViewElement({
    Key? key,
    required this.option,
    required this.onTap,
    this.selected = "",
  }) : super(key: key);

  final String option;
  final Function()? onTap;
  final String selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CupertinoFormRow(
        padding: EdgeInsets.zero,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                option,
                style: kBodyBoldStyle,
              ),
            ),
            if (selected == option)
              Icon(
                CupertinoIcons.checkmark_alt,
              ),
          ],
        ),
      ).paddingA(15),
    );
  }
}
