import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/ui/theme/app_colors.dart';

enum ButtonType { PRIMARY, SECONDARY, TERTIARY, DISABLED }

class STButton extends StatelessWidget {
  const STButton({
    Key? key,
    this.buttonType = ButtonType.PRIMARY,
    required this.onPressed,
  }) : super(key: key);

  final ButtonType buttonType;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: CupertinoTheme.of(context).copyWith(
          primaryColor: buttonType == ButtonType.PRIMARY
              ? AppColor.STAccent
              : buttonType == ButtonType.SECONDARY
                  ? AppColor.STLight
                  : buttonType == ButtonType.TERTIARY
                      ? AppColor.STPureWhite
                      : AppColor.STAccentLight),
      child: CupertinoButton.filled(
        disabledColor: AppColor.STAccentLight,
        child: Text(
          "BUTTON",
          style: kBodyStyle.copyWith(
            fontWeight: FontWeightX.bold,
            color: buttonType == ButtonType.PRIMARY
                ? AppColor.STPureWhite
                : buttonType == ButtonType.DISABLED
                    ? AppColor.STLight
                    : AppColor.STAccent,
          ),
        ),
        onPressed: buttonType == ButtonType.DISABLED ? null : onPressed,
      ),
    );
  }
}
