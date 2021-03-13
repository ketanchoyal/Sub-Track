import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sub_track/ui/shared/enums.dart';

import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/ui/theme/app_colors.dart';

class STButton extends StatelessWidget {
  const STButton({
    Key? key,
    this.buttonType = ButtonType.PRIMARY,
    required this.onPressed,
    this.buttonText,
    this.icon,
  }) : super(key: key);

  final ButtonType buttonType;
  final Function() onPressed;
  final String? buttonText;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: CupertinoTheme.of(context).copyWith(
        primaryColor:
            buttonType == ButtonType.PRIMARY || buttonType == ButtonType.ICON
                ? AppColor.STAccent
                : buttonType == ButtonType.SECONDARY
                    ? AppColor.STLight
                    : buttonType == ButtonType.TERTIARY
                        ? AppColor.STPureWhite
                        : AppColor.STAccentLight,
      ),
      child: CupertinoButton.filled(
        padding: EdgeInsets.symmetric(
          vertical: 14.0,
          horizontal: buttonType == ButtonType.ICON
              ? 14
              : icon == null
                  ? 40.0
                  : 32.0,
        ),
        disabledColor: AppColor.STAccentLight,
        alignment: Alignment.center,
        // minSize: 10,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null)
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: buttonType == ButtonType.ICON ? 30 : 25,
                    width: buttonType == ButtonType.ICON ? 30 : 25,
                    child: icon!,
                  ),
                  if (buttonType != ButtonType.ICON) horizontalSpaceSmall,
                ],
              ),
            if (buttonText != null)
              Text(
                buttonText!,
                textAlign: TextAlign.center,
                style: kBodyStyle.copyWith(
                  fontWeight: FontWeightX.bold,
                  color: buttonType == ButtonType.PRIMARY
                      ? AppColor.STPureWhite
                      : buttonType == ButtonType.DISABLED
                          ? AppColor.STLight
                          : AppColor.STAccent,
                ),
              ),
          ],
        ),
        onPressed: buttonType == ButtonType.DISABLED ? null : onPressed,
      ),
    );
  }
}
